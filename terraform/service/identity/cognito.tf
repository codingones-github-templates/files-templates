locals {
  has_SES_valid_configuration = length(var.ses_configuration_set_name) > 0 && length(var.ses_verified_email_identity_source_arn) > 0
}

resource "aws_cognito_user_pool" "main" {
  name = "${var.service}-user-pool"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }

    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }

  username_attributes = ["email", "phone_number"]

  auto_verified_attributes = ["phone_number", "email"]

  // device_configuration {
  //   challenge_required_on_new_device      = true
  //   device_only_remembered_on_user_prompt = false
  // }

  email_configuration {
    email_sending_account  = local.has_SES_valid_configuration ? "DEVELOPER" : "COGNITO_DEFAULT"
    source_arn             = local.has_SES_valid_configuration ? var.ses_verified_email_identity_source_arn : null
    configuration_set      = local.has_SES_valid_configuration ? var.ses_configuration_set_name : null
    from_email_address     = local.has_SES_valid_configuration ? "Identity Service <identity@${var.domain_name}>" : null
    reply_to_email_address = local.has_SES_valid_configuration ? "support@${var.domain_name}" : null
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Votre code de vérification est le {####}."
    email_subject        = "Bienvenue chez ${var.project}, confirmez votre compte !"
    sms_message          = "${var.project} - Votre code de vérification est le {####}"
  }

  sms_configuration {
    external_id    = "cognito-sms"
    sns_caller_arn = aws_iam_role.cognito_sns_role.arn
  }

  //  sms_authentication_message = "Votre code d'authentification est {####}"
  //  sms_verification_message   = "Votre identifiant est {username} et votre code temporaire est {####}"

  tags = local.tags
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "${var.service}-user-pool-client"
  user_pool_id = aws_cognito_user_pool.main.id

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "minutes"
  }

  access_token_validity  = 5
  id_token_validity      = 5
  refresh_token_validity = 60

  explicit_auth_flows = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_USER_SRP_AUTH"]
}


resource "aws_cognito_user_group" "admin" {
  name         = var.user_group_admin
  user_pool_id = aws_cognito_user_pool.main.id
}


resource "aws_cognito_user_group" "user" {
  name         = var.user_group_user
  user_pool_id = aws_cognito_user_pool.main.id
}
