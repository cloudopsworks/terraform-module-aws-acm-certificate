##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

locals {
  domain_name = var.domain_alias != "" ? format("%s.%s", var.domain_alias, var.domain_zone) : var.domain_zone
}

resource "aws_acm_certificate" "this" {
  count                     = var.certificate_type == "external" ? 1 : 0
  domain_name               = local.domain_name
  subject_alternative_names = var.domain_alternates
  validation_method         = "DNS"
  tags                      = local.all_tags
  dynamic "options" {
    for_each = length(var.options) > 0 ? [1] : []
    content {
      certificate_transparency_logging_preference = var.options.certificate_transparency ? "ENABLED" : "DISABLED"
      export                                      = var.options.exportable ? "ENABLED" : "DISABLED"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_secretsmanager_secret" "imported" {
  count = var.certificate_type == "imported" ? 1 : 0
  name  = var.imported_cert_secret_name
}

data "aws_secretsmanager_secret_version" "imported" {
  count     = var.certificate_type == "imported" ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.imported[0].arn
}

resource "aws_acm_certificate" "imported" {
  count             = var.certificate_type == "imported" ? 1 : 0
  private_key       = base64decode(jsondecode(data.aws_secretsmanager_secret_version.imported[0].secret_string)["key"])
  certificate_body  = base64decode(jsondecode(data.aws_secretsmanager_secret_version.imported[0].secret_string)["public_key"])
  certificate_chain = base64decode(jsondecode(data.aws_secretsmanager_secret_version.imported[0].secret_string)["cert_chain"])
  tags              = local.all_tags
  dynamic "options" {
    for_each = length(var.options) > 0 ? [1] : []
    content {
      certificate_transparency_logging_preference = var.options.certificate_transparency ? "ENABLED" : "DISABLED"
      export                                      = var.options.exportable ? "ENABLED" : "DISABLED"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_acmpca_certificate_authority" "private_ca" {
  count = var.certificate_type == "internal" ? 1 : 0
  arn   = var.internal_ca_arn
}

resource "aws_acm_certificate" "internal" {
  count                     = var.certificate_type == "internal" ? 1 : 0
  certificate_authority_arn = data.aws_acmpca_certificate_authority.private_ca[0].arn
  domain_name               = local.domain_name
  subject_alternative_names = var.domain_alternates
  early_renewal_duration    = var.early_renewal_days > 0 ? format("P%sD", var.early_renewal_days) : null
  tags                      = local.all_tags
  dynamic "options" {
    for_each = length(var.options) > 0 ? [1] : []
    content {
      certificate_transparency_logging_preference = var.options.certificate_transparency ? "ENABLED" : "DISABLED"
      export                                      = var.options.exportable ? "ENABLED" : "DISABLED"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

