locals {
  export_as_organization_variable = {
    "cognito_authorizer_issuer" = {
      hcl       = false
      sensitive = false
      #value     = "https://cognito-idp.us-east-1.amazonaws.com/${tolist(data.aws_cognito_user_pools.taxi-aymeric-user-pool.ids)[0]}"
      value = "https://cognito-idp.us-east-1.amazonaws.com/${aws_cognito_user_pool.main.id}"
    }
    "cognito_authorizer_audience" = {
      hcl       = true
      sensitive = false
      value     = [aws_cognito_user_pool_client.user_pool_client.id]
    }
    "cognito_app_integration_id" = {
      hcl       = false
      sensitive = false
      value     = aws_cognito_user_pool_client.user_pool_client.id
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