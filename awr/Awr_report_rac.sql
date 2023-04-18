-- Script de sortie des rapports AWR - RAC 1 instance
--
set serveroutput off
set verify off
set echo off
set heading off
set linesize 1500

define annee = '2011'
define mois = '09'
define jour = '20'
define hdeb = '06:00'
define hfin = '23:00'
define hdeb1 = '0600'
define hfin1 = '2300'

define db='bprxbo11'
define dbinst=1

define rep='C:\_ritmx\Lille\awr'

spool '&rep.\&db._&annee._&mois._&jour._&hdeb1._&hfin1..html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_report_html( 
 (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),
  &dbinst,
 (SELECT min(snap_id) -1 from dba_hist_snapshot where 
  begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   
  end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) 
  ) );
spool off ; 
