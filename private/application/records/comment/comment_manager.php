<?php

class CommentManager extends RecordManager
{
	public function from_row($a_row)
	{
		$item = new Comment;

		$item->id						= $a_row['id'];
		$item->poster_name				= $a_row['poster_name'];
		$item->poster_email_address		= $a_row['poster_email_address'];
		$item->poster_website_address	= $a_row['poster_website_address'];
		$item->content					= $a_row['content'];
		$item->page_path				= $a_row['page_path'];
		$item->posted_at				= $a_row['posted_at'];

		return $item;
	}
}

$comment_manager = new CommentManager('comments');

?>