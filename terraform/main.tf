terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/Users/ercantopuz/.aws/config"]
  shared_credentials_files = ["/Users/ercantopuz/.aws/credentials"]
  #   profile                  = "use_default_for_now"
}

module "backend" {
  source = "./modules/backend"
}

module "sns" {
  source = "./modules/sns"
}