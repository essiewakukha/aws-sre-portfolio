# PR 5 — ALB, AWS WAF (CLOUDFRONT scope, us-east-1) and CloudFront.

terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.us_east_1]
    }
  }
}

# TODO
# - random_password "origin_secret" (length 32, special = false)
# - aws_lb (internet-facing, public subnets, security_groups = [var.alb_sg_id])
# - aws_lb_target_group "apache" (80, /health) and "app" (8080, /health)
# - aws_lb_target_group_attachment for each web instance in both groups
# - aws_lb_listener :80, default action fixed-response 403
# - aws_lb_listener_rule 10: header X-Origin-Verify + path /app, /app/* -> app
# - aws_lb_listener_rule 20: header X-Origin-Verify -> apache
# - aws_wafv2_web_acl (provider = aws.us_east_1, scope = "CLOUDFRONT"):
#     1 geo allow-list (not_statement + geo_match_statement, var.allowed_countries)
#     2 AWSManagedRulesAmazonIpReputationList
#     3 AWSManagedRulesCommonRuleSet
#     4 AWSManagedRulesKnownBadInputsRuleSet
#     5 rate_based_statement, limit 500 per 5 min
#     visibility_config + sampled requests on every rule
# - data aws_cloudfront_cache_policy: Managed-CachingDisabled, Managed-CachingOptimized
# - data aws_cloudfront_origin_request_policy: Managed-AllViewerExceptHostHeader
# - aws_cloudfront_distribution:
#     origin = ALB DNS, custom_origin_config http-only :80, custom_header X-Origin-Verify
#     ordered_cache_behavior /app* -> CachingDisabled; default -> CachingOptimized
#     viewer_protocol_policy = "redirect-to-https", price_class = "PriceClass_200"
#     web_acl_id = aws_wafv2_web_acl.this.arn