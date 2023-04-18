-- -- http://psoug.org/reference/cursor_sharing.html



--
-- http://hoopercharles.wordpress.com/2010/02/03/open-cursor-leaks-identifying-the-problem/
--
SELECT SQL_ID, SUBSTR(SQL_TEXT,1,50) SQL_TEXT, COUNT(*) CNT
FROM V$OPEN_CURSOR
-- WHERE SID=168
GROUP BY   SQL_ID, SUBSTR(SQL_TEXT,1,50)
ORDER BY   SQL_ID;

--
--
--
SELECT
  OC.SID,OC.USER_NAME,
  S.PROGRAM,
  COUNT(*) COUNTER,
  OC.SQL_ID,
  OC.SQL_TEXT
FROM
  V$OPEN_CURSOR OC,
  V$SESSION S
WHERE
  OC.SQL_TEXT NOT LIKE '%obj#,%'
  AND OC.SQL_TEXT NOT LIKE '%grantee#,%'
  AND OC.SQL_TEXT NOT LIKE '%privilege#%'
  AND OC.SQL_TEXT NOT LIKE 'DECLARE%'
  AND OC.SQL_TEXT NOT LIKE '%/*+ rule */%'
  AND OC.SQL_TEXT NOT LIKE '%col#%'
  AND OC.SQL_TEXT NOT LIKE '%sys.mon_mods$%'
  AND OC.SQL_TEXT NOT LIKE '%obj#=%'
  AND OC.SQL_TEXT NOT LIKE '%update$,%'
  AND OC.SID=S.SID
  AND OC.USER_NAME NOT IN ('SYS','DBSNMP','SYSTEM','SYSMAN','RMAN')
GROUP BY
  OC.SID,
  OC.USER_NAME,
  S.PROGRAM,
  OC.SQL_ID,
  OC.SQL_TEXT
HAVING COUNT(*)>=10
ORDER BY
  OC.USER_NAME,
  OC.SID,
  OC.SQL_TEXT;

--   
-- Troubleshooting: High Version Count Issues (Doc ID 296377.1)  
--  
select * from v$sql_shared_cursor ;

SELECT
  CHILD_NUMBER CN,
  PARSING_SCHEMA_NAME,
  OPTIMIZER_ENV_HASH_VALUE OPTIMIZER_ENV,
  INVALIDATIONS,
  PARSE_CALLS,
  IS_OBSOLETE,
  FIRST_LOAD_TIME,
  TO_CHAR(LAST_ACTIVE_TIME,'YYYY-MM-DD/HH24:MI:SS') LAST_ACTIVE_TIME
FROM
  V$SQL
WHERE
  SQL_ID='5ngzsfstg8tmy';

SELECT
  CHILD_NUMBER CN,
  NAME,
  VALUE,
  ISDEFAULT DEF
FROM  V$SQL_OPTIMIZER_ENV
WHERE
  SQL_ID='5ngzsfstg8tmy'
  AND CHILD_NUMBER in (0,2,12)
ORDER BY  NAME, CHILD_NUMBER;  

  
