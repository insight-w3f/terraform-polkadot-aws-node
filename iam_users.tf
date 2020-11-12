resource "aws_iam_user" "sync" {
  count = local.create_source_of_truth ? 1 : 0
  name  = "${local.id}_truth_node_sync_user"
}

resource "aws_iam_user" "reader" {
  count = local.create_source_of_truth ? 1 : 0
  name  = "${local.id}_truth_node_read_user"
}

resource "aws_iam_access_key" "sync" {
  count = local.create_source_of_truth ? 1 : 0
  user  = aws_iam_user.sync[0].name
}

resource "aws_iam_access_key" "reader" {
  count = local.create_source_of_truth ? 1 : 0
  user  = aws_iam_user.reader[0].name
}