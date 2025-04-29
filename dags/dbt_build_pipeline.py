from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner':'admin',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
    'start_date': datetime(2025, 4, 30),
    'email_on_failure': True,
    'email_on_retry': False,
    'email_on_success': False,
}

with DAG(
    dag_id = 'dbt_transform_data',
    default_args = default_args,
    schedule_interval = '@daily',
    catchup = False,
) as dags:
    
    dbt_build = BashOperator(
        task_id = 'dbt_build',
        bash_command = 'cd /dbt/fsoft_mavenfuzzyfactory && dbt build',
        dag = dags,
    )

    dbt_build