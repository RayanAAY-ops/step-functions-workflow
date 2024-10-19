
provider "aws" {
  default_tags {
    tags = {
      Appli          = var.project_name
      Component      = var.domain_name
      Env            = terraform.workspace
      git_repository = var.git_repository
    }
  }
  region = "eu-west-3"
}
