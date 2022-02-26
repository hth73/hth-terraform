resource "aws_s3_bucket" "win-srv-packer-softwaredepot" {
  bucket = "win-srv-packer-softwaredepot"

  tags = merge(local.standard_tags, {
  })
}

resource "aws_s3_bucket_acl" "win-srv-packer-softwaredepot" {
  bucket = aws_s3_bucket.win-srv-packer-softwaredepot.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "win-srv-packer-softwaredepot" {
  bucket = aws_s3_bucket.win-srv-packer-softwaredepot.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "win-srv-packer-softwaredepot" {
  bucket = aws_s3_bucket.win-srv-packer-softwaredepot.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "win-srv-packer-softwaredepot" {
  bucket = aws_s3_bucket.win-srv-packer-softwaredepot.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
