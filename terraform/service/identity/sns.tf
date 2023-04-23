locals {
  subject       = length(var.sender_id) > 0 ? var.sender_id : var.project
  words         = split("-", local.subject)
  first_letters = [for word in local.words : substr(word, 0, 1)]
  sender_id     = length(local.subject) > 11 ? join("-", local.first_letters) : local.subject
}

resource "aws_sns_sms_preferences" "update_sms_prefs" {
  default_sender_id = substr(local.sender_id, 0, 11)
  default_sms_type  = "Transactional"
}