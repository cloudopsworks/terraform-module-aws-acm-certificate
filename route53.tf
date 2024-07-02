##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

data "aws_route53_zone" "local_zone" {
  count = var.cross_account != true ? 1 : 0
  name  = var.domain_zone
  private_zone = var.private_zone
}

data "aws_route53_zone" "cross_zone" {
  count    = var.cross_account == true ? 1 : 0
  provider = aws.cross_account
  name     = var.domain_zone
  private_zone = var.private_zone
}