select * from (
select 
t.dbid,t.snap_id SNAP,t.instance_number i, 
to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
h.sql_id, 
case when executions_delta>0 then round(elapsed_time_delta/executions_delta/1000) else 0 end as Ums,
case when executions_delta>0 then round(iowait_delta      /executions_delta/1000) else 0 end as iowtU ,
case when executions_delta>0 then round(cpu_time_delta    /executions_delta/1000) else 0 end as cpuU ,
case when executions_delta>0 then round(clwait_delta      /executions_delta/1000) else 0 end as clwtU ,
case when executions_delta>0 then round(ccwait_delta      /executions_delta/1000) else 0 end as ccwtU ,
case when executions_delta>0 then round(apwait_delta      /executions_delta/1000) else 0 end as apwtU ,
case when executions_delta>0 then round(buffer_gets_delta    / executions_delta)  else 0 end as gtu,
case when executions_delta>0 then round(disk_reads_delta     / executions_delta)  else 0 end as rdu ,
case when executions_delta>0 then round(rows_processed_delta / executions_delta)  else 0 end as rwsu ,
executions_delta ExecD,
disk_reads_delta DskRD,
buffer_gets_delta getsD,
iowait_delta iowtD ,
round(elapsed_time_delta/1000000 ) elapD,
round(iowait_total/1000000/60)  IOWT,
round(CCWAIT_TOTAL/1000000/60) ConcW, -- ConcurrencyW
round(elapsed_time_total/1000000 ) elapT,
executions_total ExecT,
rows_processed_total rowsT,
buffer_gets_total GetsT,
disk_reads_total DskRT,
sorts_total SortT,
loaded_versions loadedV,
loads_total loadT,
plan_hash_value plan_hash,
optimizer_cost cost,
optimizer_env_hash_value env_hvalue,
version_count ver,
optimizer_mode opt_mode,
sharable_mem shmem,
module,
action,
end_of_fetch_count_total
 from 
 dba_hist_sqlstat h, 
 dba_hist_snapshot T
where 
t.snap_id=h.snap_id and 
t.instance_number = h.instance_number and  
-- t.instance_number = 2 and  
t.dbid = h.dbid and 
h.sql_id = '1n7xtk778xgau' and 
-- and  to_char(t.begin_interval_time,'hh24mi' ) between '0300' and '0500' 
t.begin_interval_time >= to_date('01/09/2011 19:00','DD/MM/YYYY HH24:MI')
)
order by rwsu  desc   ;

select * from dba_hist_sqlstat ;

select * from dba_hist_sqlbind where sql_id = '1n7xtk778xgau' ;