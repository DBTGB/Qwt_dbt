{{
    config(
        materialized='view',
        schema='reporting'
    )
}}


select
c.companyname,c.contactname, d.divisionname, sum(o.linesalesamount) total
from {{ ref('dim_customers') }} c join
{{ ref('fact_orders') }}
o on o.customer_id=c.customerid
join 
{{ ref('divisions') }} d on d.divisionid=c.divisionid
where 
d.divisionname='{{ var('v_division') }}'
group by 
all
order by total desc