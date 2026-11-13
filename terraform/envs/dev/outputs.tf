
output "vpc_id" {
  value = module.network.vpc_id
}

# output "alb_dns" {           # PR 5
#   value = module.edge.alb_dns_name
# }
# output "cloudfront_domain" { # PR 5
#   value = module.edge.cloudfront_domain_name
# }