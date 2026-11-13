# TODO (PR 4): uncomment once the resources exist
# output "alb_sg_id"        { value = aws_security_group.alb.id }
# output "web_instance_ids" { value = [for k, i in aws_instance.this : i.id if local.instances[k].role == "web"] }
# output "ssm_bucket_name"  { value = aws_s3_bucket.ssm.bucket }