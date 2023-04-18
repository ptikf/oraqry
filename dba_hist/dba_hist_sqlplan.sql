SELECT DISTINCT sqlp.sql_id, object_name,
                DBMS_LOB.SUBSTR (sqlt.sql_text, 300, 1) texte
-- distinct options
FROM            dba_hist_sql_plan sqlp LEFT OUTER JOIN dba_hist_sqltext sqlt
                ON sqlt.sql_id = sqlp.sql_id
          WHERE sqlp.object_owner = 'CARP'
            AND TIMESTAMP > = TO_DATE ('01/07/2010', 'DD/MM/YYYY')
            AND operation = 'INDEX'
            AND object_name NOT LIKE '%PK%'
            AND object_name NOT LIKE '%BK%'
            AND object_name NOT LIKE '%WI%'
            AND object_name NOT LIKE '%_I1%'
            AND object_name NOT LIKE '%_I2%'
            AND object_name NOT LIKE '%_UI%'
            AND object_name NOT LIKE '%SYS%'
            AND DBMS_LOB.SUBSTR (sqlt.sql_text, 300, 1) NOT LIKE '%dbms_stats%'
            AND DBMS_LOB.SUBSTR (sqlt.sql_text, 300, 1) NOT LIKE '%minbkt%'
            AND DBMS_LOB.SUBSTR (sqlt.sql_text, 300, 1) NOT LIKE '%ordered%'
            AND DBMS_LOB.SUBSTR (sqlt.sql_text, 300, 1) NOT LIKE '%(+)%'
       ORDER BY object_name;