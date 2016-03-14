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

