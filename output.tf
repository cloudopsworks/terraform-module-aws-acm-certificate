##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "acm_certificate_arn" {
  value = var.external_dns_zone == true ? aws_acm_certificate.this.arn : (var.cross_account == true ?
  aws_acm_certificate_validation.cross_cert_validation[0].certificate_arn : aws_acm_certificate_validation.local_cert_validation[0].certificate_arn)
}

output "acm_certificate_validation_options" {
  value = var.external_dns_zone == true ? aws_acm_certificate.this.domain_validation_options : null
}