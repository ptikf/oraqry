select 
sid,
serial# ser#,
username,
lockwait lckw,
blocking_session blk_sid,
schemaname,
osuser,
machine,
sql_exec_start,
ses.module,
logon_time,
event,wait_class,
ses.sql_id,
sqlt.sql_text 
 from v$session ses
 left join v$sql sqlt on ses.sql_id=sqlt.sql_id 
where 
type = 'USER' and status = 'ACTIVE' 
and wait_class <> 'Idle'
order by machine  ;

select * from table(dbms_xplan.display_cursor('gab432pq7cqxp'));

select * from v$session_longops where sid = 531 order by last_update_time desc ; 

SELECT t.name AS tablespace_name,
       o.object_name,
       SUM(DECODE(bh.status, 'free', 1, 0)) AS free,
       SUM(DECODE(bh.status, 'xcur', 1, 0)) AS xcur,
       SUM(DECODE(bh.status, 'scur', 1, 0)) AS scur,
       SUM(DECODE(bh.status, 'cr', 1, 0)) AS cr,
       SUM(DECODE(bh.status, 'read', 1, 0)) AS read,
       SUM(DECODE(bh.status, 'mrec', 1, 0)) AS mrec,
       SUM(DECODE(bh.status, 'irec', 1, 0)) AS irec
FROM   v$bh bh
       JOIN dba_objects o ON o.data_object_id = bh.objd
       JOIN v$tablespace t ON t.ts# = bh.ts#
GROUP BY t.name, o.object_name order by cr desc ; ;

/*
Status of the buffer:
    free - Not currently in use
    xcur - Exclusive
    scur - Shared current
    cr - Consistent read
    read - Being read from disk
    mrec - In media recovery mode
    irec - In instance recovery mode
    pi - A past image in RAC mode
    securefile - A secured file buffer
    flashfree - A free flash cache buffer
    flashcur - A current flash cache buffer
*/

SELECT o.object_name, COUNT(*) number_of_blocks
  FROM DBA_OBJECTS o, V$BH bh
 WHERE o.data_object_id = bh.OBJD
   AND o.owner != 'SYS'
 GROUP BY o.object_Name
 ORDER BY COUNT(*) desc ;



