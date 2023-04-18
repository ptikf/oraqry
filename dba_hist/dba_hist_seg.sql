select 
to_char(snap.begin_interval_time,'DD/MM/YYYY HH24:MI') begin,
-- seg.snap_id snap,
-- TS#,
o.object_name,
o.OBJ#, 
o.DATAOBJ#, 
LOGICAL_READS_DELTA logrdD, 
BUFFER_BUSY_WAITS_DELTA bf_bsywtD, 
DB_BLOCK_CHANGES_DELTA blk_chgD, 
PHYSICAL_READS_DELTA phyrdD, 
PHYSICAL_WRITES_DELTA phyWRD, 
PHYSICAL_READS_DIRECT_DELTA phyRD_D_D, 
PHYSICAL_WRITES_DIRECT_DELTA phyWT_D_D, 
ITL_WAITS_DELTA ITL_WTD, 
ROW_LOCK_WAITS_DELTA RLKWD, 
--ROW_LOCK_WAITS_TOTAL, 
--ITL_WAITS_TOTAL, 
--PHYSICAL_WRITES_DIRECT_TOTAL, 
--PHYSICAL_READS_DIRECT_TOTAL, 
-- PHYSICAL_WRITES_TOTAL, 
--PHYSICAL_READS_TOTAL, 
-- DB_BLOCK_CHANGES_TOTAL, 
-- BUFFER_BUSY_WAITS_TOTAL, 
-- LOGICAL_READS_TOTAL, 
--GC_CR_BLOCKS_SERVED_TOTAL, 
--GC_CR_BLOCKS_SERVED_DELTA, 
--GC_CU_BLOCKS_SERVED_TOTAL, 
--GC_CU_BLOCKS_SERVED_DELTA, 
--GC_BUFFER_BUSY_TOTAL, 
--GC_BUFFER_BUSY_DELTA, 
--GC_CR_BLOCKS_RECEIVED_TOTAL, 
--GC_CR_BLOCKS_RECEIVED_DELTA, 
--GC_CU_BLOCKS_RECEIVED_TOTAL, 
--GC_CU_BLOCKS_RECEIVED_DELTA, 
--SPACE_USED_TOTAL, 
--SPACE_USED_DELTA, 
-- SPACE_ALLOCATED_TOTAL, 
SPACE_ALLOCATED_DELTA spallocD, 
--TABLE_SCANS_TOTAL, 
TABLE_SCANS_DELTA TabScanD 
from 
dba_hist_seg_stat seg,
dba_hist_seg_stat_obj o
,dba_hist_snapshot snap
where 
snap.snap_id=seg.snap_id and 
snap.instance_number=seg.instance_number and 
snap.dbid = 601016237 and 
seg.obj#=o.obj# and 
seg.dataobj#=o.dataobj# 
and trunc(snap.begin_interval_time,'MI') = to_date('05/02/2013 15:30','DD/MM/YYYY HH24:MI')
order by PHYSICAL_READS_DELTA desc ; 
select 
obj.object_name,
to_char(snap.begin_interval_time,'DD/MM/YYYY HH24:MI') begin,
seg.* 
from 
dba_hist_seg_stat seg
-- left outer join dba_hist_seg_stat_obj obj on seg.obj#=obj.obj#
left outer join all_objects  obj on seg.obj#=obj.object_id 
left outer join dba_hist_snapshot snap on seg.snap_id=snap.snap_id
-- where snap.snap_id = 21818 
where snap.begin_interval_time >= to_date('26/08/2010 20:00','DD/MM/YYYY HH24:MI')
and snap.begin_interval_time <= to_date('27/08/2010 08:00','DD/MM/YYYY HH24:MI')
order by snap_id desc, logical_reads_total desc ; 


select 
trunc(BEGIN_INTERVAL_TIME,'MI') dt
,sum(decode(ts#, 0 ,logical_reads_DELTA,0))	"SYSTEM"
,sum(decode(ts#, 2 ,logical_reads_DELTA,0)) "SYSAUX"
,sum(decode(ts#, 5 ,logical_reads_DELTA,0))	"TBS_RMX_DATA_M"
,sum(decode(ts#, 7 ,logical_reads_DELTA,0)) "TBS_RMX_IDX_M"
,sum(decode(ts#, 9 ,logical_reads_DELTA,0)) "TBS_RMX_TOOLS"
,sum(decode(ts#, 11,logical_reads_DELTA,0))	"USERS"
,sum(decode(ts#, 12,logical_reads_DELTA,0))	"RMX_UNDO1"
,sum(decode(ts#, 13,logical_reads_DELTA,0))	"RMX_UNDO2"
,sum(decode(ts#, 14,logical_reads_DELTA,0))	"TBS_RMX_F2_DATA_M"
,sum(decode(ts#, 15,logical_reads_DELTA,0))	"TBS_RMX_F2_IDX_M"
,sum(decode(ts#, 17,logical_reads_DELTA,0))	"TBS_TIVOLI"
,sum(decode(ts#, 18,logical_reads_DELTA,0))	"TBS_RMX_KO_DATA_M"
,sum(decode(ts#, 19,logical_reads_DELTA,0))	"TBS_RMX_KO_IDX_M"
,sum(decode(ts#, 20,logical_reads_DELTA,0))	"TBS_SQLT"
from DBA_HIST_seg_stat seg, dba_hist_snapshot snap
where BEGIN_INTERVAL_TIME 
between 
to_date('2013/01/01 01:00','YYYY/MM/DD HH24:MI') and
to_date('2013/02/12 01:00','YYYY/MM/DD HH24:MI') 
and to_char(BEGIN_INTERVAL_TIME,'HH24MI') between '0800' and '2200'
and seg.snap_id= snap.snap_id 
and seg.dbid= snap.dbid
and seg.instance_number=snap.instance_number 
and snap.dbid = 601016237 
group by trunc(BEGIN_INTERVAL_TIME,'MI')
order by trunc(BEGIN_INTERVAL_TIME,'MI') ;

select * from dba_hist_snapshot where dbid = 601016237 
and begin_interval_time >= to_date('2013/01/01 01:00','YYYY/MM/DD HH24:MI')
order by begin_interval_time ;

select 
trunc(BEGIN_INTERVAL_TIME,'MI') dt
--,sum(decode(ts#, 0 ,logical_reads_DELTA,0))	"SYSTEM"
--,sum(decode(ts#, 2 ,logical_reads_DELTA,0)) "SYSAUX"
,sum(decode(ts#, 14,logical_reads_DELTA,0))	  "logical READS"
,sum(decode(ts#, 14,buffer_busy_waits_DELTA,0))	  "buffer busy waits"
,sum(decode(ts#, 14,physical_reads_DELTA,0))	"physical READS"
,sum(decode(ts#, 14,physical_writes_DELTA,0))	"physical WRITES"
,sum(decode(ts#, 14,physical_reads_direct_DELTA,0))	 "physical reads direct"
,sum(decode(ts#, 14,physical_writes_direct_DELTA,0)) "physical WRITES direct"
,sum(decode(ts#, 14,db_block_changes_DELTA,0))	"db_block_changes"
,sum(decode(ts#, 14,ITL_waits_DELTA,0))	"ITL waits "
,sum(decode(ts#, 14,row_lock_waits_DELTA,0))	"row lock waits"
,sum(decode(ts#, 14,GC_buffer_busy_DELTA,0))	"gc buffer busy"
--------------
,sum(decode(ts#, 14,GC_cr_blocks_served_DELTA,0)) "gc cr blocks served"
,sum(decode(ts#, 14,GC_cr_blocks_received_DELTA,0)) "gc cr blocks received"
,sum(decode(ts#, 14,GC_cu_blocks_served_DELTA,0)) "gc cr blocks served"
,sum(decode(ts#, 14,GC_cu_blocks_received_DELTA,0)) "gc cu blocks received"
,sum(decode(ts#, 14,GC_buffer_busy_DELTA,0))	"gc buffer busy"
--------------
,sum(decode(ts#, 14,chain_row_excess_delta,0))	"chain row excess"
,sum(decode(ts#, 14,physical_read_requests_DELTA,0))	"physical READS request"
,sum(decode(ts#, 14,physical_write_requests_DELTA,0))	"physical write request"
,sum(decode(ts#, 14,optimized_physical_reads_DELTA,0))	"optimized reads"
-- ,sum(decode(ts#, 5 ,logical_reads_DELTA,0))	"TBS_RMX_DATA_M"
-- ,sum(decode(ts#, 7 ,logical_reads_DELTA,0)) "TBS_RMX_IDX_M"
-- ,sum(decode(ts#, 9 ,logical_reads_DELTA,0)) "TBS_RMX_TOOLS"
-- ,sum(decode(ts#, 11,logical_reads_DELTA,0))	"USERS"
-- ,sum(decode(ts#, 12,logical_reads_DELTA,0))	"RMX_UNDO1"
-- ,sum(decode(ts#, 13,logical_reads_DELTA,0))	"RMX_UNDO2"
-- ,sum(decode(ts#, 15,logical_reads_DELTA,0))	"TBS_RMX_F2_IDX_M"
-- ,sum(decode(ts#, 17,logical_reads_DELTA,0))	"TBS_TIVOLI"
-- ,sum(decode(ts#, 18,logical_reads_DELTA,0))	"TBS_RMX_KO_DATA_M"
-- ,sum(decode(ts#, 19,logical_reads_DELTA,0))	"TBS_RMX_KO_IDX_M"
-- ,sum(decode(ts#, 20,logical_reads_DELTA,0))	"TBS_SQLT"
from DBA_HIST_seg_stat seg, dba_hist_snapshot snap
where BEGIN_INTERVAL_TIME 
between 
to_date('2013/01/01 01:00','YYYY/MM/DD HH24:MI') and
to_date('2013/02/20 01:00','YYYY/MM/DD HH24:MI') 
and to_char(BEGIN_INTERVAL_TIME,'HH24MI') between '0900' and '2100'
and seg.snap_id= snap.snap_id 
and seg.dbid= snap.dbid
and seg.instance_number=snap.instance_number 
and snap.dbid = 601016237 
group by trunc(BEGIN_INTERVAL_TIME,'MI')
order by trunc(BEGIN_INTERVAL_TIME,'MI') ;

select * from  DBA_HIST_seg_stat where dbid = 601016237 ;

select * from dba_hist_snapshot where dbid = 601016237 order by begin_interval_time desc ;
