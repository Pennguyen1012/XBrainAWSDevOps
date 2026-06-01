resource "aws_kms_key" "s3_key" {
  description             = "This KMS key is to encript the 2 S3 buckets available on the architecture."
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "${var.project_name}-kms-key"
    Environment = var.environment
  }
}

# Aliasing
resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/${var.project_name}-key"
  target_key_id = aws_kms_key.s3_key.key_id
}
