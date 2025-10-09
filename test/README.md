下記のような相対パス指定がめんどくさすぎる。
```hcl  
config_path = "../../../../snowflake/envs/dev/account_obj/storage_integration"
```
  
ならパスをyamlにしてしまえばいいじゃないかということでスクリプトを作成。実行すると下記のようにroot(スクリプトの場所)からの相対パスをまとめたyamlができる。
```yaml
module:
  iam_role: AWS\modules\iam_role
```
上記出力結果はrootなので

```hcl
locals {
  root_folder = dirname(find_in_parent_folders("folders.yaml"))
  relative_path_from_route = yamldecode(file(find_in_parent_folders("folders.yaml")))
}

terraform {
  source = "${local.root_folder}\\${local.relative_path_from_route.module.iam_role}"
}
```

yamlのキーを末端のフォルダ名にしてるからこれが一意じゃないとどうなるかわかんないけどね！まあどのリソースかわかんなくなるし多分一意でしょヘーキヘーキ