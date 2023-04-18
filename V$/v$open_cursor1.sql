--
-- How To Determine the SQL Expression That May Be Causing ORA-01000 (Doc ID 1333600.1)
--

select
c.sid as "OraSID",
c.address||':'||c.hash_value as "SQL Address",
COUNT(c.saddr) as "Cursor Copies"
from v$open_cursor c
group by
c.sid,c.address||':'||c.hash_value
having COUNT(c.saddr) > 2 order by 3 DESC ;

-- then pass the result from 'SQL Address' to the following :

select SQL_FULLTEXT from v$sql where ADDRESS ||':'||HASH_VALUE = '<SQL Address>' ;

-- To determine the SQL by user session :

select user_name,o.sid, osuser, machine, count(*) num_curs
from v$open_cursor o, v$session s
where o.sid=s.sid
group by user_name,o.sid, osuser, machine
order by num_curs desc;

-- then pass the result from o.sid to the following :

select q.sql_text
from v$open_cursor o, v$sql q
where q.hash_value=o.hash_value and o.sid = XXX;

--
--
--
select sql_id,count(*) from v$open_cursor 
group by sql_id  having count(*) > 5
order by count(*) desc ;

select * from v$session ;

select * from v$sesstat ;