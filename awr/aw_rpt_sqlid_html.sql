--
-- Script de sortie des rapports AWR SQLID
--
define annee = '2018'
define mois_deb = '09'
define mois_fin = '09'
define jour_deb = '24'
define jour_fin = '24'
define hdeb = '00:15'
define hfin = '23:45'
define hdeb1 = '0015'
define hfin1 = '2345'

define db='FRLADMP1'
define dbinst=1
define dbinst_all='1,2'

define rep='C:\users\TIKHONO\AWR'

set serveroutput off
set verify off
set echo off
set heading off
set linesize 1500
--
define sqlid = '7wmdrmvfzrs4r' 

spool '&rep.\&db._&annee._&mois_deb._&jour_deb._&hdeb1._&hfin1._sql_&sqlid..html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_sql_report_html( 
 (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),  &dbinst,
 (SELECT min(snap_id) -1 from dba_hist_snapshot where   begin_interval_time >= to_date('&annee/&mois_deb/&jour_deb &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('&annee/&mois_fin/&jour_fin &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) 
  ,'&sqlid') );
spool off ; 