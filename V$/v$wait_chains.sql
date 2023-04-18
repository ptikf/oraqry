SELECT 
RPAD('+', LEVEL ,'-') || sid||' '||sess.module session_detail,
blocker_sid,
wait_event_text,
object_name,
RPAD(' ', LEVEL )||sql_text sql_text
FROM 
v$wait_chains c 
LEFT OUTER JOIN dba_objects o ON (row_wait_obj# = object_id)
JOIN v$session sess USING (sid)
LEFT OUTER JOIN v$sql sql ON (sql.sql_id = sess.sql_id AND sql.child_number = sess.sql_child_number)
CONNECT BY     PRIOR sid = blocker_sid
           AND PRIOR sess_serial# = blocker_sess_serial#
           AND PRIOR INSTANCE = blocker_instance
START WITH blocker_is_valid = 'FALSE'; 
