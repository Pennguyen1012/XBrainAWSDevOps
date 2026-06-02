output "primary_bucket_name" {
  description = "Name of the primary bucket"
  value       = aws_s3_bucket.primary.bucket
}

output "backup_bucket_name" {
  description = "Name of the backup bucket"
  value       = aws_s3_bucket.backup.bucket
}

output "kms_key_id" {
  description = "KMS Encryption ID"
  value       = aws_kms_key.s3_key.id
}
