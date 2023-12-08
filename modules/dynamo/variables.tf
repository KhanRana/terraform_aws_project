variable "table_name" {
type = list(string)
}

variable "read_capacity" {
  type = string
}

variable "write_capacity" {
  type = string
}

variable "attribute_name" {
  type = string
}

variable "attribute_type" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "billing_mode" {
  type = string
}

