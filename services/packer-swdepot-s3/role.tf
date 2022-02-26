resource "aws_iam_instance_profile" "win-srv-packer-softwaredepot" {
  name = "win-srv-packer-softwaredepot"
  role = aws_iam_role.win-srv-packer-softwaredepot.name
}

resource "aws_iam_role" "win-srv-packer-softwaredepot" {
  name = "win-srv-packer-softwaredepot"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": {
      "Service": ["ec2.amazonaws.com"]
    },
    "Action": "sts:AssumeRole"
  }
}
POLICY
}

resource "aws_iam_role_policy" "win-srv-packer-softwaredepot" {
  policy = data.aws_iam_policy_document.win-srv-packer-softwaredepot.json
  role = aws_iam_role.win-srv-packer-softwaredepot.id
  name = "allow-download-from-s3-bucket"
}

data "aws_iam_policy_document" "win-srv-packer-softwaredepot" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:HeadBucket"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = ["${aws_s3_bucket.win-srv-packer-softwaredepot.arn}/*"]
  }
}
