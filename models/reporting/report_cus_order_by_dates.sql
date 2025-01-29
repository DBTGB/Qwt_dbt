{{
    config(
        materialized='view',
        schema='reporting'
    )
}}

select 
c.companyname,c.contactname,c.city,min(o.order_date) first_order_date, max(o.order_date)
 recent_order_date,
sum(o.quantity) total_quantity ,count(p.productid) products_count,sum(o.linesalesamount) total_sales
from 
{{ ref('fact_orders') }} o join 
{{ ref('dim_customers') }} c on o.customer_id=c.customerid join 
{{ ref('stg_products') }} p on o.product_id=p.productid
group by c.companyname,c.contactname,c.city