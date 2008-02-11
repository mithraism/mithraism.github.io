<?php

// Load application
require(dirname(__FILE__) . '/../private/application/application.php');

// Configuration
$spam_challenge_expected = "This site is called Stoneship.";

// E-mail checking function, mercilessly stolen from
// http://www.ilovejackdaniels.com/php/email-address-validation/#comment144
// Small stylistic modifications (mostly bracing style)
function is_well_formed_email_address($email) {
	// First, we check that there's one @ symbol, and that the lengths are right
	if(!ereg("^[^@]{1,64}@[^@]{1,255}$", $email))
	{
		// Email invalid because wrong number of characters in one section, or wrong number of @ symbols.
		return false;
	}

	// Split it into sections to make life easier
	$email_array = explode("@", $email);
	$local_array = explode(".", $email_array[0]);
	for($i = 0; $i < sizeof($local_array); $i++)
	{
	 	if(!ereg("^(([A-Za-z0-9!#$%&'*+/=?^_`{|}~-][A-Za-z0-9!#$%&'*+/=?^_`{|}~\.-]{0,63})|(\"[^(\\|\")]{0,62}\"))$", $local_array[$i]))
			return false;
	}  

	// Check if domain is IP. If not, it should be valid domain name
	if(!ereg("^\[?[0-9\.]+\]?$", $email_array[1]))
	{
		$domain_array = explode(".", $email_array[1]);
		if(sizeof($domain_array) < 2)
			return false; // Not enough parts to domain
	}
	for($i = 0; $i < sizeof($domain_array); $i++)
	{
		if (!ereg("^(([A-Za-z0-9][A-Za-z0-9-]{0,61}[A-Za-z0-9])|([A-Za-z0-9]+))$", $domain_array[$i]))
 			return false;
	}

	return true;
}

// Is a comment being posted?
if(@$_POST['comment_action'] === 'comment')
{
	// Get data
	$page_path				= $_POST['comment_page_path'];
	$poster_name			= $_POST['comment_poster_name'];
	$poster_email_address	= $_POST['comment_poster_email_address'];
	$poster_website_address	= $_POST['comment_poster_website_address'];
	$content				= $_POST['comment_content'];
	$spam_challenge			= $_POST['comment_spam_challenge'];

	// Check whether we're ajaxy or not
	$ajaxy = (isset($_POST['comment_ajaxy']) and $_POST['comment_ajaxy'] === 'true');

	// Validate data
	$errors = array();
	$errors_found = false;

	// Validate path
	if(!isset($page_path))
		die("Either there is a big bug in my comments system, or you're trying to haxor me. :(");

	// Validate name
	if(!isset($poster_name) or $poster_name === '')
	{
		$errors['comment_poster_name'] = 'empty';
		$errors_found = true;
	}
	else
		$errors['comment_poster_name'] = 'ok';

	// Validate email address
	if(!isset($poster_email_address) or $poster_email_address === '')
	{
		$errors['comment_poster_email_address'] = 'empty';
		$errors_found = true;
	}
	else if(!is_well_formed_email_address($poster_email_address))
	{
		$errors['comment_poster_email_address'] = 'invalid';
		$errors_found = true;
	}
	else
		$errors['comment_poster_email_address'] = 'ok';

	// Fix web site address if necessary
	if(isset($poster_website_address) and strlen($poster_website_address) > 0 and !strncmp($poster_website_address, 'http://', strlen('http://')) == 0)
		$poster_website_address = 'http://' . $poster_website_address;
	$errors['comment_poster_website_address'] = 'ok';

	// Validate content
	if(!isset($content) or $content === '')
	{
		$errors['comment_content'] = 'empty';
		$errors_found = true;
	}
	else
		$errors['comment_content'] = 'ok';

	// Validate spam challenge
	if($spam_challenge != $spam_challenge_expected)
	{
		$errors['comment_spam_challenge'] = 'invalid';
		$errors_found = true;
	}
	else
		$errors['comment_spam_challenge'] = 'ok';

	if(!$errors_found)
	{
		// Insert comment
		$comment = new Comment();
		$comment->poster_name				= $poster_name;
		$comment->poster_email_address		= $poster_email_address;
		$comment->poster_website_address	= $poster_website_address;
		$comment->content					= $content;
		$comment->page_path					= $page_path;
		$comment->posted_at					= time();
		$result = $comment->save();

		// Notify myself
		mail(
			'denis.defreyne@stoneship.org',
			'New comment on ' . $page_path,
			'There is a new comment on <http://stoneship.org' . $page_path . '>!'
		);

		// Provide feedback
		if($ajaxy)
		{
			if($result === true)
				echo json_encode(array('result' => 'ok'));
			else
				echo json_encode(array('result' => 'error', 'error' => $db_conn->get_last_error()));
		}
		else
		{
			if($result === true)
				echo '<p>Comment added. Thanks! <a href="' . $comment->page_path . '">Return to where you came from</a>.</p>';
			else
				echo '<p>Couldn\'t add your comment. Sorry. :(</p>';
		}
	}
	else
	{
		// Provide feedback
		if($ajaxy)
			echo json_encode(array('result' => 'error', 'errors' => $errors));
		else
			echo "<p>Couldn\'t add your comment. Make sure that all required fields are filled in and have the correct format.</p>";
	}
}
else
{
	echo "There is nothing for you to see here.";
}

?>