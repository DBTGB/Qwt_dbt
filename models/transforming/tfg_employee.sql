{{
    config(
        materialized='table',
        schema='transforming',
        sql_header='use warehouse compute_wh;'
    )
}}

select 
emp.empid,
emp.first_name, 
emp.title ,
emp.extension, 
coalesce(mgr.first_name, emp.first_name) manager_name,
coalesce(mgr.title, emp.title) as managertitle,
emp.hire_date,
emp.year_salary,
ofc.office_address ,
ofc.office_city,
ofc.office_counter
from {{ ref('stg_employee') }} emp left join 
{{ ref('stg_employee') }} mgr on emp.reports_to=mgr.empid
left join {{ ref('stg_office') }} ofc on ofc.office=emp.office