select 
lo.inst_id i,
lo.sid||','||lo.serial# sid_ser,
opname,
target,
-- target_desc,
sofar,totalwork,units,
start_time,last_update_time,
-- timestamp,
time_remaining remain,
elapsed_seconds elap,
-- context,
substr(message,1,50) message,
lo.sql_plan_operation plan_oper,
lo.sql_plan_options plan_opts,
lo.sql_plan_line_id id,
pl.ACCESS_PREDICATES,
pl.cardinality card,
username,
lo.sql_address,
lo.sql_hash_value,
lo.sql_id,
lo.sql_plan_hash_value plan_hash_value,
lo.sql_exec_start,
lo.sql_exec_id,
lo.qcsid
from gv$session_longops lo 
left outer join gv$sql_plan_statistics_all pl
on lo.sql_id=pl.sql_id and lo.sql_hash_value=pl.hash_value and lo.sql_plan_hash_value=pl.plan_hash_value and lo.sql_plan_line_id=pl.id and lo.INST_ID=pl.INST_ID
where lo.sql_id = 'dq71nvkdjrywr' order by last_update_time desc  ;


SELECT sl.sid,
       sl.serial#,
	   to_char(start_time,'YYYY/MM/DD HH24:MI:SS') start_time,
	   to_char(LAST_UPDATE_TIME,'YYYY/MM/DD HH24:MI:SS') last_update,
       ROUND(sl.elapsed_seconds/60) || ':' || MOD(sl.elapsed_seconds,60) elapsed,
       ROUND(sl.time_remaining/60) || ':' || MOD(sl.time_remaining,60) remaining,
       ROUND(sl.sofar/sl.totalwork*100, 1) pct,
	   units,
	   sql_id,
	   opname
FROM   v$session_longops sl;

SELECT 
b.username, 
a.sid, 
b.opname, 
b.target,
round(b.SOFAR*100/b.TOTALWORK,0) || '%' as "%DONE", 
b.TIME_REMAINING,
to_char(b.start_time,'YYYY/MM/DD HH24:MI:SS') start_time,
a.sql_id 
FROM v$session_longops b, v$session a
WHERE a.sid = b.sid ORDER BY 6;

select 
sid,serial# ser,
-- opname,
username,
target, 
--target_desc,
to_char(start_time,'YY/MM/DD HH24:MI:SS') startt,
to_char(last_update_time,'HH24:MI:SS') lastupd,
time_remaining rem,
elapsed_seconds elap,
sql_id,
message msg
from v$session_longops 
order by last_update_time desc ;
