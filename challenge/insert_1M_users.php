<?php

// User count
$user_count = 1000000;

// Query string for inserting users
$insert_query_format = "INSERT INTO Users (Id, FirstName) VALUES (%d, \"%s\")";

// Connect to db
$mysqli = new mysqli("localhost", "foo", "foo", "foo");

if ($mysqli->connect_errno) {
	echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}

// Drop the user table if exists
query("DROP TABLE IF EXISTS `Users`");

// Create user table
query("CREATE TABLE Users (Id INTEGER UNSIGNED, FirstName VARCHAR(20)) ENGINE = MEMORY");

$start = microtime(true); 
// Insert 1M users
echo "Inserting away!\n";
for($i=0; $user_count > $i; $i++) {
	$random_string = substr(md5(rand()),0,19);
	query(sprintf($insert_query_format, $i, $random_string));
	//file_put_contents ( "/dev/shm/test_data", $random_string, FILE_APPEND);

	if(($i+1) % 100000 == 0) {
		$end = (microtime(true) - $start);
		echo $i+1 . " users created in $end seconds.\n";	
	}
}

$end = (microtime(true) - $start);
echo "Elapsed time: $end seconds\n";
echo "Done!\n";

function query($str) {
	global $mysqli;
	if(!$mysqli->query($str)) {
		echo "Query failed: (" . $mysqli->errno . ") " . $mysqli->error . "\n";
	}
}
