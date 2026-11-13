variable "name" {
  type = string
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "azs" {
  description = "Exactly two AZs, e.g. [\"us-east-1a\", \"us-east-1b\"]"
  type        = list(string)
  validation {
    condition     = length(var.azs) == 2
    error_message = "This project uses exactly two AZs."
  }
}