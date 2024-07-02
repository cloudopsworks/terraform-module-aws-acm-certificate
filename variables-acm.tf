##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

variable "domain_alias" {
  description = "The domain alias to use for the Certificate domain"
  type        = string
  default     = ""
}

variable "domain_zone" {
  description = "The domain zone to use for the Certificate domain zone"
  type        = string
  default     = "example.com"
}

variable "domain_alternates" {
  description = "The domain alternate aliases to use for the Certificate domain"
  type        = list(string)
  default     = []
}

variable "cross_account" {
  description = "The cross account to use for the Certificate domain, aws.cross_account provider must be set to module."
  type        = bool
  default     = false
}