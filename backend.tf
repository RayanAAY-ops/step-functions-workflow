terraform {
  backend "s3" {
    key                  = "step-functions-workflow.tfstate"
    workspace_key_prefix = ""
    encrypt              = true
    region               = "eu-west-3"
    bucket               = "poc-terraform-backend-523987126142"
    dynamodb_table       = "poc_terraform_backend"
  }
}
