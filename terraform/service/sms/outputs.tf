locals {
  export_as_organization_variable = {
    "sms_external_id" = {
      hcl       = false
      sensitive = false
      value     = aws_pinpoint_app.app.application_id
    }
    "sms_external_caller_arn" = {
      hcl       = false
      sensitive = false
      value     = aws_iam_role.pinpoint_sms_role.arn
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