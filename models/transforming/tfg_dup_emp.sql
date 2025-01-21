{{config(materialized = 'table', schema = 'transforming')}}
 
with recursive managers (indent, employeeid, managerid, employeetitle)
as
(
    select ' ' as indent, empid as employeeid, reportsto as managerid, title as employeetitle
    from
    {{ref('stg_employee')}}
    where title = 'President'
 
    union all
 
    select indent || '* ', employees.empid as employeeid, employees.reportsto as managerid, employees.title
    as employeetitle
 
    from
 
    {{ref("stg_employee")}} as employees join managers
    on employees.reports_to = managers.empid
)
 
select indent || employeetitle as title, employeeid, managerid
from managers
 