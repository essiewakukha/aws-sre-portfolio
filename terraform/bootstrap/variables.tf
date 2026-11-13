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