{{
    config(
        materialized='incremental',
        unique_key='order_id'
    )
}}

select * from {{ source('qwt_raw', 'raw_orders') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where order_date > (select max(order_date) from {{ this }}) 
{% endif %}