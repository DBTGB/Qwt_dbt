{{
    config(
        materialized='table',
        schema='transforming',
        sql_header='use warehouse compute_wh;'
    )
}}

select 
c.customerid,
c.companyname,
c.contactname,
c.city,
c.country,
d.divisionid,
c.address,
c.fax,
c.phone,
c.postalcode,
iff(c.stateprovince='', 'NA',c.stateprovince) statename from {{ ref('stg_customers') }} c
inner join {{ ref('divisions') }} d on d.divisionid=c.divisionid