--
-- Script de sortie des rapports AWR SQLID
--
define annee = '2017'
define mois_deb = '05'
define mois_fin = '05'
define jour_deb = '12'
define jour_fin = '12'
define hdeb = '09:00'
define hfin = '20:00'
define hdeb1 = '0900'
define hfin1 = '2000'

define db='MDMFUT3'
define dbinst=1

define rep='/home/oracle/awr'

set serveroutput off
set verify on
set echo off
set heading off;
set linesize 1500;
--
define sqlid = '09cud7b8ubu2d' 

spool '&rep.\&db._&annee._&mois_deb._&jour_deb._&hdeb1._&hfin1._sql_&sqlid..html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_sql_report_html( 
 (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ),  &dbinst,
 (SELECT min(snap_id) -1 from dba_hist_snapshot where   begin_interval_time >= to_date('&annee/&mois_deb/&jour_deb &hdeb','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('&annee/&mois_fin/&jour_fin &hfin','YYYY/MM/DD HH24:MI') and instance_number=&dbinst and dbid = 
  (select distinct dbid from dba_hist_database_instance where instance_name = '&db' and instance_number=&dbinst ) ) 
  ,'&sqlid') );
spool off ; 
