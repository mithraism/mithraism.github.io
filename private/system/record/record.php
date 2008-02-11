<?php

class Record
{
	public $id;

	public function save()
	{
		if(!$this->id) // Insert
		{
			global $db_conn;

			// Get manager
			$manager = $this->get_record_manager();

			// Get attributes
			$attributes = $this->get_attributes();

			// Escape everything needed in the query
			$table_name_s	= $db_conn->escape($manager->table_name);
			$attributes_s	= array();
			foreach($attributes as $key => $value)
			{
				$key_s					= $db_conn->escape($key);
				$value_s				= $db_conn->escape($value);
				$attributes_s[$key_s]	= $value_s;
			}

			// Convert attributes into string
			$attribute_names_s	= implode(", ", array_keys($attributes_s));
			$attribute_values_s	= implode("', '", array_values($attributes_s));

			// Perform query
			$result = $db_conn->query(
				"INSERT INTO $table_name_s ($attribute_names_s) VALUES ('$attribute_values_s')"
			);

			return !$result ? false : true;
		}
		else // Update
		{
			global $db_conn;

			// Get manager
			$manager = $this->get_record_manager();

			// Get attributes
			$attributes = $this->get_attributes();

			// Escape everything needed in the query
			$table_name_s	= $db_conn->escape($manager->table_name);
			$id_s			= $db_conn->escape($this->id);
			$attributes_s	= array();
			foreach($attributes as $key => $value)
			{
				$key_s					= $db_conn->escape($key);
				$value_s				= $db_conn->escape($value);
				$attributes_s[$key_s]	= $value_s;
			}

			// Convert attributes into string
			$attribute_strings_s = array();
			foreach($attributes_s as $attribute_name_s => $attribute_value_s)
				$attribute_strings_s[] = "$attribute_name_s = '$attribute_value_s'";
			$attribute_string_s = implode(", ", $attribute_strings_s);

			// Perform query
			$result = $db_conn->query(
				"UPDATE $table_name_s SET $attribute_string_s WHERE id = $id_s"
			);

			return !$result ? false : true;
		}
	}
}

?>