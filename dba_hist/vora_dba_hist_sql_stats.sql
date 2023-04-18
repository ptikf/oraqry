select sql_id, t.snap_id SNAP, to_char(t.begin_interval_time,'DD/MM/YY HH24:MI') begin,
trunc(elapsed_time_total/1000000 ) elapT, 
trunc(elapsed_time_delta/1000000 ) elapD,
(trunc((elapsed_time_delta / executions_delta )+0.5)/1000) as elapDU_ms,
-- trunc(elapsed_time_delta / executions_delta / 1000/1000) elapDU_s,
rows_processed_total rowsT, -- rows_processed_delta rowsd,
version_count VerC,
executions_total ExecT, 
executions_delta ExecD,
disk_reads_total DskRT, 
disk_reads_delta DskRD,
buffer_gets_total GetsT, 
buffer_gets_delta getsD,
trunc(iowait_total/1000000/60)  IOWT,  -- iowait_delta iowaitD,
trunc(CCWAIT_TOTAL/1000000/60) ConcW, -- ConcurrencyW
sorts_total SortT,
plan_hash_value plan_hash,
optimizer_cost OPTCOST,
loaded_versions loadedV,
loads_total loadT,
version_count version
 from dba_hist_sqlstat h, dba_hist_snapshot T
where 
sql_id = '9qag9r97v8ygb'  and 
t.snap_id=h.snap_id 
-- and t.snap_id  = 10057
-- and t.snap_id between 10056 and 10058
order by t.snap_id desc  
-- and elapDU_ms > 10 
--and executions_delta > 100000 
; 

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
