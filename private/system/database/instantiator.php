<?php

// Find the right database connection
switch($config['database_type'])
{
	// MySQL Improved
	case 'mysqli':
		require(dirname(__FILE__) . '/drivers/mysqli_database_connection.php');
		break;

	// SQLite
	case 'sqlite':
		require(dirname(__FILE__) . '/drivers/sqlite_database_connection.php');
		break;
}

// Instantiate the database connection
$db_conn = new DatabaseConnection();

?>