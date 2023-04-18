select * from v$instance_recovery ;

select 
to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin
,hr.RECOVERY_ESTIMATED_IOS recv_estim_ios  
,hr.ACTUAL_REDO_BLKS act_redo_blks
,hr.TARGET_REDO_BLKS tgr_redo_blks
,hr.LOG_FILE_SIZE_REDO_BLKS
,hr.LOG_CHKPT_TIMEOUT_REDO_BLKS
,hr.LOG_CHKPT_INTERVAL_REDO_BLKS
,hr.FAST_START_IO_TARGET_REDO_BLKS
,hr.TARGET_MTTR
,hr.ESTIMATED_MTTR
,hr.CKPT_BLOCK_WRITES
,hr.OPTIMAL_LOGFILE_SIZE
,hr.ESTD_CLUSTER_AVAILABLE_TIME
,hr.WRITES_MTTR
,hr.WRITES_LOGFILE_SIZE
,hr.WRITES_LOG_CHECKPOINT_SETTINGS
,hr.WRITES_OTHER_SETTINGS
,hr.WRITES_AUTOTUNE
,hr.WRITES_FULL_THREAD_CKPT
-- ,hr.CON_DBID
-- ,hr.CON_ID
from 
DBA_HIST_instance_recovery hr,
 dba_hist_snapshot T
 where 
 hr.snap_id = t.snap_id 
 -- and hr.estimated_mttr > 500
 and recovery_estimated_ios > 400
 order by t.begin_interval_time desc;


SELECT DISTINCT
CHECKPOINT_CHANGE#,
CHECKPOINT_TIME
FROM V$DATAFILE;