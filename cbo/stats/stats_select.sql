select table_name,num_rows,blocks,last_analyzed from all_tables where owner= 'CARP' order by last_analyzed desc nulls last ;

select * from user_tab_col_statistics where table_name = 'ROLE_CARDPRO' ; 

select * from user_histograms where table_name = 'ROLE_CARDPRO' ; 

select u.name,o.name,c.name,
us.equality_preds As Equality,
us.equijoin_preds As Equijoin,
us.nonequijoin_preds As NonEquijoin,
us.range_preds As Range,
us.like_preds As "Like",
us.null_preds As "Null",
us.timestamp as "Timestamp" from sys.col_usage$ us, sys.obj$ o, sys.col$ c, sys.user$ u
where 
o.obj#=us.obj# and
c.obj#=us.obj# and 
c.col#=us.intcol# and 
owner#=u.user# 
and o.name = 'NOEUD_REGROUPEMENT_R'
and u.name = 'CARP_TEST' 
order by timestamp desc, o.name, us.intcol# ;

select 
owner,
table_name tname,
column_name cname,
column_id id,
data_type,
num_distinct dstinct,
--dbms_stats.convert_raw_value(low_value),
decode(data_type
,'NUMBER'     ,utl_raw.cast_to_number(low_value)
,'VARCHAR2'   ,utl_raw.cast_to_varchar2(low_value)) low_value,
decode(data_type
,'NUMBER'     ,utl_raw.cast_to_number(high_value)
,'VARCHAR2'   ,utl_raw.cast_to_varchar2(high_value)) high_value,
-- high_value,
density,
num_nulls nulls ,
num_buckets buckets,
last_analyzed,
--sample_size,
histogram 
 from all_tab_cols 
where table_name = 'T1' 
and owner = user 
order by column_id ;
