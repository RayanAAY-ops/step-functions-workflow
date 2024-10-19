locals {
  lambda_path = "${path.module}/lambda_scripts"
}

variable "lambda_scripts" {
  type = map(object({
    filename      = string
    function_name = string
  }))
  default = {
    "check-address" = {
      filename      = "lambda_scripts/check-address.js"
      function_name = "check-address"
    },
    "check-identity" = {
      filename      = "lambda_scripts/check-identity.js"
      function_name = "check-identity"
    }
  }
}

# Create a zip file for each Lambda function
data "archive_file" "check_identity" {
  for_each = var.lambda_scripts

  type        = "zip"
  source_file = each.value.filename
  output_path = "${path.root}/lambda_scripts/lambda_zip/${each.value.function_name}.zip"
}

# Create Lambda functions
resource "aws_lambda_function" "lambda_verify" {
  for_each = var.lambda_scripts

  filename      = data.archive_file.check_identity[each.key].output_path
  function_name = each.value.function_name
  role          = aws_iam_role.lambda_role.arn

  source_code_hash = data.archive_file.check_identity[each.key].output_base64sha256
  runtime          = "nodejs18.x"
  handler          = "${each.value.function_name}.handler"
}
