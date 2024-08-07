variable "create_keypair" {
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "The environment for deployment. Allowed values are dev, qa, or prod."
  type        = string
  default = "dev"

  validation {
    condition     = contains(["dev", "qa", "stg", "uat", "prod"], var.env)
    error_message = "Invalid value for environment. Allowed values are 'dev', 'qa', 'stg' or 'prod'."
  }
}
################################################################################
# Key Pair
################################################################################

variable "keypair_name" {
  type        = string
  default     = ""
}

variable "provided_public_key" {
  type        = string
  default     = ""
}

################################################################################
# TLS Private Key
################################################################################

variable "create_private_key" {
  type        = bool
  default     = false
}

variable "private_key_algorithm" {
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  type        = number
  default     = 4096
}