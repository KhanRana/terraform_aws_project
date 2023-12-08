# Autoscaled instances
output "autoscaled_instances" {
  value = aws_launch_configuration.ec2_instance[*].id
}

# Auscaled groups 
output "autoscaled_groups" {
  value = aws_autoscaling_group.asg-group[*].id
}


