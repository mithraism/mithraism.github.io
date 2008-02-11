<?php

class RecordManager
{
	public $table_name;

	// ---

	public function __construct($a_table_name)
	{
		$this->table_name = $a_table_name;
	}

	// ---

	public function find($a_id)
	{
		global $db_conn;

		// Escape everything needed in the query
		$table_name_s	= $db_conn->escape($this->table_name);
		$id_s			= $db_conn->escape($a_id);

		// Pass query on to find_all_by_sql
		$result = $this->find_all_by_sql(
			"SELECT * FROM $table_name_s WHERE id == $id_s LIMIT 1"
		);

		return $result === false ? false : $result[0];
	}

	public function find_all()
	{
		global $db_conn;

		// Escape everything needed in the query
		$table_name_s	= $db_conn->escape($this->table_name);

		// Pass query on to find_all_by_sql
		$result = $this->find_all_by_sql(
			"SELECT * FROM $table_name_s"
		);

		return $result === false ? false : $result;
	}

	public function find_all_by_sql($a_sql)
	{
		global $db_conn;

		// Escape everything needed in the query
		$table_name_s	= $db_conn->escape($this->table_name);

		// Perform query
		$result = $db_conn->query($a_sql);
		if($result === false)
			return false;

		// Get result rows
		$rows = $db_conn->fetch($result);

		// Convert rows to instances
		$instances = array();
		foreach($rows as $row)
			$instances[] = $this->from_row($row);
		return $instances;
	}
}

?>