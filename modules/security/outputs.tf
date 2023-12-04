output "ingress_control_id" {
  value = aws_security_group.ingress_control.id
}

output "egress_control_id" {
  value = aws_security_group.egress_control.id
}

output "security_group_ids" {
  value = [aws_security_group.ingress_control.id, aws_security_group.egress_control.id]
}