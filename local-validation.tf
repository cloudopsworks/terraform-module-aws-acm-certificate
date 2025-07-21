##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  domain_validations = var.create && var.certificate_type == "external" ? aws_acm_certificate.this[0].domain_validation_options : []
}

resource "aws_route53_record" "local_cert_validation" {
  for_each = {
    for dvo in local.domain_validations : dvo => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if endswith(dvo.domain_name, var.domain_zone) && var.cross_account != true && var.external_dns_zone == false && var.certificate_type == "external" && var.create
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.local_zone[0].id
}

resource "aws_acm_certificate_validation" "local_cert_validation" {
  count                   = var.cross_account != true && var.external_dns_zone == false && var.certificate_type == "external" && var.create ? 1 : 0
  certificate_arn         = aws_acm_certificate.this[0].arn
  validation_record_fqdns = [for record in aws_route53_record.local_cert_validation : record.fqdn]
}

