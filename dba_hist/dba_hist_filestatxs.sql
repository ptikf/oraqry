select 
 to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin 
--,DBID
-- ,INSTANCE_NUMBER
,hl.FILE# f#
-- ,CREATION_CHANGE#
,hl.FILENAME
,hl.TS#
,hl.TSNAME
-- ,hl.BLOCK_SIZE
,hl.PHYRDS
,hl.PHYWRTS
,hl.SINGLEBLKRDS
,hl.READTIM
,hl.WRITETIM
,hl.SINGLEBLKRDTIM
,hl.PHYBLKRD
,hl.PHYBLKWRT
,hl.WAIT_COUNT
,hl.TIME
,hl.OPTIMIZED_PHYBLKRD
--,CON_DBID
--,CON_ID
from DBA_HIST_FILESTATXS hl,
 dba_hist_snapshot T
 where 
 hl.snap_id = t.snap_id 
and tsname not in ('USERS','SYSTEM','SYSAUX','UNDOTBS1')
 order by t.begin_interval_time desc;

  select 
 to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin 
--,hl.TS#
,hl.TSNAME
-- ,hl.BLOCK_SIZE
,sum(hl.PHYRDS) phyrds
,sum(hl.PHYWRTS) PHYWRTS
,sum(hl.SINGLEBLKRDS) SINGLEBLKRDS
,sum(hl.READTIM) READTIM
,sum(hl.WRITETIM) WRITETIM
,sum(hl.SINGLEBLKRDTIM) SINGLEBLKRDTIM
,sum(hl.PHYBLKRD) PHYBLKRD
,sum(hl.PHYBLKWRT) PHYBLKWRT
,sum(hl.WAIT_COUNT) WAIT_COUNT
,sum(hl.TIME) TIM
,sum(hl.OPTIMIZED_PHYBLKRD) OPTIMIZED_PHYBLKRD
from DBA_HIST_FILESTATXS hl,
 dba_hist_snapshot T
 where 
 hl.snap_id = t.snap_id 
and tsname not in ('USERS','SYSTEM','SYSAUX','UNDOTBS1')
group by hl.TSNAME,t.begin_interval_time
 order by t.begin_interval_time desc;