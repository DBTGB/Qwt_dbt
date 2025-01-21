{{
    config(
        materialized='table',
        schema='salesmart'
    )
}}

select * from {{ ref('tfg_customers') }}