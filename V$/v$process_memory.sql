set lines 110
-- col unm format a30 hea "USERNAME (SID,SERIAL#)"
col pus format 999,990.9 hea "PROC KB|USED"
col pal format 999,990.9 hea "PROC KB|MAX ALLOC"
col pgu format 99,999,990.9 hea "PGA KB|USED"
col pga format 99,999,990.9 hea "PGA KB|ALLOC"
col pgm format 99,999,990.9 hea "PGA KB|MAX MEM"

select 
s.username||' ('||s.sid||','||s.serial#||')' unm,
round((sum(m.used)/1024),1) pus,
round((sum(m.max_allocated)/1024),1) pal, 
round((sum(p.pga_used_mem)/1024),1) pgu,
round((sum(p.pga_alloc_mem)/1024),1) pga,
round((sum(p.pga_max_mem)/1024),1) pgm
from 
v$process_memory m, 
v$session s, 
v$process p
where 
m.serial# = p.serial# and 
p.pid = m.pid and 
p.addr=s.paddr and
s.username is not null 
group by 
s.username, 
s.sid, 
s.serial# 
order by unm;