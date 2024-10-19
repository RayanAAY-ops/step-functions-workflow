resource "aws_sns_topic" "main" {
  name = "TaskTokenTopic"

}

resource "aws_sns_topic_subscription" "my_email_subscription" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "lambda"                         # Use 'email' for email subscriptions
  endpoint  = aws_lambda_function.callback.arn # Replace with the email address you want to subscribe
}

resource "aws_lambda_permission" "allow_sns_invocation" {
  statement_id  = "AllowSNSTrigger"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.callback.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.main.arn # The ARN of your SNS topic
}
