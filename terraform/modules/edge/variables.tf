variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "alb_sg_id" {
  type = string
}

variable "web_instance_ids" {
  type = list(string)
}

variable "allowed_countries" {
  type = list(string)
}