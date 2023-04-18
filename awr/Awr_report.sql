--
-- Script de sortie des rapports AWR
--

define annee = '2017'
define mois = '12'
define jour = '10'
define hdeb = '09:00'
define hfin = '20:00'
define hdeb1 = '0900'
define hfin1 = '2000'

-- define db='MDMBPUD1'
define db='TOMORUQ1'
-- define db='rmx02go'

define rep='C:\_projets\_rexel\awr\_oratom_qual'
-- define rep='/home/oracle/awr'

set serveroutput off
set verify off
set echo off
set heading off;
set linesize 1500;
--

spool '&rep.\&db._&annee._&mois._&jour._&hdeb1._&hfin1..html';
-- spool '&rep./&db._&annee._&mois._&jour._&hdeb1._&hfin1..html';
SELECT output  FROM TABLE  (DBMS_WORKLOAD_REPOSITORY.awr_report_html( (select dbid from v$database),1,
 (SELECT min(snap_id) -1 from dba_hist_snapshot where begin_interval_time >= to_date('&annee/&mois/&jour &hdeb','YYYY/MM/DD HH24:MI')),
 (SELECT max(snap_id) +1 from dba_hist_snapshot where   end_interval_time <= to_date('&annee/&mois/&jour &hfin','YYYY/MM/DD HH24:MI'))  ) );
spool off ; 
