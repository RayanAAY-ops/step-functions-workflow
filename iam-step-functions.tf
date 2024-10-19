resource "aws_iam_role" "step_function_role" {
  name = "my-step-function-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_invoke_policy" {
  name = "invoke-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "lambda:InvokeFunction",
        Effect   = "Allow",
        Resource = "arn:aws:lambda:eu-west-3:523987126142:function:python-random-generator"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "step_function_lambda_invoke" {
  role       = aws_iam_role.step_function_role.id
  policy_arn = aws_iam_policy.lambda_invoke_policy.arn
}
