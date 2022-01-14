resource aws_ecr_repository "repository" {
  name                 = "${local.resource_prefix.value}-repository"
  image_tag_mutability = "MUTABLE"

  tags = merge({
    Name = "${local.resource_prefix.value}-repository"
    }, {
    git_commit           = "4608512ed820e97aa06a17cbe21fadefd6db6cf0"
    git_file             = "aws/ecr.tf"
    git_last_modified_at = "2022-01-13 10:22:53"
    git_last_modified_by = "smcandrew@Scotts-MacBook-Pro.local"
    git_modifiers        = "smcandrew"
    git_org              = "scottymcandrew"
    git_repo             = "bc-iac-lab"
    yor_trace            = "7a3ec657-fa54-4aa2-8467-5d08d6c90bc2"
  })
}

locals {
  docker_image = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${aws_ecr_repository.repository.name}"
}


resource null_resource "push_image" {
  provisioner "local-exec" {
    working_dir = "${path.module}/resources"
    command     = <<BASH
    aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
    docker build -t ${aws_ecr_repository.repository.name} .
    docker tag ${aws_ecr_repository.repository.name} ${local.docker_image}
    docker push ${local.docker_image}
    BASH
  }
}