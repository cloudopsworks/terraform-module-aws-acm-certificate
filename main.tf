##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

locals {
  domain_name = var.domain_alias != "" ? format("%s.%s", var.domain_alias, var.domain_zone) : var.domain_zone
}

resource "aws_acm_certificate" "this" {
  domain_name               = local.domain_name
  subject_alternative_names = var.domain_alternates
  validation_method         = "DNS"

  tags = local.all_tags
  lifecycle {
    create_before_destroy = true
  }
}
