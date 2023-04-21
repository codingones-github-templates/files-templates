resource "aws_sns_topic" "user_signup_sms_verification" {
  name = "user-signup-sms-verification"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_signup_sms_verification.arn
  protocol  = "sms"
  endpoint  = "+336666666666"
}