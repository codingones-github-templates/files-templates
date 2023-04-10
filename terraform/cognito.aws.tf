#<!-- VARIABLES
#SERVICE
#USER_GROUP_ADMIN_NAME
#USER_GROUP_USER_NAME
#-->
resource "aws_cognito_user_pool" "main" {
  name = "SERVICE-user-pool"

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

  auto_verified_attributes = [/*"phone_number",*/ "email"]

  //  deletion_protection = "INACTIVE"

  // device_configuration {
  //   challenge_required_on_new_device      = true
  //   device_only_remembered_on_user_prompt = false
  // }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  //  sms_authentication_message = "Votre code d'authentification est {####}"
  //  sms_verification_message   = "Votre identifiant est {username} et votre code temporaire est {####}"

  tags = local.tags
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "SERVICE-user-pool-client"
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
  name         = "USER_GROUP_ADMIN_NAME"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user_group" "user" {
  name         = "USER_GROUP_USER_NAME"
  user_pool_id = aws_cognito_user_pool.main.id
}
