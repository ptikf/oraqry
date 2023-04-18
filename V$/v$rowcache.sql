---------------------------------------------------------------------------------
-- cache dictionnaire
---------------------------------------------------------------------------------
select ((1 - (sum(getmisses) / (sum(gets) + sum(getmisses)))) * 100 ) "Hit Ratio"
from v$rowcache
where gets + getmisses <> 0 ;
---------------------------------------------------------------------------------
-- cache dictionnaire detaille
---------------------------------------------------------------------------------
column parameter		format a20			heading 'data dictionary data' 
column gets				format 999,999,999	heading 'Total|Requests'
column getmisses		format 999,999,999	heading 'Misses'
column modifications 	format 999,999		heading 'Mods'
column flushes			format 999,999		heading 'Flushes'
column getmiss_ratio	format 9.99			heading 'Miss|Ratio'
set pagesize 50
ttitle 'Shared Pool Row Cache Usage'

select parameter, gets, getmisses, modifications, flushes,
		(getmisses / decode(gets,0,1,gets)) getmiss_ratio,
		(case when (getmisses / decode(gets,0,1,gets)) > .1 then '*' else ' ' end) " "
from v$rowcache
where gets + getmisses <> 0 ;
/