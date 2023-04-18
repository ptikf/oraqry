-- (2) Most active session in last one hour can be found using active session history
SELECT sql_id,COUNT(*),ROUND(COUNT(*)/SUM(COUNT(*)) OVER(), 2) PCTLOAD
FROM gv$active_session_history
WHERE sample_time > SYSDATE - 1/24
AND session_type = 'BACKGROUND'
GROUP BY sql_id
ORDER BY COUNT(*) DESC;
SELECT sql_id,COUNT(*),ROUND(COUNT(*)/SUM(COUNT(*)) OVER(), 2) PCTLOAD
FROM gv$active_session_history
WHERE sample_time > SYSDATE - 1/24
AND session_type = 'FOREGROUND'
GROUP BY sql_id
ORDER BY COUNT(*) DESC;

-- (4) Most active session in last one hour
SELECT sql_id,COUNT(*),ROUND(COUNT(*)/SUM(COUNT(*)) OVER(), 2) PCTLOAD
FROM gv$active_session_history
WHERE sample_time > SYSDATE - 1/24
AND session_type = 'BACKGROUND'
GROUP BY sql_id
ORDER BY COUNT(*) DESC;SELECT sql_id,COUNT(*),ROUND(COUNT(*)/SUM(COUNT(*)) OVER(), 2) PCTLOAD
FROM gv$active_session_history
WHERE sample_time > SYSDATE - 1/24
AND session_type = 'FOREGROUND'
GROUP BY sql_id
ORDER BY COUNT(*) DESC;

-- (5) Most I/O intensive sql in last 1 hour
SELECT sql_id, COUNT(*)
FROM gv$active_session_history ash, gv$event_name evt
WHERE ash.sample_time > SYSDATE - 1/24
AND ash.session_state = 'WAITING'
AND ash.event_id = evt.event_id
AND evt.wait_class = 'User I/O'
GROUP BY sql_id
ORDER BY COUNT(*) DESC;

-- (9) Top session on CPU in last 15 minute

SELECT * FROM
(
SELECT s.username, s.module, s.sid, s.serial#, s.sql_id,count(*)
FROM v$active_session_history h, v$session s
WHERE h.session_id = s.sid
AND h.session_serial# = s.serial#
AND session_state= 'ON CPU' AND
sample_time > sysdate - interval '15' minute
GROUP BY s.username, s.module, s.sid, s.serial#,s.sql_id
ORDER BY count(*) desc
)
where rownum <= 10;

SELECT 
gnum, filnum, 
substr(concat('+'||gname,sys_connect_by_path(aname, '/')),1,100) name
FROM (SELECT g.name gname, a.parent_index pindex, a.name aname,a.reference_index rindex, a.group_number gnum,a.file_number filnum
FROM v$asm_alias a,v$asm_diskgroup g
WHERE a.group_number = g.group_number)
START WITH (mod(pindex, power(2, 24))) = 0 CONNECT BY PRIOR rindex = pindex;