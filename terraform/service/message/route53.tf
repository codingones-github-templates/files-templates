#locals {
#  cname_records = {
#    "example1" = "target1.example.com."
#    "example2" = "target2.example.com."
#    "example3" = "target3.example.com."
#  }
#}
#
#resource "aws_route53_zone" "example" {
#  name = "yourdomain.com"
#}
#
#resource "aws_route53_record" "example_cname" {
#  for_each = local.cname_records
#
#  zone_id = aws_route53_zone.example.zone_id
#  name    = "${each.key}.${aws_route53_zone.example.name}"
#  type    = "CNAME"
#  ttl     = "300"
#  records = [each.value]
#}
