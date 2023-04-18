resource "aws_acm_certificate" "acm_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}

resource "aws_acm_certificate_validation" "certification_main" {
  certificate_arn = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [
    aws_route53_record.certificate_validation_main.fqdn,
  ]
  timeouts {
    create = "48h"
  }
}