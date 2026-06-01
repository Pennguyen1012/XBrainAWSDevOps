#Primary bucket
resource "aws_s3_bucket" "primary" {
  bucket = "${var.project_name}-primary"

  tags = {
    Name        = "Primary Data Bucket"
    Environment = var.environment
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "primary_versioning" {
  bucket = aws_s3_bucket.primary.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt the Primary Bucket by KMS Key
resource "aws_s3_bucket_server_side_encryption_configuration" "primary_crypto" {
  bucket = aws_s3_bucket.primary.id

  rule {
    apply_server_side_encryption_by_default {
      #IMPLICIT DEPENDENCY: 
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# Backup bucket
resource "aws_s3_bucket" "backup" {
  bucket = "${var.project_name}-backup"

  tags = {
    Name        = "Backup Replica Bucket"
    Environment = var.environment
  }
}

# Enable Versioning for Backup
resource "aws_s3_bucket_versioning" "backup_versioning" {
  bucket = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt Backup Bucket also by that KMS Key
resource "aws_s3_bucket_server_side_encryption_configuration" "backup_crypto" {
  bucket = aws_s3_bucket.backup.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
