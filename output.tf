##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

output "acm_certificate_arn" {
  value = var.cross_account != true ? aws_acm_certificate_validation.local_cert_validation[0].certificate_arn : aws_acm_certificate_validation.cross_cert_validation[0].certificate_arn
}