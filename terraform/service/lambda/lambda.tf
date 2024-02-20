resource "aws_lambda_function" "domain_function" {
  function_name = "domain_function_name"
  handler       = "index.handler" # This should match your Lambda function's handler in the JavaScript code
  runtime       = "nodejs18.x"
  #runtime           = "python3.10"
  s3_bucket = aws_s3_bucket.lambda_bucket.bucket # Specify the bucket where your Lambda code is stored
  s3_key    = "domain_function_name.zip"         # Specify the key (file name) of the Lambda code zip
  role      = aws_iam_role.lambda_execution_role.arn
  timeout   = 300
  publish   = true
}

resource "aws_lambda_permission" "allow_principal" {
  statement_id  = "AllowPrincipalToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.domain_function.function_name
  principal     = ""
  source_arn    = ""
}
