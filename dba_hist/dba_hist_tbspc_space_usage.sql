select  
ts.tsname,
--sp.tablespace_size,
round(sp.tablespace_size*ts.block_size/1024/1024) size_MB,
--sp.tablespace_maxsize,
round(sp.tablespace_maxsize*ts.block_size/1024/1024) max_MB,
--sp.tablespace_usedsize,
round(sp.tablespace_usedsize*ts.block_size/1024/1024) used_MB,
rtime,
ts.block_size blk_size
from 
dba_hist_tbspc_space_usage  sp,
dba_hist_tablespace ts 
where 
ts# = tablespace_id 
and tsname='TEMP'
order by rtime desc ;

select z.tablespace_name tspace_name,
round((select sum(b.bytes)/(1024*1024) from dba_free_space b where b.tablespace_name = z.tablespace_name)) MB_Free,
round((select sum(a.bytes)/(1024*1024) from dba_data_files a where a.tablespace_name = z.tablespace_name)) MB_Total,
round((select sum(b.bytes)/(1024*1024) from dba_free_space b where b.tablespace_name = z.tablespace_name)/(select sum(a.bytes)/(1024*1024) 
from  dba_data_files a where a.tablespace_name = z.tablespace_name)*100) Pcent_Free
from dba_tablespaces z
order by z.tablespace_name;

select sql_id,max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024) gig 
from DBA_HIST_ACTIVE_SESS_HISTORY 
where 
TEMP_SPACE_ALLOCATED > (10*1024*1024*1024)  and 
sample_time  between
to_date('07/04/2017 14:00','DD/MM/YYYY HH24:MI') and to_date('07/04/2017 19:00','DD/MM/YYYY HH24:MI')
group by sql_id order by sql_id;

select sql_id, temp_space_allocated,sample_time
from DBA_HIST_ACTIVE_SESS_HISTORY 
where 
--TEMP_SPACE_ALLOCATED > (10*1024*1024*1024)  and 
sample_time  between
to_date('07/04/2017 14:00','DD/MM/YYYY HH24:MI') and to_date('07/04/2017 19:00','DD/MM/YYYY HH24:MI')
order by temp_space_allocated desc nulls last ;

