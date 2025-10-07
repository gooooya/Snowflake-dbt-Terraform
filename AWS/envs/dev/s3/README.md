include {
  path = find_in_parent_folders()
}
だと中の変数を明示的に読み込めないのにこれないと認証情報エラーになるのはさすがにおかしくないか。
locals {
  root_locals = read_terragrunt_config(find_in_parent_folders()).locals
  env_locals  = read_terragrunt_config(find_in_parent_folders()).locals
}
で中身読み込んでるけどほかに正しい呼び方がありそう。