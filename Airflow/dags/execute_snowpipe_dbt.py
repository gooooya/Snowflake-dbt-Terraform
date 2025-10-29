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
    run_pipe_jaffle_shop_cus_wake = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus_wake',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="raw",
        schema="jaffle_shop",
        sql= '''
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"raw\".\"jaffle_shop\".\"dbt_jaffle_shop_customers_pipe\"\');
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"raw\".\"jaffle_shop\".\"dbt_jaffle_shop_orders_pipe\"\');
        SELECT SYSTEM$PIPE_FORCE_RESUME(\'\"raw\".\"stripe\".\"dbt_stripe_payments_pipe\"\');
        '''
    )
    run_pipe_jaffle_shop_cus = SnowflakeSqlApiOperator(
        task_id='run_pipe_cus',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="raw",
        schema="jaffle_shop",
        sql= 'ALTER PIPE "dbt_jaffle_shop_customers_pipe" REFRESH;'
    )
    run_pipe_jaffle_shop_order = SnowflakeSqlApiOperator(
        task_id='run_pipe_order',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="raw",
        schema="jaffle_shop",
        sql= 'ALTER PIPE "dbt_jaffle_shop_orders_pipe" REFRESH;'
    )
    run_pipe_stripe_payments = SnowflakeSqlApiOperator(
        task_id='run_pipe_payment',
        snowflake_conn_id="snowflake_default_conn",
        warehouse="TEST_WAREHOUSE",
        database="raw",
        schema="stripe",
        sql= 'ALTER PIPE "dbt_stripe_payments_pipe" REFRESH;'
    )
    run_pipe_jaffle_shop_cus_wake >> [run_pipe_stripe_payments, run_pipe_jaffle_shop_order,run_pipe_jaffle_shop_cus]
    # 本来は並列でよい。マシン性能を考慮して直列にする(という体で依存の書き方を確認)
execute_et = trigger_snowpipe_dbt_manual()
