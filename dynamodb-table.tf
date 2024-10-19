resource "aws_dynamodb_table" "main" {
  hash_key       = "Name"
  name           = "GetCreditBureau"
  billing_mode     = "PAY_PER_REQUEST"  # Change to on-demand capacity mode

  attribute {
    name = "Name"
    type = "S"
  }

}