##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "acm_certificate_arn" {
  value = try(aws_acm_certificate_validation.cross_cert_validation[0].certificate_arn,
    aws_acm_certificate_validation.local_cert_validation[0].certificate_arn,
    aws_acm_certificate.imported[0].arn,
    aws_acm_certificate.internal[0].arn,
    aws_acm_certificate.this[0].arn
  )
}

output "acm_certificate_validation_options" {
  value = var.create && var.external_dns_zone == true && var.certificate_type == "external" ? aws_acm_certificate.this[0].domain_validation_options : null
}

output "acm_certificate_status" {
  value = try(aws_acm_certificate.this[0].status,
    aws_acm_certificate.imported[0].status,
    aws_acm_certificate.internal[0].status,
    null
  )
}

output "acm_certificate_renewal_elegibility" {
  value = try(aws_acm_certificate.this[0].renewal_eligibility,
    aws_acm_certificate.imported[0].renewal_eligibility,
    aws_acm_certificate.internal[0].renewal_eligibility,
    null
  )
}

output "acm_certificate_expire_date" {
  value = try(aws_acm_certificate.this[0].not_after,
    aws_acm_certificate.imported[0].not_after,
    aws_acm_certificate.internal[0].not_after,
    null
  )
}