def model(dbt, session):
    df = dbt.source("qwt_raw", "raw_products")
    return df