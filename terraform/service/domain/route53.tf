resource "aws_route53_delegation_set" "domain_delegation_set" {
  reference_name = "${var.project} name server delegation set"
}


resource "aws_route53domains_registered_domain" "registered_domain" {
  domain_name = var.domain_name

  dynamic "name_server" {
    for_each = aws_route53_delegation_set.domain_delegation_set.name_servers
    content {
      name = name_server.value
    }
  }

  auto_renew    = true
  transfer_lock = false

  tags = local.tags
}

resource "aws_route53_zone" "hosting_zone" {
  name              = var.domain_name
  delegation_set_id = aws_route53_delegation_set.domain_delegation_set.id
  tags              = local.tags
}

resource "aws_route53_record" "main_name_servers_record" {
  name            = aws_route53_zone.hosting_zone.name
  allow_overwrite = true
  ttl             = 30
  type            = "NS"
  zone_id         = aws_route53_zone.hosting_zone.zone_id
  records         = aws_route53_zone.hosting_zone.name_servers
}

# TODO Rework necessary because it choose the first domain in the domain list, problematic when swapping domains
resource "aws_route53_record" "certificate_validation_main" {
  name            = tolist(aws_acm_certificate.acm_certificate.domain_validation_options)[0].resource_record_name
  depends_on      = [aws_acm_certificate.acm_certificate]
  zone_id         = aws_route53_zone.hosting_zone.zone_id
  type            = tolist(aws_acm_certificate.acm_certificate.domain_validation_options)[0].resource_record_type
  ttl             = "300"
  records         = [sort(aws_acm_certificate.acm_certificate.domain_validation_options[*].resource_record_value)[0]]
  allow_overwrite = true
}
