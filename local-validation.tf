##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_route53_record" "local_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    } if endswith(dvo.domain_name, var.domain_zone) && var.cross_account != true && var.external_dns_zone == false
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.local_zone[0].id
}

resource "aws_acm_certificate_validation" "local_cert_validation" {
  count                   = var.cross_account != true && var.external_dns_zone == false ? 1 : 0
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.local_cert_validation : record.fqdn]
}

