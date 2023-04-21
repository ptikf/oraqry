select
              c.column_id
              ,c.column_name
              ,c.data_type
              ,c.data_length
              ,c.nullable
              ,c.default_on_null
              ,c.num_distinct
              ,c.num_nulls
              ,c.density
        ,decode(substr(c.data_type,1,9) -- as there are several timestamp types
          ,'NUMBER'       ,to_char(utl_raw.cast_to_number(c.low_value))
          ,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(c.low_value))
          ,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(c.low_value))
          ,'BINARY_DO',to_char(utl_raw.cast_to_binary_double(c.low_value))
          ,'BINARY_FL' ,to_char(utl_raw.cast_to_binary_float(c.low_value))
  ,'DATE',rtrim(
               to_char(100*(to_number(substr(low_value,1,2),'XX')-100)
                      + (to_number(substr(low_value,3,2),'XX')-100),'fm0000')||'-'||
               to_char(to_number(substr(low_value,5,2),'XX'),'fm00')||'-'||
               to_char(to_number(substr(low_value,7,2),'XX'),'fm00')||' '||
               to_char(to_number(substr(low_value,9,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(low_value,11,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(low_value,13,2),'XX')-1,'fm00'))
  ,'TIMESTAMP',rtrim(
               to_char(100*(to_number(substr(low_value,1,2),'XX')-100)
                      + (to_number(substr(low_value,3,2),'XX')-100),'fm0000')||'-'||
               to_char(to_number(substr(low_value,5,2),'XX'),'fm00')||'-'||
               to_char(to_number(substr(low_value,7,2),'XX'),'fm00')||' '||
               to_char(to_number(substr(low_value,9,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(low_value,11,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(low_value,13,2),'XX')-1,'fm00')
              ||'.'||to_number(substr(low_value,15,8),'XXXXXXXX')  )
       ) low_v
        ,decode(substr(c.data_type,1,9) -- as there are several timestamp types
          ,'NUMBER'       ,to_char(utl_raw.cast_to_number(c.high_value))
          ,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(c.high_value))
          ,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(c.high_value))
          ,'BINARY_DO',to_char(utl_raw.cast_to_binary_double(c.high_value))
          ,'BINARY_FL' ,to_char(utl_raw.cast_to_binary_float(c.high_value))
  ,'DATE',rtrim(
               to_char(100*(to_number(substr(high_value,1,2),'XX')-100)
                      + (to_number(substr(high_value,3,2),'XX')-100),'fm0000')||'-'||
               to_char(to_number(substr(high_value,5,2),'XX'),'fm00')||'-'||
               to_char(to_number(substr(high_value,7,2),'XX'),'fm00')||' '||
               to_char(to_number(substr(high_value,9,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(high_value,11,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(high_value,13,2),'XX')-1,'fm00'))
  ,'TIMESTAMP',rtrim(
               to_char(100*(to_number(substr(high_value,1,2),'XX')-100)
                      + (to_number(substr(high_value,3,2),'XX')-100),'fm0000')||'-'||
               to_char(to_number(substr(high_value,5,2),'XX'),'fm00')||'-'||
               to_char(to_number(substr(high_value,7,2),'XX'),'fm00')||' '||
               to_char(to_number(substr(high_value,9,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(high_value,11,2),'XX')-1,'fm00')||':'||
               to_char(to_number(substr(high_value,13,2),'XX')-1,'fm00')
              ||'.'||to_char(to_number(substr(low_value,15,8),'XXXXXXXX')))
          ,  c.high_value
               ) hi_v
                     ,c.histogram
                     ,u.equality_preds,u.equijoin_preds,nonequijoin_preds,range_preds,like_preds,null_preds , u.timestamp
        --,low_value,high_value
        from  dba_objects o 
        left outer join dba_tab_columns c on c.table_name = o.object_name
        left outer join sys.col_usage$ u on o.object_id = u.obj# and c.column_id = u.intcol#
        where 
        o.object_type = 'TABLE'
        and o.object_name='EMPLOYEES'
        and o.owner = upper('HR')
        order by c.column_id
        