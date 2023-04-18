select text.sql_id, t.snap_id SNAP, to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
case when executions_delta > 0 then (trunc((elapsed_time_delta / executions_delta )+0.5)/1000) else 0 end as Ums,
case when executions_delta > 0 then trunc((buffer_gets_delta/ executions_delta)+0.5) else null end as gtu,
case when executions_delta > 0 then trunc((disk_reads_delta / executions_delta)+0.5) else null end as rdu ,
case when executions_delta > 0 then trunc((rows_processed_delta / executions_delta)+0.5) else null end as rwsu ,
case when executions_delta > 0 then trunc((iowait_delta / executions_delta / 1000 )+0.5) else null end as iowtU ,
case when executions_delta > 0 then trunc((apwait_delta / executions_delta / 1000 )+0.5) else null end as apwtU ,
executions_delta ExecD,
disk_reads_delta DskRD,
buffer_gets_delta getsD,
iowait_delta iowtD ,
trunc(elapsed_time_delta/1000000 ) elapD,
trunc(iowait_total/1000000/60)  IOWT,
trunc(CCWAIT_TOTAL/1000000/60) ConcW, -- ConcurrencyW
trunc(elapsed_time_total/1000000 ) elapT,
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
 dba_hist_snapshot T,
 dba_hist_sqltext text
where 
h.sql_id = 'fbvxmb5gm14g7'  and 
t.snap_id=h.snap_id 
-- and t.snap_id  = 10057
-- and t.snap_id between 10056 and 10058
and t.begin_interval_time >= to_date('01/09/2010 19:00','DD/MM/YYYY HH24:MI')
and 
-- text.sql_text like 'select%select distinct elementval0%'
text.sql_id=h.sql_id
-- and  to_char(t.begin_interval_time,'hh24mi' ) between '0300' and '0500'
order by t.snap_id desc 
-- and elapDU_ms > 10 
--and executions_delta > 100000 
;
;