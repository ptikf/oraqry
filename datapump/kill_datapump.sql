select * from dba_datapump_jobs;

SET lines 200
COL owner_name FORMAT a10
COL job_name FORMAT a20
COL state FORMAT a12
COL operation format A12
COL job_mode format A12

-- locate Data Pump jobs:
SELECT owner_name, job_name, operation, job_mode,
state, attached_sessions
FROM dba_datapump_jobs
WHERE job_name NOT LIKE 'BIN$%'
ORDER BY 1,2; 


	 
-- Obtain Data Pump process info:
set lines 150 pages 100 numwidth 7
col DATE for A20
col program for a25
col username for a10
col status for A10
col spid for a10
col job_name for A20
col sql_id for A15
select 
to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') "DATE", 
s.program, 
s.sid,  
s.serial#,
s.status, 
s.username, 
d.job_name, 
s.sql_id
--p.spid, 
--p.pid  
from v$session s, v$process p, dba_datapump_sessions d 
where p.addr=s.paddr and s.saddr=d.saddr; 

---------------------------------------------------------------------------------------------
-- 
-- Purge datapumps terminés
--   
SELECT owner_name, job_name, operation, job_mode, state, attached_sessions FROM dba_datapump_jobs WHERE job_name NOT LIKE 'BIN$%' order by 1,2;   

SELECT o.status, o.object_id, o.object_type,
o.owner||'.'||object_name "OWNER.OBJECT"
FROM dba_objects o, dba_datapump_jobs j
WHERE o.owner=j.owner_name AND o.object_name=j.job_name
AND j.job_name NOT LIKE 'BIN$%' ORDER BY 4,2;

drop table SYS.SYS_EXPORT_FULL_01  ;

 
-------------------------------------
set lines 200
col "Index Operation" format a60 
col "ETA Mins" 		  format 999.99
col "Runtime Mins"    format 999.99
select 
sess.sid as "Sid", 
sql.sql_text as "Index Operation",
longops.totalwork, longops.sofar, 
longops.elapsed_seconds/60 as "Runtime Mins",
longops.time_remaining/60 as "ETA Mins"
from v$session sess, v$sql sql, v$session_longops longops
where
sess.sid=longops.sid
and sess.sql_address = sql.address
and sess.sql_address = longops.sql_address
and sess.status  = 'ACTIVE'
-- and longops.totalwork > longops.sofar
--and sess.sid not in ( SELECT sys_context('USERENV', 'SID') SID  FROM DUAL)
-- and upper(sql.sql_text) like '%INDEX%'
order by 3, 4;
	 
DECLARE
   h1 NUMBER;
BEGIN
   h1 := DBMS_DATAPUMP.ATTACH('SYS_EXPORT_SCHEMA_01','SYS');
   DBMS_DATAPUMP.STOP_JOB (h1,1,0);
END;
/