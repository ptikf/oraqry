select   min(sample_time) st1 ,max(sample_time) st2
from dba_hist_active_sess_history ash where sql_id = '9bmvd2spuyprx';



select q.*,text.sql_text from (
select ash.sql_id sqlid, ash.session_id sid , min(sample_time) st1 ,max(sample_time) st2
from dba_hist_active_sess_history ash 
where ash.sql_id in (
'9bmvd2spuyprx',
'bvc24ybbzzsfz',
'7uta93dmtawhg',
'1v8d6p8hzpfrs',
'a82wys7j6ywg5',
'a6dsg0wpfm6mb',
'bhw84a1wuqfht',
'f2sy7bwqdn12v',
'cs8f67xasucqn',
'36tb04cyn5ym7',
'565hxrkc55kby',
'aj8rb7p7cnhjy',
'd3kr850jy8cfm',
'cs8f67xasucqn',
'a82wys7j6ywg5',
'a6dsg0wpfm6mb',
'dah7rpp9gb2tx',
'92zbqfv62d5j3',
'4czn0fc9vakcj',
'gxr9wbpj9f0sp',
'6xuqdpmg51z1t',
'agxps07dqgzng',
'cvpb78mykg3z7',
'asc1bb9d8mpd0',
'879vjs6q0bkg2',
'7cj4z59jc2pg7',
'fthpkuukn1yhz',
'0kvt1zn2but1k',
'7mms3gn48n1gz',
'1fughj13g3rkd',
'amsvyzmpjcg8y',
'c2qw55ugpbpp6',
'6cmfqvst43spt',
'g3q02mt7rn3t0',
'9p7y36j5kx0gz',
'5gpq4xvysagmk',
'du876t21vq1dh',
'4r25ntrc08t6u',
'd4cx9zhctw1n6',
'0jrcqd0vrrhx2',
'779u3xdfvag0x',
'1pufs4xg0btgy',
'a8324ncnjxf7m',
'48ykrfa39hut2',
'9k99zj24mc36d',
'dq7c7fbt298j3')
and sample_time >= to_date('19/04/2017 14:00','DD/MM/YYYY HH24:MI')
and sample_time <= to_date('19/04/2017 22:30','DD/MM/YYYY HH24:MI')
group by ash.sql_id,ash.session_id) q
left outer join dba_hist_sqltext text on q.sqlid = text.sql_id 
order by q.st1;