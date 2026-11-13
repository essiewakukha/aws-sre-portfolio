# PR 4 — private EC2 fleet, IAM role, security groups, SSM transfer bucket.
#
# TODO
# - data "aws_ami" ubuntu  (owner 099720109477, ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*)
# - data "aws_ami" windows (owner amazon, Windows_Server-2022-English-Full-Base-*)
# - aws_iam_role + aws_iam_instance_profile:
#     AmazonSSMManagedInstanceCore, AmazonEC2ContainerRegistryReadOnly,
#     s3 read/write on the SSM bucket, ssm:GetParameter on /sre-portfolio/*,
#     ec2:DescribeInstances (for Prometheus on mon-1)
# - aws_s3_bucket "ssm" (Ansible aws_ssm connection transfer bucket), public access blocked
# - security groups (this module owns ALL of them, including the ALB's):
#     alb-sg : 80 from CloudFront origin-facing managed prefix list
#     web-sg : 80 + 8080 from alb-sg, 9100 from mon-sg
#     win-sg : 9182 from mon-sg
#     mon-sg : no inbound (Grafana via SSM port forwarding)
# - instances (private subnets, IMDSv2 required, encrypted gp3), driven by a map:

locals {
  instances = {
    web-1 = { os = "ubuntu", type = "t3.small", az_index = 0, role = "web" }
    web-2 = { os = "ubuntu", type = "t3.small", az_index = 1, role = "web" }
    win-1 = { os = "windows", type = "t3.medium", az_index = 0, role = "windows" }
    win-2 = { os = "windows", type = "t3.medium", az_index = 1, role = "windows" }
    mon-1 = { os = "ubuntu", type = "t3.small", az_index = 0, role = "monitoring" }
  }
}

# resource "aws_instance" "this" {
#   for_each = local.instances
#   ...
#   tags = { Name = each.key, Role = each.value.role }   # Role drives Ansible + Prometheus discovery
# }