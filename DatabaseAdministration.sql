--Find the location of configuration file
SELECT name, setting
FROM pg_settings
WHERE category = 'File Locations';

--Query postgresql.conf 
-- this file control the code settings of server instance and new database
SELECT
	name		--if postmaster require restart after change
	,context
	,unit
	,setting
	,boot_val
	,reset_val
FROM 
	pg_settings
WHERE
	name in ('listen_addresses'
		, 'max_connextions'
		, 'shared_buffers'
		, 'effective_cache_size'
		, 'work_mem'
		, 'maintenance_work_mem')
ORDER BY
	context
	,name;

--Role apply for both user and group some can loggin other cant
CREATE ROLE leo LOGIN PASSWORD 'lion!king'
CREATEDB VALID UNTIL 'infinity';

CREATE ROLE regina LOGIN PASSWORD 'queen!password'
SUPERUSER VALID UNTIL '2016-04-01 00:00';

CREATE ROLE jungle INHERIT;

GRANT jungle TO LEO;

--Create database
CREATE DATABASE mydb;

--Create database with template
CREATE DATABASE mydb TEMPLATE template0;

--Set the new database as template to allow user with CREATEDB role to create database
UPDATE pg_database SET datistemplate=true WHERE datname='mydb'

--Schema
CREATE SCHEMA contrib

--Make all object in contrin available without schema qualification
ALTER DATABASE mydb SET search_path="$user",public,contrib