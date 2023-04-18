rem *********************************************************** 
rem
rem File: parallel_queue.sql
rem Description: Show PQO SQLs executing and waiting (when 
rem              Oracle 11GR2 SQL statement queueing is in 
rem              effect)
rem   
rem     See www.guyharrison.net for further information
rem  
rem     This work is in the public domain NSA 
rem   
rem
rem ********************************************************* 

set pages 1000
set lines 100

col sid format 9999 heading "Sid" 
col username format a10 heading "Username"
col status format a10 heading "Status" 
col event format a25 heading "Waiting on"
col no_of_processes format 99 heading "# of PQ|Procs" noprint
col wait_time_ms format 99,999,999 heading "Wait|ms"
col sql_text format a20 heading "SQL Text"

set echo on 

WITH sessions AS
        (SELECT sess.sid, sess.username, 'Executing' status,
                event, sql_id, sql_child_number, no_of_processes,
                0 display_sequence, sess.wait_time_micro
          FROM  v$session sess JOIN
                  (SELECT qcsid, qcserial#, MAX(degree) degree,
                          MAX(req_degree) req_degree,
                          COUNT( * ) no_of_processes
                   FROM v$px_session p
                   GROUP BY qcsid, qcserial#) p
            ON (sess.sid = p.qcsid AND sess.serial# = p.qcserial#)
         UNION ALL
         SELECT sid, username,
                DECODE(LEVEL, 1, 'Next', 'Queued') status,
                wait_event_text, sql_id, sql_child_number,
                NULL no_of_processes, LEVEL display_sequence,
                sess.wait_time_micro
           FROM v$wait_chains c JOIN v$session sess USING (sid)
         CONNECT BY     PRIOR sid = blocker_sid
                    AND PRIOR sess_serial# = blocker_sess_serial#
                    AND PRIOR instance = blocker_instance
         START WITH blocker_is_valid = 'FALSE'
                AND wait_event_text = 'PX Queuing: statement queue')
SELECT sid, username, status, event, 
       ROUND(wait_time_micro / 1000) wait_time_ms, 
       SUBSTR(sql_text,1,80) sql_text
  FROM sessions sess JOIN v$sql sql
    ON (sql.sql_id = sess.sql_id
        AND sql.child_number = sess.sql_child_number)
 ORDER BY display_sequence, wait_time_micro DESC; 
