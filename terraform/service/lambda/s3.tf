resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "${var.project}-lambda"
  force_destroy = true
  tags          = local.tags
}
