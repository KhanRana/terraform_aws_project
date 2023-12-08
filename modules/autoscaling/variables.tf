variable "AMI" {
    type = list(string)
    # default = "ami-0505148b3591e4c07"
}

variable "instance_type" {
  type = string
}

variable "security_groups" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "lb-tg-arn" {
  type = string
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}