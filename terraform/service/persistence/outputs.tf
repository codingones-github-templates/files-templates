locals {
  export_as_organization_variable = {
    "db_connexion_string" = {
      hcl       = false
      sensitive = false
      value     = "postgres://${aws_db_instance.rds_instance.username}:${aws_db_instance.rds_instance.password}@${aws_db_instance.rds_instance.endpoint}/${aws_db_instance.rds_instance.db_name}"
    }
  }
}

data "tfe_organization" "organization" {
  name = var.terraform_organization
}

data "tfe_variable_set" "variables" {
  name         = "variables"
  organization = data.tfe_organization.organization.name
}

resource "tfe_variable" "output_values" {
  for_each = local.export_as_organization_variable

  key             = each.key
  value           = each.value.hcl ? jsonencode(each.value.value) : tostring(each.value.value)
  category        = "terraform"
  description     = "${each.key} variable from the ${var.service} service"
  variable_set_id = data.tfe_variable_set.variables.id
  hcl             = each.value.hcl
  sensitive       = each.value.sensitive
}