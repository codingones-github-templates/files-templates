resource "aws_dms_replication_subnet_group" "private_subnets_group" {
  replication_subnet_group_description = "Replication subnet group for taxi gestion"
  replication_subnet_group_id          = "edms-replication-subnet-group-taxi-gestion"

  subnet_ids = [data.aws_subnet.private_subnets.0.id, data.aws_subnet.private_subnets.1.id]

  tags = local.tags
}

resource "aws_dms_replication_instance" "dms_replication_instance_taxi_gestion" {
  replication_instance_id     = "dms-replication-instance-taxi-gestion"
  replication_instance_class  = "dms.t3.micro"
  allocated_storage           = 5
  engine_version              = "3.4.7"
  auto_minor_version_upgrade  = true
  multi_az                    = false
  publicly_accessible         = true
  vpc_security_group_ids      = [aws_security_group.security_group_for_rds.id]
  allow_major_version_upgrade = false
  apply_immediately           = true
  replication_subnet_group_id = aws_dms_replication_subnet_group.private_subnets_group.id


  tags = local.tags
}

resource "aws_dms_endpoint" "taxi_dms_endpoint_production_source" {
  database_name               = aws_db_instance.taxi_rds_instance.db_name
  endpoint_id                 = "dms-endpoint-taxi-production"
  endpoint_type               = "source"
  engine_name                 = aws_db_instance.taxi_rds_instance.engine
  password                    = aws_db_instance.taxi_rds_instance.password
  port                        = aws_db_instance.taxi_rds_instance.port
  username                    = aws_db_instance.taxi_rds_instance.username
  server_name                 = aws_db_instance.taxi_rds_instance.address
  ssl_mode                    = "require"
  extra_connection_attributes = "keepalives_idle=120;keepalives_interval=6;keepalives_count=3"


  tags = local.tags
}

resource "aws_dms_endpoint" "taxi_dms_endpoint_production_target" {
  database_name               = aws_db_instance.taxi_rds_instance_2.db_name
  endpoint_id                 = "dms-endpoint-taxi-production-target"
  endpoint_type               = "target"
  engine_name                 = aws_db_instance.taxi_rds_instance_2.engine
  password                    = aws_db_instance.taxi_rds_instance_2.password
  port                        = aws_db_instance.taxi_rds_instance_2.port
  username                    = aws_db_instance.taxi_rds_instance_2.username
  server_name                 = aws_db_instance.taxi_rds_instance_2.address
  ssl_mode                    = "require"
  extra_connection_attributes = "keepalives_idle=120;keepalives_interval=6;keepalives_count=3"


  tags = local.tags
}

resource "aws_dms_replication_task" "replication_task" {
  replication_task_id      = "replicate-db-and-remove-some-columns"
  migration_type           = "full-load"
  replication_instance_arn = aws_dms_replication_instance.dms_replication_instance_taxi_gestion.replication_instance_arn
  source_endpoint_arn      = aws_dms_endpoint.taxi_dms_endpoint_production_source.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.taxi_dms_endpoint_production_target.endpoint_arn
  table_mappings = jsonencode({
    "rules" : [
      {
        "rule-type" : "selection",
        "rule-id" : "1",
        "rule-name" : "select-fares_orient-table",
        "object-locator" : {
          "schema-name" : "public",
          "table-name" : "%"
        },
        "rule-action" : "include"
      },
      {
        "rule-type" : "transformation",
        "rule-id" : "2",
        "rule-name" : "remove-class-column",
        "rule-target" : "column",
        "object-locator" : {
          "schema-name" : "public",
          "table-name" : "fares_orient",
          "column-name" : "class"
        },
        "rule-action" : "remove-column"
      },
      {
        "rule-type" : "transformation",
        "rule-id" : "3",
        "rule-name" : "remove-type-column",
        "rule-target" : "column",
        "object-locator" : {
          "schema-name" : "public",
          "table-name" : "fares_orient",
          "column-name" : "type"
        },
        "rule-action" : "remove-column"
      },
      {
        "rule-type" : "transformation",
        "rule-id" : "4",
        "rule-name" : "remove-version-column",
        "rule-target" : "column",
        "object-locator" : {
          "schema-name" : "public",
          "table-name" : "fares_orient",
          "column-name" : "version"
        },
        "rule-action" : "remove-column"
      },
      {
        "rule-type" : "transformation",
        "rule-id" : "5",
        "rule-name" : "remove-fieldtypes-column",
        "rule-target" : "column",
        "object-locator" : {
          "schema-name" : "public",
          "table-name" : "fares_orient",
          "column-name" : "fieldtypes"
        },
        "rule-action" : "remove-column"
      }
    ]
  })

  start_replication_task = true
}