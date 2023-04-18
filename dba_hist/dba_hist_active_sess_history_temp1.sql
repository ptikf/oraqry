with ash as  ( 
select 
sample_time,
sql_id,
sql_exec_start,
max(sample_time) over (partition by sql_id,sql_exec_start,qc_session_id) sql_end,
-- qc_session_id ,
round(sum(temp_space_allocated)/1024/1024/1024) temp_gb
from dba_hist_active_sess_history where temp_space_allocated is not null 
group by sample_time, sql_id,sql_exec_start, qc_session_id
)
select 
ash.*,
txt.sql_text
from ash 
left outer join dba_hist_sqltext txt on ash.sql_id=txt.sql_id
where ash.sample_time >  to_date('2020/01/01 00:21:00','YYYY/MM/DD HH24:MI:SS')
and ash.sql_id not in (
'32k10z7j9yp2h','9a0vzyrjkm44x','8thudjra0tsar','8ggxztkbmds3f','apnbb9ss3y7gp','1tb1dxn7s4ffy','agc7c76gy9bx5','1z9c3mdyayxar','24mxyj5b902da')
--,
--'fxsmtv6wkuhmt','1pcvpg9m2529x','755cnp4tjchxj','24mxyj5b902da','cf8d7fu1cvv22','fd4tdxbsvw4v6','3bwazz29hra0t','5zcpp3t2nbszg','8g4ycxc9nyzga'
--) 
 order by ash.temp_gb desc nulls last 
;

select * from dba_hist_sqltext where sql_id in  (
'32k10z7j9yp2h','9a0vzyrjkm44x','8thudjra0tsar','8ggxztkbmds3f','apnbb9ss3y7gp','1tb1dxn7s4ffy','agc7c76gy9bx5','1z9c3mdyayxar','24mxyj5b902da',
'fxsmtv6wkuhmt','1pcvpg9m2529x','755cnp4tjchxj','24mxyj5b902da','cf8d7fu1cvv22','fd4tdxbsvw4v6','3bwazz29hra0t','5zcpp3t2nbszg','8g4ycxc9nyzga'
)  ;

-- 32k10z7j9yp2h 03/01/2020 08:14:13	05/01/20 00:38:36 ==> user
-- 9a0vzyrjkm44x 16/01/2020 08:30:49	16/01/20 13:38:03 ia02
-- 8thudjra0tsar 15/01/2020 15:10:25	16/01/20 15:31:20 user ? 
-- 8ggxztkbmds3f 06/01/2020 16:53:48	06/01/20 19:12:00 ccdp 
-- apnbb9ss3y7gp 02/01/2020 14:15:35	02/01/20 16:44:42 ==> FACT_LADM_LH_BASE_DEMAND ? 
-- 1tb1dxn7s4ffy 06/01/2020 11:00:37	07/01/20 02:16:37 user ?
-- agc7c76gy9bx5 15/01/2020 12:02:10	16/01/20 13:25:03 V_FACT_LADM_REPORT9
-- 1z9c3mdyayxar 20/01/2020 16:42:30	20/01/20 17:14:58
-- 24mxyj5b902da 16/01/2020 04:00:04	16/01/20 06:31:15
-- fxsmtv6wkuhmt 15/01/2020 03:00:02	15/01/20 05:25:27 ctrl +/- 800 gb
-- 1pcvpg9m2529x 18/01/2020 03:00:02	18/01/20 04:43:37
-- 755cnp4tjchxj 16/01/2020 03:00:03	16/01/20 05:37:28
-- 24mxyj5b902da	16/01/2020 04:00:04	16/01/20 06:31:15
-- cf8d7fu1cvv22	12/01/2020 03:00:02	12/01/20 04:47:46 ctrl
-- fd4tdxbsvw4v6	08/01/2020 03:00:03	08/01/20 05:19:28 ctrl
-- 3bwazz29hra0t	09/01/2020 03:00:03	09/01/20 05:47:35 
-- 5zcpp3t2nbszg	11/01/2020 03:00:03	11/01/20 04:49:22 ctrl 
-- 8g4ycxc9nyzga	10/01/2020 03:00:02	10/01/20 04:59:12


select * from (
select 
to_date(tbs.rtime,'MM/DD/YYYY HH24:MI:SS') rtime ,
round(tbs.tablespace_size*8192/1024/1024/1024) size_gb,
round(tbs.tablespace_maxsize*8192/1024/1024/1024) maxsize_gb,
round(tbs.tablespace_usedsize*8192/1024/1024/1024) usedsize_gb,
round(tbs.tablespace_usedsize*100/tablespace_size,2) pct_used
from DBA_HIST_TBSPC_SPACE_USAGE tbs
where tbs.tablespace_id=3 
)
where rtime > to_date('2020/01/01 03:00:00','YYYY/MM/DD HH24:MI:SS')
and  pct_used > 80
order by pct_used desc ;
