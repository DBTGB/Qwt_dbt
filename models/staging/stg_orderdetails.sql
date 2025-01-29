{{
    config(
        materialized='incremental',
        unique_key=['order_id','line_no']
    )
}}

select od.*,o.order_date from {{ source('qwt_raw', 'raw_orders') }} o inner join 
{{ source('qwt_raw', 'raw_orderdetails') }} od on o.order_id=od.order_id

{% if is_incremental() %}
where o.order_date > ( select max(order_date) from {{ this }} ) 
{% endif %}