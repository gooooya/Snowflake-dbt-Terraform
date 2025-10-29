# destory前に実施
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
def trigger_snowpipe_dbt_manual_sleep():
    run_pipe_sleep = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus_sleep',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="raw",
        schema="jaffle_shop",
        sql= '''
        ALTER PIPE "raw"."jaffle_shop"."dbt_jaffle_shop_customers_pipe" SET PIPE_EXECUTION_PAUSED=true;
        ALTER PIPE "raw"."jaffle_shop"."dbt_jaffle_shop_orders_pipe" SET PIPE_EXECUTION_PAUSED=true;
        ALTER PIPE "raw"."stripe"."dbt_stripe_payments_pipe" SET PIPE_EXECUTION_PAUSED=true;
        '''
    )
execute_et = trigger_snowpipe_dbt_manual_sleep()
