-- https://raw.githubusercontent.com/tanelpoder/tpt-oracle/master/tabhist.sql

select
    h.column_name                  tabhist_col_name
  , c.data_type                    tabhist_data_type
  , h.endpoint_number
  , CASE 
        WHEN c.data_type = 'NUMBER' THEN LPAD(TO_CHAR(h.endpoint_value), 30, ' ') 
        WHEN c.data_type IN ('CHAR', 'VARCHAR2', 'NCHAR', 'NVARCHAR2') THEN
				 h.endpoint_value
             -- hexstr(to_number((substr(trim(to_char(h.endpoint_value,lpad('x',63,'x'))),1,12)),'XXXXXXXXXXXXXXXX'))
             --hexstr(substr(to_char(h.endpoint_value,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'),1,12))
        ELSE
             substr(trim(to_char(h.endpoint_value,lpad('x',63,'x'))),1,12)
    END tabhist_ep_value
  , CASE WHEN c.histogram = 'FREQUENCY' THEN
        h.endpoint_number - lag(endpoint_number, 1) over ( order by h.owner, h.table_name, h.column_name, h.endpoint_number) ELSE NULL END frequency
   ,CASE WHEN c.histogram = 'HEIGHT BALANCED' THEN 
        CASE WHEN c.data_type = 'NUMBER' THEN 
              h.endpoint_value - lag(endpoint_value, 1) over ( order by h.owner , h.table_name , h.column_name , h.endpoint_number ) ELSE null END  
    ELSE null END height_bal
--  , hexstr(h.endpoint_value)              tabhist_ep_value
--  , to_char(h.endpoint_value,'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')              tabhist_ep_value2
  , h.endpoint_actual_value        tabhist_ep_actual_value
from
    dba_tab_columns     c
  , dba_tab_histograms  h
where
    c.owner         = h.owner
and c.table_name    = h.table_name
and c.column_name   = h.column_name
and upper(h.table_name) = 'BUKRS' 
AND upper(h.owner) = 'LADM_OWNER' 
AND UPPER(h.column_name) = 'BUKRS'
ORDER BY    h.owner  , h.table_name  , h.column_name  , h.endpoint_number ;
