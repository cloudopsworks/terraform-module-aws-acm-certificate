##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_route53_zone" "local_zone" {
  count        = var.create && var.cross_account != true && var.external_dns_zone == false ? 1 : 0
  name         = var.domain_zone
  private_zone = var.private_zone
}

data "aws_route53_zone" "cross_zone" {
  count        = var.create && var.cross_account == true && var.external_dns_zone == false ? 1 : 0
  provider     = aws.cross_account
  name         = var.domain_zone
  private_zone = var.private_zone
}

data "aws_route53_zone" "addtl_local_zone" {
  for_each = [
    for additional_domain_zone in var.additional_domain_zones : additional_domain_zone
    if var.create && var.cross_account != true && var.external_dns_zone == false
  ]
  name         = each.key
  private_zone = var.private_zone
}

locals {
  domain_zoneid_map = [
    for alternate in var.domain_alternates : {
      for addtl in var.additional_domain_zones : alternate => data.aws_route53_zone.addtl_local_zone[addtl].zone_id if endswith(alternate, addtl) && var.create && var.cross_account != true && var.external_dns_zone == false
    }
  ]
}