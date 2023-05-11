resource "aws_db_subnet_group" "private_subnets_group" {
  name       = "private-subnets-for-rds"
  subnet_ids = var.private_subnets_ids
}


resource "aws_security_group" "security_group_for_rds" {
  name        = "security-group-rds"
  description = "Allow traffic from and to the instance"
  vpc_id      = var.vpc_id

  tags = merge(local.tags, { "Name" = "security-group-rds" })

  lifecycle {
    # Necessary if changing 'name' or 'name_prefix' properties.
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "allow_incoming_to_database" {
  type              = "ingress"
  description       = "Allow all incoming"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.security_group_for_rds.id
}

resource "aws_security_group_rule" "allow_outgoing_from_database" {
  type              = "egress"
  description       = "Allow all outgoing"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.security_group_for_rds.id
}