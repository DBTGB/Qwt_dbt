import snowflake.snowpark.functions as functions

def model(dbt, session):
    dbt.config(
        materialized='incremental',
        unique_key='order_id'
    )
    df_orders = dbt.source('qwt_raw', 'raw_orders')

    if dbt.is_incremental:
        max_order_date = session.sql(f"SELECT MAX(order_date) FROM {dbt.this}").collect()[0][0]
        df_orders = df_orders.filter(df_orders['order_date'] > functions.lit(max_order_date))

    return df_orders
