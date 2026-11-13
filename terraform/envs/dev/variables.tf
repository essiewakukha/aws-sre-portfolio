variable "region" {
  type    = string
  default = "us-east-1"
}

variable "allowed_countries" {
  description = "ISO 3166 alpha-2 codes allowed through WAF. Pick your own list."
  type        = list(string)
  default     = ["KE", "UG", "TZ", "RW"]
}