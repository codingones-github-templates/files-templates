resource "aws_iam_role" "pinpoint_sms_role" {
  name = "pinpoint_sms_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cognito-idp.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "pinpoint_sms_role_policy" {
  name = "pinpoint_sms_role_policy"
  role = aws_iam_role.pinpoint_sms_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "mobiletargeting:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}