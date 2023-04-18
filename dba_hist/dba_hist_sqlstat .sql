-- af94vvw5bhhwj

select sql_id, t.snap_id SNAP, to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
trunc(elapsed_time_total/1000000 ) elapT, 
trunc(elapsed_time_delta/1000000 ) elapD,
-- (trunc((elapsed_time_delta / executions_delta )+0.5)/1000) elapDU_ms,
rows_processed_total rowsT, -- rows_processed_delta rowsd,
version_count VerC,
executions_total ExecT, 
executions_delta ExecD,
disk_reads_total DskRT, 
disk_reads_delta DskRD,
buffer_gets_total GetsT, 
buffer_gets_delta getsD,
trunc(iowait_total/1000000/60)  IOWT,  -- iowait_delta iowaitD,
trunc(CCWAIT_TOTAL/1000000/60) ConcW, -- ConcurrencyW
sorts_total SortT,
plan_hash_value plan_hash,
optimizer_cost OPTCOST
 from dba_hist_sqlstat h, dba_hist_snapshot T
where sql_id = 'd92g8zrg7uu6r' and t.snap_id=h.snap_id  order by t.snap_id desc ;
-- 50zggzr4rgrw8 Interfacer tx T2 batch 
-- ffmds7gcbk8n2
-- af94vvw5bhhwj s_grille_tarifaire
-- d92g8zrg7uu6r