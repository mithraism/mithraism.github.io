<?php

class DatabaseConnection
{
	private $last_error;

	function __construct()
	{
		global $config;

		// Connect to the database
		$this->link = new SQLiteDatabase($config['database_path']);
	}

	// ---

	function escape($a_str)
	{
		return sqlite_escape_string($a_str);
	}

	// ---

	function begin_transaction()
	{
		;
	}

	function end_transaction()
	{
		;
	}

	// ---

	function query($a_query)
	{
		return $this->link->query($a_query, SQLITE_ASSOC, &$last_error);
	}

	function fetch($a_result)
	{
		return $a_result->fetchAll();
	}

	// ---

	function get_last_error()
	{
		return $last_error;
	}
}

?>