SELECT DBMS_STATS.get_prefs('PUBLISH') FROM dual;

-- New statistics for SCOTT.EMP are kept in a pending state.
EXEC DBMS_STATS.set_table_prefs('SCOTT', 'EMP', 'PUBLISH', 'false');

-- New statistics for SCOTT.EMP are published immediately.
EXEC DBMS_STATS.set_table_prefs('SCOTT', 'EMP', 'PUBLISH', 'true');

-- Pending statistics are visible using the 
-- [DBA|ALL|USER]_TAB_PENDING_STATS 
-- and 
-- [DBA|ALL|USER]_IND_PENDING_STATS views.

-- Publish all pending statistics.
EXEC DBMS_STATS.publish_pending_stats(NULL, NULL);

-- Publish pending statistics for a specific object.
EXEC DBMS_STATS.publish_pending_stats('SCOTT','EMP');

-- Delete pending statistics for a specific object.
EXEC DBMS_STATS.delete_pending_stats('SCOTT','EMP');

ALTER SESSION SET OPTIMIZER_USE_PENDING_STATISTICS=TRUE;