data "archive_file" "lambda_get-credit-score" {
  type        = "zip"
  source_file = "${path.module}/lambda_scripts/get-credit-score.js"
  output_path = "${path.root}/lambda_scripts/lambda_zip/get-credit-score.zip"
}

resource "aws_lambda_function" "get-credit-score" {
  filename      = "${path.root}/lambda_scripts/lambda_zip/get-credit-score.zip"
  function_name = "get-credit-score"
  role          = aws_iam_role.lambda_role.arn

  source_code_hash = data.archive_file.lambda_get-credit-score.output_base64sha256
  runtime          = "nodejs18.x"
  handler          = "get-credit-score.handler"
}

