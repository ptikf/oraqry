SELECT  wait_class,
        ROUND(100* RATIO_TO_REPORT(total_waits) OVER (),2) total_waits_pct,
        ROUND(100* RATIO_TO_REPORT(time_waited) OVER (),2) time_waited_pct
FROM
(   SELECT wait_class,
        total_waits,
        time_waited
    FROM    gv$system_wait_class
    WHERE   wait_class != 'Idle'
)
ORDER BY 3 DESC;