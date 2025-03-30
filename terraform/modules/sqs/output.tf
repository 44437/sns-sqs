output "sqs_queue_url" {
  value = aws_sqs_queue.orders.url
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.orders.arn
}