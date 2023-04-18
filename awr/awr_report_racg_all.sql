-- Script de sortie des rapports AWR RAC toutes instances
--
set serveroutput off
set verify off
set echo off
set heading off
set linesize 1500

define annee = '2018'
define mois = '07'
define jour = '10'
define hdeb = '06:00'
define hfin = '22:00'
define hdeb1 = '0600'
define hfin1 = '2200'

define db='FRLADMP1'
define dbinst=1
define dbinst_all='1,2'

define rep='C:\users\TIKHONO\AWR'

spool '&rep.\&db._&annee._&mois._&jour._&hdeb1._&hfin1._g_all.html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_global_report_html(
 (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),'&dbinst_all',
 (SELECT min(snap_id) -1 from dba_hist_snapshot where 
  begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   
  end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) 
  ) );
spool off ; 