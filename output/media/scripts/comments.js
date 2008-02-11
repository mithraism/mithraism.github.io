function blink(element)
{
	element.fadeTo(100, 0.5);
	element.fadeTo(100, 1.0);
	element.fadeTo(100, 0.5);
	element.fadeTo(100, 1.0);
}

$(document).ready(function() {
	// Get fields
	field_names = [
		'comment_poster_name',
		'comment_poster_email_address',
		'comment_poster_website_address',
		'comment_content',
		'comment_spam_challenge'
	];

	// Setup placeholders
	$.each(field_names, function(index, field_name) {
		// Get field
		field = $('#' + field_name);

		// Set field placeholder texts
		if(field.attr('title'))
		{
			field.val(field.attr('title'));
			field.attr('style', 'color:#888');
		}

		// Remove text on focus
		field.focus(function() {
			$(this).removeAttr('style');
			if(field.attr('title') != '' && $(this).attr('title') == $(this).val())
				$(this).val('');
		});

		// Add text on blur
		field.blur(function() {
			if(field.attr('title') != '' && $(this).val() == '')
			{
				$(this).val($(this).attr('title'));
				$(this).attr('style', 'color:#888');
			}
		});
	});

	// When the submit button is clicked...
	$('#submit').click(function() {
		// Get values necessary for post request
		var values = {
			'comment_poster_name':				$('#comment_poster_name').val(),
			'comment_poster_email_address':		$('#comment_poster_email_address').val(),
			'comment_poster_website_address':	$('#comment_poster_website_address').val(),
			'comment_page_path':				$('#comment_page_path').val(),
			'comment_content':					$('#comment_content').val(),
			'comment_ajaxy':					'true',
			'comment_action':					'comment',
			'comment_spam_challenge':			$('#comment_spam_challenge').val()
		};

		$.each(field_names, function(index, field_name) {
			if(values[field_name] == $('#' + field_name).attr('title'))
				// Get rid of placeholder values
				values[field_name] = '';
			else
				// Unset custom error styling
				$('#' + field_name).removeAttr('style');
		});

		// Remove any existing error messages
		$('.error-message').slideUp(150);
		$('.error-message').empty();

		// Make comment posting request
		$.post('/comments.php', values, function(data) {
			// Parse JSON-formatted reply
			eval('var reply = ' + data);

			if(reply['result'] == 'error')
			{
				// Get list of errors
				errors = reply['errors'];

				$.each(field_names, function(index, field_name) {
					// If field is wrong
					if(errors[field_name] != 'ok')
					{
						// Make field red
						$('#' + field_name).attr('style', 'background:#fcc;border:1px solid #f66;color:#c00');

						// Blink wrong field
						blink($('#' + field_name));
					}
				});
			}
			else
			{
				// Remove "no comments yet" message if present
				$("#no-comments-message").slideUp(150);
				$('#no-comments-message').empty();

				// Get values
				poster_name				= values['comment_poster_name'];
				poster_email_address	= values['comment_poster_email_address'];
				poster_website_address	= values['comment_poster_website_address'];
				if(poster_website_address.length != 0 && poster_website_address.substring(0, 'http://'.length) != 'http://')
					poster_website_address = 'http://' + poster_website_address;
				content					= values['comment_content'];

				// Append comment
				$('#comments-real').append(
					'<div class="comment" style="display:none">' +
					(
						poster_website_address == '' ?
						'<p><cite>' + poster_name + '</cite> wrote just now:</p>' :
						'<p><cite><a href="' + poster_website_address + '">' + poster_name + '</a></cite> wrote just now:</p>'
					) +
					'<blockquote><p>' + content.replace("\n\n", "</p><p>").replace("\n", "<br>") + '</p></blockquote>' +
				'</div>');

				// Reveal comment
				new_comment = $('#comments-real div:last');
				new_comment.slideDown(200);
				blink(new_comment);

				// Disable form
				$('#comment_poster_name').val('');
				$('#comment_poster_name').attr('disabled', 'disabled');
				$('#comment_poster_email_address').val('');
				$('#comment_poster_email_address').attr('disabled', 'disabled');
				$('#comment_poster_website_address').val('');
				$('#comment_poster_website_address').attr('disabled', 'disabled');
				$('#comment_content').val('(The comment form is now disabled. Thanks for your comment!)');
				$('#comment_content').attr('disabled', 'disabled');
				$('#submit').attr('disabled', 'disabled');
				$('#comment_spam_challenge').val('');
				$('#comment_spam_challenge').attr('disabled', 'disabled');
			}
		});

		// Prevent user from going to comment submit script
		return false;
	});
});
