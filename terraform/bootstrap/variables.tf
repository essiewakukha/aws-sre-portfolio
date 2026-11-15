variable "region" {
  type    = string
  default = "us-east-1"
}

variable "state_bucket_name" {
  description = "sre-portfolio-tfstate"
  type        = string
}

variable "github_repo" {
  description = "https://github.com/essiewakukha/aws-sre-portfolio"
  type        = string
}
variable "github_owner_id" {
  description = "Numeric GitHub owner ID (immutable OIDC subject format)"
  type        = string
}

variable "github_repo_id" {
  description = "Numeric GitHub repository ID (immutable OIDC subject format)"
  type        = string
}
