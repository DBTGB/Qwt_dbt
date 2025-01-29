{{
    config(
        materialized='view',
        schema='salesmart'
    )
}}

select * from {{ ref('tfg_products') }}