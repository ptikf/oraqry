select sql_id, t.snap_id SNAP, to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
case when executions_delta > 0
then (trunc((elapsed_time_delta / executions_delta )+0.5)/1000) 
else 0 end as exU_ms,
--case when executions_delta > 0
-- then trunc(elapsed_time_delta / executions_delta / 1000/1000) 
--else 0 end as elapDU_s,
trunc((buffer_gets_delta/ executions_delta)+0.5) gtu ,
trunc((disk_reads_delta / executions_delta)+0.5) rdu ,
trunc((rows_processed_delta / executions_delta)+0.5) rwsu ,
trunc((iowait_delta / executions_delta / 1000 )+0.5) iowtU ,
trunc((apwait_delta / executions_delta / 1000 )+0.5) apwtU ,
executions_delta ExecD,
disk_reads_delta DskRD,
buffer_gets_delta getsD,
trunc(elapsed_time_delta/1000000 ) elapD,
trunc(iowait_total/1000000/60)  IOWT,
trunc(CCWAIT_TOTAL/1000000/60) ConcW, -- ConcurrencyW
trunc(elapsed_time_total/1000000 ) elapT,
executions_total ExecT,
rows_processed_total rowsT,
buffer_gets_total GetsT,
disk_reads_total DskRT,
sorts_total SortT,
loaded_versions loadedV,
loads_total loadT,
plan_hash_value plan_hash,
optimizer_cost cost,
optimizer_env_hash_value opt_env_hvalue,
version_count version
 from dba_hist_sqlstat h, dba_hist_snapshot T
where 
sql_id = 'bs1rgpp313g0z'  and 
t.snap_id=h.snap_id 
-- and t.snap_id  = 10057
-- and t.snap_id between 10056 and 10058
and t.begin_interval_time >= to_date('01/03/2010 19:00','DD/MM/YYYY HH24:MI')
order by t.snap_id desc 
-- and elapDU_ms > 10 
--and executions_delta > 100000 
;

select * from dba_hist_sqltext 
where sql_id like 'bs1r%' ;
select sum(executions_delta) from  dba_hist_sqlstat where snap_id=10057 ;

-- order by t.snap_id desc ;

select 
to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
h.*
 from dba_hist_sqlstat h, dba_hist_snapshot T
where sql_id = '477tqdbwh6n5v' and t.snap_id=h.snap_id  order by t.snap_id desc ;

select * from dba_hist_active_sess_history 
where 
sql_id = '477tqdbwh6n5v'
and snap_id between 10056 and 10058 
order by snap_id desc ; 

-- 50zggzr4rgrw8 Interfacer tx T2 batch 
-- ffmds7gcbk8n2
-- af94vvw5bhhwj s_grille_tarifaire
-- d92g8zrg7uu6r

-- 5vft1xq6umww6 update code chauffeur 
-- 24mw35dznxvaa insert noeud_regroupement_r
-- 6p3v7ks9rpk2n insert client
-- atupqfv5zaapt insert into rlg
-- 90fss46n75vyw update element_valorise

-- d1khk979mg6yu update cumul_facturation
-- 2cgsk1vynzhht select montant_valorise_va
-- 7s35scpxtd2gb insert into wrk_element_valorise 

-- VALO
-- ctufc16tdpkpn => select taxe autorisation
-- 477tqdbwh6n5v => select pcom c_pcom_detenu
-- 0xw1yd5x5xqh0 => update transaction_controlee
-- azhd73wssknyb => insert Element_valorise VE
-- 4bb3rfzvzrnbf => insert element_valorise AC
-- 6939ymajfgfz9 => update montant_valorise_va fk_ev_seq
-- 5kdmg3sx16a56 => select condition_vente_defaut <1 ms
-- cubchwjdt0d6z => insert into montant_valorise_va <1ms
-- 9qag9r97v8ygb => select C_STRUCT_RISTOU_RESO_ACCEPTEUR

-- Oppo
-- 7py11cqwnuh4v
-- 8c9a6j3y1bvzn





set lines 110
-- col unm format a30 hea "USERNAME (SID,SERIAL#)"
col pus format 999,990.9 hea "PROC KB|USED"
col pal format 999,990.9 hea "PROC KB|MAX ALLOC"
col pgu format 99,999,990.9 hea "PGA KB|USED"
col pga format 99,999,990.9 hea "PGA KB|ALLOC"
col pgm format 99,999,990.9 hea "PGA KB|MAX MEM"

select 
--s.machine,
s.program,
--s.username||' ('||s.sid||','||s.serial#||')' unm,
round((sum(m.used)/1024),1) pus,
round((sum(m.max_allocated)/1024),1) pal, 
round((sum(p.pga_used_mem)/1024),1) pgu,
round((sum(p.pga_alloc_mem)/1024),1) pga,
round((sum(p.pga_max_mem)/1024),1) pgm
from 
v$process_memory m, 
v$session s, 
v$process p
where 
m.serial# = p.serial# and 
p.pid = m.pid and 
p.addr=s.paddr and
s.username is not null 
group by 
--s.username, 
--s.sid, 
--s.serial#,
--s.machine,
s.program 
order by 
pga desc 
-- unm
;

select 
(sum(m.used)/1024) pus,
(sum(m.max_allocated)/1024) pal, 
(sum(p.pga_used_mem)/1024) pgu,
(sum(p.pga_alloc_mem)/1024) pga,
(sum(p.pga_max_mem)/1024) pgm
from 
v$process_memory m, 
; 

select 
snap_id,
categrory,
num_processes * from dba_hist_process_mem_summary 
order  by snap_id desc ;

select * from dba_hist_librarycache order by snap_id desc ;

select * from dba_hist_buffer_pool_stat order by snap_id desc ;  

select * from dba_hist_active_sess_history 
where 
-- event like 'enq: TX %'  and 
snap_id = 10057 
order by 
session_id desc 
--and snap_id >= 10056 and snap_id <= 10058 
;

select distinct session_id  from dba_hist_active_sess_history
where  snap_id = 10057 ;
