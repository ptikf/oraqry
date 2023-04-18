SELECT
    s.sid,s.serial#,s.inst_id,
    round(p.pga_used_mem/1024) pga_used_mem_k,
    round(p.pga_alloc_mem/1024) pga_alloc_mem_k,
    p.pga_freeable_mem,
    round(p.pga_max_mem/1024) pga_max_mem_k,
    pm.pid,
    pm.category,
    round(pm.allocated/1024) pm_allocated_k,
    round(pm.used/1024) pm_used_k,
    round(pm.max_allocated/1024) pm_max_alloc_k 
    -- p.*,
    -- pm.*
FROM 
    gv$session s
  , gv$process p
  , gv$process_memory pm
WHERE
    s.paddr = p.addr and s.INST_ID=p.INST_ID
AND p.pid = pm.pid and p.inst_id=pm.INST_ID
and s.sid=1104 and s.serial#=28573
ORDER BY
    sid
  , category;
