{% macro get_ship_id() %}

{% set get_shipid %}

select distinct shipper_id from {{ ref('fact_orders') }} order by 1

{% endset %}

{% set results=run_query(get_shipid) %}

{% if execute %}
{% set shipidlist=results.columns[0].values() %}
{% else %}
{% set shipidlist=[] %}
{% endif %}
{{ return(shipidlist) }}
{% endmacro %}