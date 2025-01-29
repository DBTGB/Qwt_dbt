-- macros/incremental_macro.sql

{% macro incremental_load(source_table, target_table, unique_key, timestamp_column) %}

{{ config(
    materialized='incremental',
    unique_key=unique_key
) }}

with new_records as (
    select 
        src.*
    from 
        {{ ref(source_table) }} as src
    left join {{ ref(target_table) }} as tgt
    on src[unique_key] = tgt[unique_key]
    where src[timestamp_column] > tgt[timestamp_column] or tgt[unique_key] is null
)

select * from new_records

{% endmacro %}
