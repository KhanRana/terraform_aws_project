# Get the IP for ssh
data "http" "myipaddr" {
   url = "http://icanhazip.com"
}

resource "aws_security_group" "ssh" {
  vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ssh.id

  cidr_ipv4   = "${chomp(data.http.myipaddr.response_body)}/32"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

# create security group
resource "aws_security_group" "ingress_control" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_http_ingress" {
  type = "ingress"
  security_group_id = aws_security_group.ingress_control.id
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group_rule" "allow_https_ingress" {
  type = "ingress"
  security_group_id = aws_security_group.ingress_control.id
  from_port = "443"
  to_port = "443"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}

resource "aws_security_group" "egress_control" {
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_egress" {
  type = "egress"
  security_group_id = aws_security_group.egress_control.id
  from_port = "0"
  to_port = "0"
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]
}