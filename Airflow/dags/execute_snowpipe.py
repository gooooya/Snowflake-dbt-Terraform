# https://airflow.apache.org/docs/apache-airflow-providers-snowflake/stable/operators/snowflake.html#id1
from airflow.providers.snowflake.operators.snowflake import SnowflakeSqlApiOperator
import pendulum
from airflow.sdk import Asset, asset, dag, task


@dag(
    schedule=None,
    start_date=pendulum.datetime(2021, 1, 1, tz="UTC"),
    catchup=False,
    tags=["snowflake_pipe"],
)
def trigger_snowpipe_manual():
    run_pipe = SnowflakeSqlApiOperator(
        task_id='run_pipe',
        snowflake_conn_id="snowflake_default_conn",
        sql="ALTER PIPE TEST_DB.TEST_SCHEMA.TEST_PIPE REFRESH;"
    )
execute_et = trigger_snowpipe_manual()
