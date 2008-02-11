<?php

class DatabaseConnection
{
	function __construct()
	{
		global $config;

		$this->link = new mysqli(
			$config['database_host'],
			$config['database_username'],
			$config['database_password'],
			$config['database_name']
		);
	}

	// ---

	function escape($a_str)
	{
		return $this->link->escape_string($a_str);
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
		return $this->link->query($a_query);
	}

	function fetch($a_result)
	{
		$result = array();
		while($row = $a_result->fetch_assoc())
			$result[] = $row;
		return $result;
	}

	// ---

	function get_last_error()
	{
		return $this->link->error;
	}
}

?>