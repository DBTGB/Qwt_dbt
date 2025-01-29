{{
    config(
        materialized='table',
        schema='transforming',
        sql_header='use warehouse compute_wh;'
    )
}}




select get(xmlget(contact_info,'SupplierID'),'$')  suppiler_id ,
get(xmlget(contact_info,'CompanyName'),'$')::varchar company_name,
get(xmlget(contact_info,'ContactName'),'$')::varchar Contact_Name,
get(xmlget(contact_info,'Address'),'$')::varchar Address,
get(xmlget(contact_info,'City'),'$')::varchar City,
get(xmlget(contact_info,'PostalCode'),'$')::varchar Postal_Code,
get(xmlget(contact_info,'Country'),'$')::varchar Country,
get(xmlget(contact_info,'Phone'),'$')::varchar Phone,
get(xmlget(contact_info,'Fax'),'$')::varchar fax
from
{{ ref('stg_suppliers') }}