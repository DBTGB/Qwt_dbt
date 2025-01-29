{% snapshot shipmentsnapshot %}
    {{
        config(
            target_schema='SNAPSHOTS',
            target_database='DBT_DEV',
            unique_key="orderid||'-'||lineno",
            strategy='timestamp',
            updated_at='shipmentdate'
        )
    }}

    select * from {{ ref('stg_shipments') }}
 {% endsnapshot %}

