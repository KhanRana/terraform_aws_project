

resource "aws_dynamodb_table" "dyno_table" {
  count          = length(var.table_name)
  name           = var.table_name[count.index]
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
  hash_key = var.hash_key
}
