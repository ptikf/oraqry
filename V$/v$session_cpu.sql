SELECT
   s.username,
   t.sid,
   s.serial#,
   SUM(VALUE/100) as "cpu usage (seconds)"
FROM
   gv$session s,
   gv$sesstat t,
   gv$statname n
WHERE t.STATISTIC# = n.STATISTIC# and s.INST_ID=n.INST_ID
AND   NAME like '%CPU used by this session%'
AND   t.SID = s.SID and t.inst_id=s.inst_id
AND   s.status='ACTIVE'
AND   s.username is not null
GROUP BY username,t.sid,s.serial#
order by SUM(VALUE/100) desc ; 