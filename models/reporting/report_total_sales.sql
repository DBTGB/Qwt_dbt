{{
    config(
        materialized='view',
        schema='reporting'
    )
}}

{% set sid=get_ship_id() %}

select order_id,

{% for item in sid %}
    sum(case when shipper_id={{item}} then linesalesamount end) as shipper_id{{item}}_amount,
{% endfor %}
sum(linesalesamount) total_sales from {{ ref('fact_orders') }}
group by 1
