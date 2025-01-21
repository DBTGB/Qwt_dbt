{{
    config(
        materialized='table',
        schema='transforming',
        sql_header='use warehouse compute_wh;'
    )
}}

select 
o.order_id,
od.line_no,
od.product_id,
o.customer_id,
o.employee_id,
o.shipper_id,
o.freight,
od.quantity,
od.unit_price,
od.discount,
od.order_date,
to_decimal((od.unit_price * od.quantity) * (1-od.discount),10,2) as  linesalesamount,
to_decimal(p.unitcost*od.quantity,10,2) costofgoodssold,
to_decimal(((od.unit_price * od.quantity) * (1-(od.discount)) - (p.unitcost * (od.quantity))),9,2) margin
from 
{{ ref('stg_orders') }} o inner join 
{{ ref('stg_orderdetails') }} od on o.order_id=od.order_id 
inner join 
{{ ref('stg_products') }} p on 
p.productid=od.product_id
 
 