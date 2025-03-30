output "tf_backend_bucket_name" {
  value = module.backend.tf_backend_bucket_name
}

output "sns_topic_arn" {
  value = module.sns.sns_topic_arn
}

output "sqs_queue_url" {
  value = module.sqs.sqs_queue_url
}

output "sqs_queue_arn" {
  value = module.sqs.sqs_queue_arn
}
