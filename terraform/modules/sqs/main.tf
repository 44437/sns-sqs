resource "aws_sqs_queue" "orders" {
  name                      = "orders"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_queue_deadletter.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "sqs_queue_deadletter" {
  name = "sqs-deadletter-queue"
}

resource "aws_sqs_queue_redrive_allow_policy" "sqs_redrive_allow_policy" {
  queue_url = aws_sqs_queue.sqs_queue_deadletter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.orders.arn]
  })
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.orders.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid    = "Stmt1743341137114"
      Effect = "Allow"
      Principal = {
        Service = "sns.amazonaws.com"
      }
      Action   = "sqs:*"
      Resource = aws_sqs_queue.orders.arn
    }]
  })
}