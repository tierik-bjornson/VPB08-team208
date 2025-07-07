output "key_name" {
  description = "Ten keypair AWS"
  value       = aws_key_pair.this.key_name
}

output "private_key_path" {
  description = "duong dan file PEM da luu"
  value       = local_file.private_key_pem.filename
}
