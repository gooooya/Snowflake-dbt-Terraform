resource "snowflake_warehouse" "this" {
  for_each = { for w in var.warehouses : w.name => w }

  name = each.value.name
  warehouse_size = each.value.warehouse_size
  auto_suspend = each.value.auto_suspend
  auto_resume = each.value.auto_resume
  initially_suspended = each.value.initially_suspended
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/warehouse