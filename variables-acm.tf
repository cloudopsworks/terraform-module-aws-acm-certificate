##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "certificate_type" {
  description = "The type of ACM certificate to create, either 'internal', 'external' or 'imported'. Defaults to 'external'."
  type        = string
  default     = "external"
  validation {
    condition     = can(regex("^(internal|external|imported)$", var.certificate_type))
    error_message = "The certificate_type must be either 'internal', 'external' or 'imported'."
  }
  nullable = false
}

variable "domain_alias" {
  description = "The domain alias to use for the Certificate domain"
  type        = string
  default     = ""
  nullable    = false
}

variable "domain_zone" {
  description = "The domain zone to use for the Certificate domain zone"
  type        = string
  default     = "example.com"
  nullable    = false
}

variable "domain_alternates" {
  description = "The domain alternate aliases to use for the Certificate domain"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "cross_account" {
  description = "The cross account to use for the Certificate domain, aws.cross_account provider must be set to module."
  type        = bool
  default     = false
  nullable    = false
}

variable "private_zone" {
  description = "Required to search the Route53 zone in a private zone. Defaults to false"
  type        = bool
  default     = false
  nullable    = false
}

variable "external_dns_zone" {
  description = "(optional) allows the module work with external record validation out of Route53, defaults to false"
  type        = bool
  default     = false
  nullable    = false
}

variable "early_renewal_days" {
  description = "The duration in days before the certificate expires to start early renewal, only available for internal Certs. Defaults to 30 days."
  type        = string
  default     = 0
  nullable    = false
}

variable "imported_cert_secret_name" {
  description = "The name of the secret in AWS Secrets Manager where the imported certificate is stored."
  type        = string
  default     = ""
  nullable    = false
}

variable "internal_ca_arn" {
  description = "The ARN of the internal CA to use for the Certificate domain, if not provided, a new CA will be created."
  type        = string
  default     = ""
  nullable    = false
}

# Options for certificate - YAML
# options:
#   certificate_transparency: true | false # (optional) Enable certificate transparency logging for the ACM certificate.
#   exportable: true | false               # (optional) Make the ACM certificate exportable.
variable "options" {
  description = "Additional options for the ACM certificate, such as tags and validation methods."
  type        = any
  default     = {}
  nullable    = false
}