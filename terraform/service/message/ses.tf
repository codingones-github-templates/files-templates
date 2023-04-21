resource "aws_sesv2_configuration_set" "ses_configuration" {
  configuration_set_name = "project_configuration_set"

  delivery_options {
    tls_policy = "REQUIRE"
  }

  reputation_options {
    reputation_metrics_enabled = true
  }

  sending_options {
    sending_enabled = true
  }

  suppression_options {
    suppressed_reasons = ["BOUNCE", "COMPLAINT"]
  }

  tracking_options {
    custom_redirect_domain = var.domain_name
  }

  tags = local.tags
}

resource "aws_sesv2_email_identity" "email_identity" {
  email_identity         = var.domain_name
  configuration_set_name = aws_sesv2_configuration_set.ses_configuration.configuration_set_name

  dkim_signing_attributes {
    next_signing_key_length = "RSA_2048_BIT"
  }
}

output "aws_sesv2_email_identity_tokens" {
  value = aws_sesv2_email_identity.email_identity.dkim_signing_attributes
}

#resource "aws_sesv2_configuration_set_event_destination" "example" {
#  configuration_set_name = aws_sesv2_configuration_set.example.configuration_set_name
#  event_destination_name = "example"
#
#  event_destination {
#    sns_destination {
#      topic_arn = aws_sns_topic.example.arn
#    }
#
#    enabled              = true
#    matching_event_types = ["SEND"]
#  }
#}