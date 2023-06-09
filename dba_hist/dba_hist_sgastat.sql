select  to_char(snap.begin_interval_time,'YYYY/MM/DD HH24:MI') begin, sta.* from (
select  dbid, instance_number inst ,snap_id,pool,
(free_mem+gcs_res+ccur+pcur+sqla+kglhd) tot,
free_mem,
gcs_res,
ccur,
pcur,
sqla,
kksfd,
ges_res,
kti_undo,
pldia,
kglhd,
plmcd,
ksunfy,
fileopenb,
ges_enq,
kglho,
cursor_stats,
event_sess,
ges_res_msg_buf,
kgls,
sqlp,
rowcache,
ash_buf,
kglsg,
kqrmpo,
kglsim_hash,
kglsim_obj,
obj_stats_alloc,
dbktb,
dbwriter,
ges_big,
xdbsc,
kqrlpo, 
kqrxpo,
kkssp,
kglna,
gcs_shadows,
private_strands,
kcb_tab_scan_buf
from dba_hist_sgastat 
pivot (max(round(bytes/1024/1024)) for name in (
'NAME' name,
'free memory' free_mem,
'gcs resources' gcs_res,
'CCUR' ccur,
'PCUR' pcur,
'SQLA' sqla,
'KSFD SGA I/O b' kksfd,
'ges resource ' ges_res,
'KTI-UNDO' KTI_UNDO,
'PLDIA' PLDIA,
'KGLHD' KGLHD,
'PLMCD' PLMCD,
'ksunfy : SSO free list' ksunfy,
'FileOpenBlock' fileopenb,
'ges enqueues' ges_enq,
'KGLH0' kglho,
'Cursor Stats' cursor_stats,
'event statistics per sess' event_sess,
'ges reserved msg buffers' ges_res_msg_buf,
'KGLS' kgls,
'SQLP' sqlp,
'row cache' rowcache,
'ASH buffers' ash_buf,
'KGLSG' kglsg,
'KQR M PO' kqrmpo,
'kglsim hash table bkts'kglsim_hash,
'kglsim object batch' kglsim_obj,
'obj stats allocation chun' obj_stats_alloc,
'dbktb: trace buffer' dbktb,
'dbwriter coalesce buffer' dbwriter,
'ges big msg buffers' ges_big,
'XDBSC' xdbsc,
'KQR L PO' kqrlpo, 
'KQR X PO' kqrxpo,
'KKSSP' kkssp,
'KGLNA' kglna,
'gcs shadows' gcs_shadows,
'private strands' private_strands,
'KCB Table Scan Buffer' kcb_tab_scan_buf )  ) 
 ) sta
left outer join dba_hist_snapshot snap on snap.dbid=sta.dbid and snap.snap_id=sta.snap_id and snap.instance_number=sta.inst
where sta.pool = 'shared pool'
and snap.dbid=601016237 and snap.instance_number=2
and snap.begin_interval_time >= to_date('2013/02/01 05:50','YYYY/MM/DD HH24:MI')
order by snap.snap_id desc ; 
