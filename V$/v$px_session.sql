-- 	Script to Map Parallel Query Coordinators to Slaves (Doc ID 202219.1)

select
  decode(px.qcinst_id,NULL,username,
        ' - '||lower(substr(s.program,length(s.program)-4,4) ) ) "Username",
  decode(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" ,
  to_char( px.server_set) "Slave Set",
  to_char(s.sid) "SID",
  decode(px.qcinst_id, NULL ,to_char(s.sid) ,px.qcsid) "QC SID",
  px.req_degree "Requested DOP",
  px.degree "Actual DOP"
from
  v$px_session px,
  v$session s
where
  px.sid=s.sid (+)
 and
  px.serial#=s.serial#
order by 5 , 1 desc
;



select 
decode(px.qcinst_id,NULL,username,  
' - '||lower(substr(pp.SERVER_NAME, 
length(pp.SERVER_NAME)-4,4) ) )"Username", 
decode(px.qcinst_id,NULL, 'QC', '(Slave)') "QC/Slave" , 
to_char( px.server_group) "Group", 
to_char( px.server_set) "SlaveSet", 
to_char(s.sid) "SID", 
to_char(px.inst_id) "Slave INST", 
decode(sw.state,'WAITING', 'WAIT', 'NOT WAIT' ) as STATE,      
case  sw.state WHEN 'WAITING' THEN substr(sw.event,1,30) ELSE NULL end as wait_event , 
decode(px.qcinst_id, NULL ,to_char(s.sid) ,px.qcsid) "QC SID", 
to_char(px.qcinst_id) "QC INST", 
px.req_degree "Req. DOP", 
px.degree "Actual DOP", 
s.sql_id "SQL_ID",
s.blocking_session
----------------------------------------
from gv$px_session px, 
gv$session s , 
gv$px_process pp, 
gv$session_wait sw 
where px.sid=s.sid (+) 
and px.serial#=s.serial#(+) 
and px.inst_id = s.inst_id(+) 
and px.sid = pp.sid (+) 
and px.serial#=pp.serial#(+) 
and sw.sid = s.sid   
and sw.inst_id = s.inst_id    
order by 
  decode(px.QCINST_ID,  NULL, px.INST_ID,  px.QCINST_ID), 
  px.QCSID, 
  decode(px.SERVER_GROUP, NULL, 0, px.SERVER_GROUP),  
  px.SERVER_SET,  
px.INST_ID ;