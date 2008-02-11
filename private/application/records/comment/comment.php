<?php

class Comment extends Record
{
	public $poster_name;
	public $poster_email_address;
	public $poster_website_address;
	public $content;
	public $page_path;
	public $posted_at;

	public function get_record_manager()
	{
		global $comment_manager;

		return $comment_manager;
	}

	public function get_attributes()
	{
		return array(
			'poster_name'				=> $this->poster_name,
			'poster_email_address'		=> $this->poster_email_address,
			'poster_website_address'	=> $this->poster_website_address,
			'content'					=> $this->content,
			'page_path'					=> $this->page_path,
			'posted_at'					=> $this->posted_at
		);
	}
}

?>