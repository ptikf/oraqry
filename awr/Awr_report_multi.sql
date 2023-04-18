--
-- Script de sortie des rapports AWR
--

define annee = '2017'
define mois = '11'
define jour_deb = '17'
define jour_fin = '19'
define hdeb = '19:00'
define hfin = '10:00'
define hdeb1 = '1900'
define hfin1 = '1000'

define db='TOMORUQ1'
-- define db='rmx02go'

define rep='C:\_projets\_rexel\awr\_oratom_dev'
-- define rep='/home/oracle/awr'

set serveroutput off
set verify off
set echo off
set heading off;
set linesize 1500;
--

spool '&rep.\&db._&annee._&mois._&jour_deb._&hdeb1._&hfin1..html';
-- spool '&rep./&db._&annee._&mois._&jour._&hdeb1._&hfin1..html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_report_html( (select dbid from v$database),1,
 (SELECT min(snap_id) -1 from dba_hist_snapshot where begin_interval_time >= to_date('&annee/&mois/&jour_deb &hdeb','YYYY/MM/DD HH24:MI')),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('&annee/&mois/&jour_fin &hfin','YYYY/MM/DD HH24:MI'))  ) );
spool off ; 
