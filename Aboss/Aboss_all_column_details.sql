select a.table_name::varchar as table_name_key, 1::integer as "type", a.table_name::varchar
, null::integer as column_seq_no
, null::varchar as column_name, null::varchar as data_type, null::varchar as column_default, null::varchar as is_nullable
from information_schema.tables a
where a.table_schema in ('public') and a.table_type = 'BASE TABLE'
-- and a.table_name = 'client_account'
union
select b.table_name as table_name_key, 2 as "type", null as table_name, b.ordinal_position
, b.column_name
, case when b.data_type = 'character varying' then b.data_type || '(' || b.character_maximum_length || ')'
       when b.data_type = 'numeric' then b.data_type || '(' || b.numeric_precision || ',' || b.numeric_scale || ')' 
  else b.data_type end as data_type
, b.column_default
, b.is_nullable
from information_schema.tables a, information_schema.columns b
where a.table_schema in ('public') and a.table_type = 'BASE TABLE'
and a.table_name = b.table_name
--and a.table_name = 'client_account'
order by table_name_key, "type", column_seq_no nulls first -- column_name
