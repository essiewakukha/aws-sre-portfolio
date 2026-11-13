output "state_bucket" {
  value = aws_s3_bucket.tfstate.bucket
}

output "github_actions_role_arn" {
  description = "Save as the AWS_ROLE_ARN secret in GitHub"
  value       = aws_iam_role.github_actions.arn
}