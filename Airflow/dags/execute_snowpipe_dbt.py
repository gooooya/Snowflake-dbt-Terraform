# https://airflow.apache.org/docs/apache-airflow-providers-snowflake/stable/operators/snowflake.html#id1
from airflow.providers.snowflake.operators.snowflake import SnowflakeSqlApiOperator
import pendulum
from airflow.sdk import dag

@dag(
    schedule=None,
    # schedule="0 2 * * *",  # 毎日 2:00 UTC
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
    tags=["snowflake_pipe"],
)
def trigger_snowpipe_dbt_manual():
    run_pipe_JAFFLE_SHOP_cus_wake = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus_wake',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        # database="RAW", # TODO:下で完全修飾するならいらないかも
        # schema="JAFFLE_SHOP", # TODO:下で完全修飾するならいらないかも
        sql= '''
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"RAW\".\"JAFFLE_SHOP\".\"DBT_JAFFLE_SHOP_CUSTOMERS_PIPE\"\');
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"RAW\".\"JAFFLE_SHOP\".\"DBT_JAFFLE_SHOP_ORDERS_PIPE\"\');
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"RAW\".\"STRIPE\".\"DBT_STRIPE_PAYMENTS_PIPE\"\');
        '''
    )
    run_pipe_JAFFLE_SHOP_cus = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="RAW",
        schema="JAFFLE_SHOP",
        sql= 'ALTER PIPE "DBT_JAFFLE_SHOP_CUSTOMERS_PIPE" REFRESH;'
    )
    run_pipe_JAFFLE_SHOP_order = SnowflakeSqlApiOperator(
        task_id='run_pipe_order',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="RAW",
        schema="JAFFLE_SHOP",
        sql= 'ALTER PIPE "DBT_JAFFLE_SHOP_ORDERS_PIPE" REFRESH;'
    )
    run_pipe_STRIPE_payments = SnowflakeSqlApiOperator(
        task_id='run_pipe_payment',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="RAW",
        schema="STRIPE",
        sql= 'ALTER PIPE "DBT_STRIPE_PAYMENTS_PIPE" REFRESH;'
    )
    run_pipe_sleep = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus_sleep',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="RAW",
        schema="JAFFLE_SHOP",
        sql= '''
        ALTER PIPE "RAW"."JAFFLE_SHOP"."DBT_JAFFLE_SHOP_CUSTOMERS_PIPE" SET PIPE_EXECUTION_PAUSED=true;
        ALTER PIPE "RAW"."JAFFLE_SHOP"."DBT_JAFFLE_SHOP_ORDERS_PIPE" SET PIPE_EXECUTION_PAUSED=true;
        ALTER PIPE "RAW"."STRIPE"."DBT_STRIPE_PAYMENTS_PIPE" SET PIPE_EXECUTION_PAUSED=true;
        '''
    )
    run_pipe_JAFFLE_SHOP_cus_wake >> [run_pipe_STRIPE_payments, run_pipe_JAFFLE_SHOP_order,run_pipe_JAFFLE_SHOP_cus] >> run_pipe_sleep
execute_et = trigger_snowpipe_dbt_manual()
