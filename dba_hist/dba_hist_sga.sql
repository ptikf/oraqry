select 
to_char(snap.begin_interval_time,'YYYY/MM/DD HH24:MI') begin, sga.* 
from ( 
select dbid,instance_number,snap_id,db_buffers,redo_buffers,var_size,fixed_size from dba_hist_sga
pivot (max(round(value/1024/1024)) for name in ('Database Buffers' as db_buffers ,'Redo Buffers' as redo_buffers ,'Variable Size' as var_size ,'Fixed Size' as fixed_size ) ) ) sga
left outer join dba_hist_snapshot snap on snap.dbid=sga.dbid and snap.snap_id=sga.snap_id and snap.instance_number=sga.instance_number 
where snap.dbid=601016237 and snap.instance_number=1 
order by snap.snap_id desc ;

select snap_id,name ,round(value/1024/1024) val from dba_hist_sga
--  round(value/1024/1024)
where dbid=601016237
and instance_number=1 
-- and name = 'Database Buffers'
and snap_id in (84325,84324,84323,84322)
order by snap_id desc ;

select snap.begin_interval_time, 
sga.* 
from 
dba_hist_snapshot snap 
left outer join dba_hist_sga sga on snap.dbid=sga.dbid and snap.snap_id=sga.snap_id and snap.instance_number=sga.instance_number
where snap.dbid =  601016237  and 
snap.begin_interval_time >= to_date('2013/02/01 17:00','YYYY/MM/DD HH24:MI') and 
snap.instance_number=1 
order by snap.begin_interval_time desc ;
