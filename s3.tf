resource "aws_s3_bucket" "sync" {
  count         = local.create_source_of_truth ? 1 : 0
  bucket_prefix = "${var.chain}-truth"
  acl           = "private"
  //  region = var.sync_region
}

resource "aws_iam_policy" "sync" {
  count  = local.create_source_of_truth ? 1 : 0
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Resource": [
                "${aws_s3_bucket.sync[0].arn}"
            ],
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ]
        },
        {
            "Resource": [
                "${aws_s3_bucket.sync[0].arn}/*"
            ],
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_policy" "read" {
  count  = local.create_source_of_truth ? 1 : 0
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Resource": [
                "${aws_s3_bucket.sync[0].arn}"
            ],
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ]
        },
        {
            "Resource": [
                "${aws_s3_bucket.sync[0].arn}/*"
            ],
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_user_policy_attachment" "sync" {
  count      = local.create_source_of_truth ? 1 : 0
  policy_arn = aws_iam_policy.sync[0].arn
  user       = aws_iam_user.sync[0].name
}

resource "aws_iam_user_policy_attachment" "read" {
  count      = local.create_source_of_truth ? 1 : 0
  policy_arn = aws_iam_policy.read[0].arn
  user       = aws_iam_user.reader[0].name
}