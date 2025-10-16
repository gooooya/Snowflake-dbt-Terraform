本来はnamespqce.yamlみたいなものを作ってリテラルは全体的にここを見るようにしたほうが良いらしい？  
今回はリストアイテムを与える場所(ユーザ)はyaml参照を採用し、フォルダ名と1:1対応する部分(DB名等子以降で参照するものが同じやつ)の部分はenv_XXX.hclでフォルダ名を取得し、子以降はこれを参照することとする。  
yaml参照と使い分けると混乱するかな...  

参考サイトが
├── database_objects
│   └── {database_name}
│       ├── namespace_vars.yaml
│       ├── database_role
│       └── schema
│           └── {schema_name}
└── schema_objects
    └── {database_name}
        └── {schema_name}
            ├── namespace_vars.yaml
            ├── function
            └── view
という構成らしく、であればフォルダ名の{database_name}直接取得してあげればいいように見えている。フォルダ名と同じ名前をnamespace_vars.yamlで定義することになりそうだし。各{database_name}フォルダにenv_XXX.hclがあるの若干きもい。でもスキーマ増やす時コピペしてフォルダ名変えるだけで済むのは便利そう。
中身が
terraform {
  source = "../../../../../../modules/database_obj/${local.env_dbname.name}/schema/${local.schema_name}"
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_dbname  = read_terragrunt_config(find_in_parent_folders("env_dbname.hcl")).locals
  schema_name = basename(get_terragrunt_dir())
}

inputs = {
  database_name = local.env_dbname.name
  schema_name = local.schema_name
}
のため、スキーマ増やす時ファイルの中身みる必要ないはず。  

懸念  
- フォルダ名変えられた途端に破綻する
- yaml参照と使い分けると混乱する
- インデントが深い
- 結局パス指定の時"../../../table/test_table"となってしまう

参考
https://zenn.dev/dataheroes/articles/20250420-snowflake-iac-redesign-with-terragrunt?参照m_source=chatgpt.com


---
Error: could not build dsn for snowflake connection err = 260009: two regions specified
環境変数：SNOWFLAKE_ACCOUNT直して(.un-east-1消して)再起動したらいけた。