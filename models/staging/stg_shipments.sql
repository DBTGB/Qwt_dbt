{{
    config(
        materialized='table'
    )
}}


select 
orderid	,
lineno	,
shipperid , 
customerid ,
productid ,
employeeid ,
to_date(split_part(shipmentdate,' ',1)) shipmentdate ,
status

from {{ source('qwt_raw', 'raw_shipments') }}