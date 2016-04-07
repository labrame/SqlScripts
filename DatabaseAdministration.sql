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

--Make all object in contrib available without schema qualification
ALTER DATABASE mydb SET search_path="$user",public,contrib

--Permission
--defining permission on a schema
GRANT USAGE ON SCHEMA contrib TO public;
ALTER DEFAULT PRIVILEGES IN SCHEMA contrib
GRANT SELECT, REFERENCES ON TABLES TO public;

ALTER DEFAULT PRIVILEGES IN SCHEMA contrib
	GRANT SELECT, UPDATE ON SEQUENCES TO public;

ALTER DEFAULT PRIVILEGES IN SCHEMA contrib
	GRANT EXECUTE ON FUNCTIONS TO public;

ALTER DEFAULT PRIVILEGES IN SCHEMA contrib
	GRANT USAGE ON TYPES TO public; 

--setting permission on existing object
GRANT USAGE ON SCHEMA contrib TO public;
GRANT SELECT, REFERENCES, TRIGGER
	ON ALL TABLES IN SCHEMA contrib TO public;

GRANT EXECUTE ON ALL FUNCTION IN SCHEMA contrib TO public;
GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA contrib TO public;

--extension and contribs
--installed separatly in each database
--(use template to install extension under predefined specific schema)

--list of extension
SELECT *
FROM pg_available_extensions
WHERE comment LIKE '%string%' OR installed_version IS NOT NULL
ORDER BY name;

--get the details about an extension in psql (not tested)
\dx+ fuzzystrmatch

--or run the query
SELECT pg_catalog.pg_describe_object(d.classid, d.objid, 0) AS description
FROM pg_catalog.pg_depend AS D
	INNER JOIN pg_extension AS E ON D.refobjid = E.oid
WHERE D.refclassid = 'pg_catalog.pg_extension'::pg_catalog.regclass
	AND deptype = 'e'
