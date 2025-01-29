{% macro get_max_orderdate() -%}
 
{% set get_maxorderdate_query %}
 
select
max(order_date)
from {{ ref('fact_orders') }}
 
{% endset %}
 
{% set results = run_query(get_maxorderdate_query) %}
 
{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0][0] %}
{% else %}
{% set results_list = [] %}
{% endif %}
 
{{ return(results_list) }}
 
{% endmacro %}
 