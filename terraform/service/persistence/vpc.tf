# TODO Everything below in persistence
# Get available zones for this account
#data "aws_availability_zones" "available" {
#  state = "available"
#}
#
#resource "aws_subnet" "alternating" {
#  availability_zone       = data.aws_availability_zones.available.names[1]
#  vpc_id                  = aws_vpc.vpc.id
#  map_public_ip_on_launch = false
#  cidr_block              = "10.0.4.0/24"
#  tags                    = merge(local.tags, { "Name" = "alternating" })
#}

# Open connexion for the migration data transfer
#resource "aws_route_table_association" "route_association_open_rds" {
#  count          = var.openRdsToPublicInternet ? 1 : 0
#  subnet_id      = aws_subnet.alternating.id
#  route_table_id = aws_route_table.public_route_table.id
#}

#TODO Merge with alternating subnet for now ?
resource "aws_db_subnet_group" "private_subnets_group" {
  name       = "private-subnets-for-rds"
  subnet_ids = var.privates_subnets_ids //[data.aws_subnet.private_subnets.0.id, data.aws_subnet.private_subnets.1.id]
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