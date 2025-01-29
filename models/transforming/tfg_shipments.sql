{{
    config(
        materialized='table',
        schema='transforming'
    )
}}

select 
sh.orderid,
sh.lineno,
s.companyname,
sh.shipmentdate,
sh.status
from 
{{ ref('shipmentsnapshot') }} as sh left join 
{{ ref('shipper') }} s on s.shipperid=sh.shipperid
where sh.dbt_valid_to is null