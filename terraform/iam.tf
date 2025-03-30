
resource "aws_iam_group" "sns_sqs_iam_group" {
  name = "sns-sqs"
}

resource "aws_iam_policy" "sns_sqs_iam_policy" {
  name = "SNS-SQS-Necessary-Policies"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "dynamodb:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "s3:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "sns:*"
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action   = "sqs:*"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "sns_sqs_iam_policy_attachment" {
  name       = "sns-sqs-policy-attachment"
  groups     = [aws_iam_group.sns_sqs_iam_group.name]
  policy_arn = aws_iam_policy.sns_sqs_iam_policy.arn
}

resource "aws_iam_user_group_membership" "sns_sqs_iam_user_group_membership" {
  user = "my-mac"
  groups = [
    "${aws_iam_group.sns_sqs_iam_group.name}",
  ]
}