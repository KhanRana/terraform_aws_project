# create launch configuration for asg instance
resource "aws_launch_configuration" "ec2_instance" {
  count           = length(var.AMI)
  name_prefix     = "aws-asg-"
  image_id        = var.AMI[count.index]
  instance_type   = var.instance_type
  security_groups = [var.security_groups]

  lifecycle {
    create_before_destroy = true
  }
}

# create auto acaling groups
resource "aws_autoscaling_group" "asg-group" {
  count                = length(var.public_subnets)
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.ec2_instance[count.index].name
  vpc_zone_identifier  = var.public_subnets
}

# attach groups to the load balancer
resource "aws_autoscaling_attachment" "asg-attachment" {
  count                = length(var.public_subnets)
  autoscaling_group_name = aws_autoscaling_group.asg-group[count.index].id
  lb_target_group_arn    = var.lb-tg-arn
}
