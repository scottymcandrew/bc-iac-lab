resource "aws_kms_key" "logs_key" {
  # key does not have rotation enabled
  description = "${local.resource_prefix.value}-logs bucket key"

  deletion_window_in_days = 7
  tags = {
    git_commit           = "4608512ed820e97aa06a17cbe21fadefd6db6cf0"
    git_file             = "aws/kms.tf"
    git_last_modified_at = "2022-01-13 10:22:53"
    git_last_modified_by = "smcandrew@Scotts-MacBook-Pro.local"
    git_modifiers        = "smcandrew"
    git_org              = "scottymcandrew"
    git_repo             = "bc-iac-lab"
    yor_trace            = "cd8fa2a7-4868-4cd1-993d-da4644808ce5"
  }
}

resource "aws_kms_alias" "logs_key_alias" {
  name          = "alias/${local.resource_prefix.value}-logs-bucket-key"
  target_key_id = "${aws_kms_key.logs_key.key_id}"
}
