#### 前提
RSA鍵を作成し、このフォルダに配置していること。  
openssl genrsa 2048 > rsa_key.p8  
openssl rsa -in rsa_key.p8 -pubout -out rsa_key.pub  
#### 手順
1. 公開鍵(.pub)をSnowflakeに登録する。
    namespaceでrsa_userを指定すればOK

- Airflow:
    docker-compose.yamlにて秘密鍵をマウントする。
    volumes:
      /mnt/c/Users/taira/OneDrive/デスクトップ/Snowflake-dbt-Terraform/keys:/opt/airflow/keys
      AIrflow配下に起きたくない(Snowflake側でも参照する)ためフルパス指定としている。
- dbt-cloude: 
    ブラウザ上でenvironments作成時に設定。
- dbt Core: 
    ブラウザ上でenvironments作成時に設定。
