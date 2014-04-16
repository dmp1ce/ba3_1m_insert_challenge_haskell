-- Create User
GRANT ALL PRIVILEGES ON * . * TO 'foo'@'localhost' IDENTIFIED BY 'foo';
FLUSH PRIVILEGES;
-- Create Database
CREATE DATABASE IF NOT EXISTS foo;
-- Allow the memory engine to hold enough data for 1M users (256MB)
SET GLOBAL max_heap_table_size=268435456;
