
-- http://jko-licorne.com/oracle/?p=1674 

CREATE OR REPLACE FUNCTION EXTRACT_ACCESS_PREDICATES (pIn  varchar2, pOwner varchar2, pIndex Varchar2) return varchar2 as
Type    T_string Is Table Of varchar2(40);
ltCols  T_string;
lResult varchar2 (500):=null;
begin
if pIn is not null then   
  Select column_name  bulk collect into lTCols from dba_ind_columns where index_owner=pOwner and index_name = pIndex;   
   if lTCols.FIRST is not null then
    For I In 1..lTCols.Last Loop
    if instr (pIn,lTCols(I)) &amp;lt;&amp;gt; 0 Then
      if lResult is null Then
       lResult := lTCols(I);
      else
       lResult := lResult || ';' || lTCols(I);
      End if;
     End if;
    End Loop;
  End if;
End if;
lResult := replace (lResult,'"','');
return lResult;
end;
/

CREATE OR REPLACE FUNCTION EXTRACT_FILTER_PREDICATES (pIn  varchar2, pOwner varchar2, pTable Varchar2) return varchar2 as
Type    T_string Is Table Of varchar2(40);
ltCols  T_string;
lResult varchar2 (500):=null;
begin
if pIn is not null then
   
  Select column_name  bulk collect into lTCols from dba_Tab_columns where owner = pOwner and Table_name = pTable;
   
   if lTCols.FIRST is not null then
    For I In 1..lTCols.Last Loop
     if instr (pIn,lTCols(I)) &amp;lt;&amp;gt; 0 Then
      if lResult is null Then
       lResult := lTCols(I);
      else
       lResult := lResult || ';' || lTCols(I);
      End if;
     End if;
    End Loop;
  End if;
End if;
lResult := replace (lResult,'"','');
return lResult;
end;
/


-- Check index access predicates efficiency for a specific sql_id
Select predicats.OBJECT_OWNER, Indxs.table_name,Indxs.index_name,predicats.object_alias,predicats.object_type,
predicats.CARDINALITY,predicats.cost,predicats.Access_Pred,Indxs.colsInIndex, predicats.plan_hash_value,predicats.id
from
(
  select plan_hash_value,id,OBJECT_OWNER,object_name,object_alias,object_type,CARDINALITY,cost,Extract_Access_predicates (ACCESS_PREDICATES,OBJECT_OWNER,object_name) Access_Pred
  From v$sql_plan where sql_id='ft0tmmzf8k0qn'  and ACCESS_PREDICATES is not null and object_type like 'INDEX%'
) predicats join
(
select
      index_owner,
      table_name,
      index_name,
      listagg (column_name, ';') 
WITHIN GROUP (ORDER BY COLUMN_POSITION) colsInIndex
FROM dba_ind_columns
GROUP BY index_owner,table_name,index_name
) Indxs
on (Indxs.index_name=predicats.object_name and Indxs.index_owner=predicats.OBJECT_OWNER)
order by plan_hash_value,id;

-- Check index filter predicates. Index is used to filter the result as it cannot be use for access.
Select predicats.OBJECT_OWNER, Indxs.table_name,Indxs.index_name,predicats.object_alias,predicats.object_type,
predicats.CARDINALITY,predicats.cost,predicats.filter_pred,Indxs.colsInIndex, predicats.plan_hash_value,predicats.id
from
(
  select plan_hash_value,id,OBJECT_OWNER,object_name,object_alias,object_type,CARDINALITY,cost,Extract_Access_predicates (filter_predicates,OBJECT_OWNER,object_name) filter_pred
  From v$sql_plan where sql_id='ft0tmmzf8k0qn' and filter_predicates is not null and object_type like 'INDEX%' 
) predicats join
(
select
      index_owner,
      table_name,
      index_name,
      listagg (column_name, ';') 
WITHIN GROUP (ORDER BY COLUMN_POSITION) colsInIndex
FROM    dba_ind_columns
GROUP BY    index_owner,table_name,index_name
) Indxs
on (Indxs.index_name=predicats.object_name and Indxs.index_owner=predicats.OBJECT_OWNER)
order by plan_hash_value,id;

-- Check table filter predicates. Potentially missing indexes.
Select OBJECT_OWNER, object_alias,object_type,CARDINALITY,cost,filter_pred, plan_hash_value,id
from
(
  select plan_hash_value,id,OBJECT_OWNER,object_name,object_alias,object_type,CARDINALITY,cost,Extract_Filter_predicates (filter_predicates,OBJECT_OWNER,object_name) filter_pred
  From v$sql_plan where sql_id='ft0tmmzf8k0qn' and filter_predicates is not null and object_type like 'TABLE%'
)  
order by plan_hash_value,id;
