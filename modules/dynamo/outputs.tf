output "table_name" {
  value = aws_dynamodb_table.lights_table.name
}

output "hash_key" {
  value = aws_dynamodb_table.lights_table.hash_key
}
