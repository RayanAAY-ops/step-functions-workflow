locals {
  stage_name       = terraform.workspace
  environment_name = "${var.project_name}_${var.domain_name}_${local.stage_name}"
}
