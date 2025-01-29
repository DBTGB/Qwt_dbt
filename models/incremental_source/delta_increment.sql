{{
    config(
        materialized='incremental',
        schema='my_new_schema',
        unique_key=['id','record_insert']
        
    )
}}


select * from {{ source('raw_to_stg', 'raw_table') }}

{% if is_incremental() %}
    where record_insert > (select max(record_insert) from {{ this }}) 
{% endif %}