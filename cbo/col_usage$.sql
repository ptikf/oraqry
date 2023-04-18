select o.name,c.name,
us.equality_preds As Equality,
us.equijoin_preds As Equijoin,
us.nonequijoin_preds As NonEquijoin,
us.range_preds As Range,
us.like_preds As "Like",
us.null_preds As "Null",
us.timestamp as "Timestamp" from col_usage$ us,obj$ o,col$ c
where 
us.obj#=o.obj# and
c.obj#=us.obj#
and c.col#=us.intcol# 
and owner# =27
--- and o.name = 'CLIENT'
order by timestamp desc, o.name, us.intcol# ;


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

SELECT
o.object_name,
--
c.column_name,
c.column_id colid,
c.data_type,
c.low_value,
c.high_value,
c.density,
c.num_nulls,
c.num_distinct,
c.num_buckets bkts,
case c.histogram when 'FREQUENCY' then 'FREQ' when 'HEIGHT BALANCED' then 'HB' else ' ' end histo,
c.last_analyzed,
--
u.EQUALITY_PREDS equals,
u.EQUIJOIN_PREDS eqjoin,
u.NONEQUIJOIN_PREDS neqjoin,
u.RANGE_PREDS range,
u.LIKE_PREDS likep ,
u.null_preds nullp,
u.timestamp
FROM sys.col_usage$ u,
user_objects o,
user_tab_columns c
WHERE 1=1 
and u.obj# = o.object_id
AND o.object_name = 'FACT_LADM' and o.object_type = 'TABLE' 
AND c.column_id = u.intcol#
AND c.TABLE_NAME = o.object_name
order by c.column_id
;

select * from SYS.COL_USAGE$;
select * from user_objects where object_name = 'FACT_LADM'  and object_type = 'TABLE' ;
