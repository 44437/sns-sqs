terraform {
  backend "s3" {
    bucket       = "sns-sqs-tf-backend-bucket-810f403740c8b759"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
    acl          = "private"
  }
}