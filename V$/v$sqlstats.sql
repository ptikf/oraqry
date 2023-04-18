with t as (
select 
-- stats.* 
stats.inst_id i,
--stats.sql_text,
--stats.sql_fulltext,
stats.sql_id sql_id,
stats.last_active_time,
-- stats.last_active_child_address,
-- stats.plan_hash_value,
stats.parse_calls parse ,
stats.disk_reads reads,
stats.direct_writes,
stats.buffer_gets get ,
stats.rows_processed rows_proc ,
-- stats.serializable_aborts,
stats.fetches,
stats.executions,
stats.end_of_fetch_count,
stats.loads,
stats.version_count versc,
stats.invalidations inval,
stats.px_servers_executions px_srvs_execs ,
round(stats.cpu_time/1000/1000) cpu_s,
round(stats.elapsed_time/1000/1000) elapsed_s ,
stats.avg_hard_parse_time,
round(stats.application_wait_time/1000/1000) app_wt_s,
round(stats.concurrency_wait_time/1000/1000) lock_wt_s ,
round(stats.cluster_wait_time/1000/1000) clustw_s,
round(stats.user_io_wait_time/1000/1000) iowait_s,
-- stats.plsql_exec_time,
-- stats.java_exec_time,
stats.sorts,
--stats.sharable_mem,
--stats.total_sharable_mem,
--stats.typecheck_mem,
stats.IO_CELL_OFFLOAD_ELIGIBLE_BYTES,
round(stats.IO_INTERCONNECT_BYTES/1024/1024) io_interc_mb,
stats.PHYSICAL_READ_REQUESTS,
round(stats.physical_read_bytes/1000/1000) reads_mb,
stats.PHYSICAL_WRITE_REQUESTS,
stats.PHYSICAL_WRITE_bytes,
-- stats.exact_matching_signature,
-- stats.force_matching_signature,
stats.IO_CELL_UNCOMPRESSED_BYTES,
stats.IO_CELL_OFFLOAD_RETURNED_BYTES
from gv$sqlstats stats ) 
select * from t where sql_id = '1q9v98dh9c7up' union all 
select * from t where sql_id = '8uhdrpztnc6jk' union all 
select * from t where sql_id = 'gwz1ayqn92mpt' union all
select * from t where sql_id = '4su6h5905hca9' union all
select * from t where sql_id = '43mmc1x2nwghd' union all 
select * from t where sql_id = '66qa1rt82nhhn' union all
select * from t where sql_id = '9qmqa3uf94jvs' union all 
select * from t where sql_id = 'a9dgzsxm11v2z' union all 
select * from t where sql_id = '3h970x52svahy' union all
select * from t where sql_id = '8491auupdkf0k' union all
select * from t where sql_id = 'c4xj0ds82pmj2'
;