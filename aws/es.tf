resource "aws_elasticsearch_domain" "monitoring-framework" {
  domain_name           = "tg-${var.environment}-es"
  elasticsearch_version = "2.3"

  cluster_config {
    instance_type            = "t2.small.elasticsearch"
    instance_count           = 1
    dedicated_master_enabled = false
    dedicated_master_type    = "m4.large.elasticsearch"
    dedicated_master_count   = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 30
  }
  tags = {
    git_commit           = "4608512ed820e97aa06a17cbe21fadefd6db6cf0"
    git_file             = "aws/es.tf"
    git_last_modified_at = "2022-01-13 10:22:53"
    git_last_modified_by = "smcandrew@Scotts-MacBook-Pro.local"
    git_modifiers        = "smcandrew"
    git_org              = "scottymcandrew"
    git_repo             = "bc-iac-lab"
    yor_trace            = "95131dec-d7c9-49bb-9aff-eb0e2736603b"
  }
}

data aws_iam_policy_document "policy" {
  statement {
    actions = ["es:*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["*"]
  }
}

resource "aws_elasticsearch_domain_policy" "monitoring-framework-policy" {
  domain_name     = aws_elasticsearch_domain.monitoring-framework.domain_name
  access_policies = data.aws_iam_policy_document.policy.json
}
