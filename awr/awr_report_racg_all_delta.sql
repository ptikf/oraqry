--
set serveroutput off
set verify off
set echo off
set heading off
set linesize 1500

define annee = '2013'
define mois = '04'
define jour = '02'
define hdeb = '06:30'
define hfin = '06:45'
define hdeb1 = '0630'
define hfin1 = '0645'

define db='bprxfo11'
define dbinst=1
define dbinst_all='1,2'

define rep='D:\_ritmx\_analyses_specifiques\2013_04_03_plantage'

spool '&rep.\&db._&annee._&mois._&jour._&hdeb1._&hfin1._g_all_delta.html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_global_diff_report_html( 
 (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),
  '&dbinst_all',  
 (SELECT min(snap_id) -1 from dba_hist_snapshot where 
  begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   
  end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) ,
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),
  '&dbinst_all',  
 (SELECT min(snap_id) -1 from dba_hist_snapshot where 
  begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   
  end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) 
  ) );
spool off ;