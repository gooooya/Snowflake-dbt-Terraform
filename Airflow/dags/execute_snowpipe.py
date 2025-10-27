# https://airflow.apache.org/docs/apache-airflow-providers-snowflake/stable/operators/snowflake.html#id1
from airflow.providers.snowflake.operators.snowflake import SnowflakeSqlApiOperator
import pendulum
from airflow.sdk import Asset, asset, dag, task

# TODO:定時実行は別途設定する。
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
        warehouse="TEST_WAREHOUSES",
        database="TEST_DB",
        schema="TEST_SCHEMA",
        sql= 'ALTER PIPE TEST_PIPE REFRESH;'
        # sql = 'SELECT CURRENT_ROLE() AS role_in_use, CURRENT_USER() AS user_in_use;'
        # sql = 'SELECT * FROM "TEST_DB"."TEST_SCHEMA"."TEST_TABLE"',
        # sql='''
        # INSERT INTO "TEST_DB"."TEST_SCHEMA"."TEST_TABLE" (A, B)
        # VALUES ('テストデータ', CURRENT_TIMESTAMP);
        # '''
    )
execute_et = trigger_snowpipe_manual()
