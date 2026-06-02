resource "aws_s3_bucket_replication_configuration" "replication" {

  depends_on = [aws_iam_role_policy.replication]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.primary.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    # Since Primary is encrypted, this is compulsory for the operation of the script
    source_selection_criteria {
      sse_kms_encrypted_objects {
        status = "Enabled"
      }
    }

    destination {
      bucket = aws_s3_bucket.backup.arn
      # Encrypt the file copied to the destination using KMS
      encryption_configuration {
        replica_kms_key_id = aws_kms_key.s3_key.arn
      }
    }
  }
}
