resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "aws_s3_bucket" "tf_backend" {
  bucket = "sns-sqs-tf-backend-bucket-${random_id.bucket_prefix.hex}"
}
