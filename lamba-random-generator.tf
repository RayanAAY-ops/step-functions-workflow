resource "aws_iam_role" "lambda_role" {
  name = "lambda-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_scripts/randomNumberGenerator.py"
  output_path = "${path.root}/lambda_scripts/lambda_zip/randomNumberGenerator.zip"
}


resource "aws_lambda_function" "ingestion" {
  filename      = "${path.root}/lambda_scripts/lambda_zip/randomNumberGenerator.zip"
  function_name = "python-random-generator"
  role          = aws_iam_role.lambda_role.arn

  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.11"
  handler          = "randomNumberGenerator.lambda_handler"

}

resource "aws_lambda_permission" "allow_step_function" {
  statement_id  = "AllowExecutionFromStepFunction"
  action        = "lambda:InvokeFunction"
  function_name = "python-random-generator"
  principal     = "states.amazonaws.com"

  # Adjust the source ARN to your specific Step Function ARN
  source_arn = "arn:aws:states:eu-west-3:523987126142:stateMachine:my-step-function"
}
