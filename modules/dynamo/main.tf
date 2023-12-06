

resource "aws_dynamodb_table" "lights_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  attribute {
    name = var.attribute_name
    type = var.attribute_type
  }
  hash_key = var.hash_key
}
