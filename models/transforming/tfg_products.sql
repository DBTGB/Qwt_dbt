{{
    config(
        materialized='table',
        schema='transforming',
        sql_header='use warehouse compute_wh;'
    )
}}

select * exclude(stateprovince) , 
iff(stateprovince='', 'NA',stateprovince) statename from {{ ref('stg_customers') }}

