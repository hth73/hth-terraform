resource "aws_dynamodb_table" "tst-hth-terraform-state" {
  name         = "${var.env_name}-terraform-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "tst-hth-terraform-state" {
  bucket = "${var.env_name}-terraform-state"

  tags = merge(local.standard_tags, {
  })
}

resource "aws_s3_bucket_acl" "tst-hth-terraform-state" {
  bucket = aws_s3_bucket.tst-hth-terraform-state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tst-hth-terraform-state" {
  bucket = aws_s3_bucket.tst-hth-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "tst-hth-terraform-state" {
  bucket = aws_s3_bucket.tst-hth-terraform-state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tst-hth-terraform-state" {
  bucket = aws_s3_bucket.tst-hth-terraform-state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
