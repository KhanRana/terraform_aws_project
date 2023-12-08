output "table_name" {
  value = aws_dynamodb_table.dyno_table[*].name
}

output "hash_key" {
  value = aws_dynamodb_table.dyno_table[*].hash_key
}
