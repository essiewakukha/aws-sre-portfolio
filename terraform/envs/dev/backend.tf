terraform {
  required_version = ">= 1.10"
  required_providers {
    aws    = { source = "hashicorp/aws", version = "~> 6.0" }
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }

  backend "s3" {
    bucket       = "<yourname>-sre-portfolio-tfstate" # TODO: from bootstrap output
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = { Project = "aws-sre-portfolio", Env = "dev", ManagedBy = "terraform" }
  }
}

# WAF for CloudFront must live in us-east-1
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  default_tags {
    tags = { Project = "aws-sre-portfolio", Env = "dev", ManagedBy = "terraform" }
  }
}