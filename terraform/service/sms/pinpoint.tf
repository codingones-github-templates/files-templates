resource "aws_pinpoint_app" "app" {
  name = var.project
}

locals {
  subject       = var.sender_id ? var.sender_id : var.project
  words         = split("-", local.subject)
  first_letters = [for word in local.words : substr(word, 0, 1)]
  sender_id     = length(local.subject) > 11 ? join("-", local.first_letters) : local.subject
}

resource "aws_pinpoint_sms_channel" "sms_channel" {
  application_id = aws_pinpoint_app.app.application_id

  // Enable the SMS channel
  enabled = true

  // Set the Sender ID
  sender_id = substr(local.sender_id, 0, 11)
}


