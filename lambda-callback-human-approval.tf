data "archive_file" "lambda_callback" {
  type        = "zip"
  source_file = "${path.module}/lambda_scripts/callback-human-approval.js"
  output_path = "${path.root}/lambda_scripts/lambda_zip/callback-human-approval.zip"
}

resource "aws_lambda_function" "callback" {
  filename      = "${path.root}/lambda_scripts/lambda_zip/callback-human-approval.zip"
  function_name = "callback-human-approval"
  role          = aws_iam_role.lambda_role_sns.arn

  source_code_hash = data.archive_file.lambda_callback.output_base64sha256
  runtime          = "nodejs18.x"
  handler          = "callback-human-approval.handler"
}

resource "aws_iam_role" "lambda_role_sns" {
  name = "lambda-role-sns"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sns:Publish",
          "sns:Subscribe",
          "sns:Receive"
        ],
        Effect   = "Allow",
        Resource = aws_sns_topic.main.arn
      },
      {
        Action = [
          "states:SendTaskSuccess",
          "states:SendTaskFailure",
          "states:GetActivityTask"
        ],
        Effect   = "Allow",
        Resource = "*" # Change this to the specific ARN if needed
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.lambda_role_sns.name
}
