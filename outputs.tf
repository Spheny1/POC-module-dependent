output "full_name" {
  description = "The full name combining name and environment"
  value       = local.full_name
}

output "standard_tags" {
  description = "The standardized tags"
  value       = local.standard_tags
}

output "name_length" {
  description = "Length of the name"
  value       = local.name_length
}

output "is_production" {
  description = "Whether this is a production environment"
  value       = local.is_production
}

output "config_file_path" {
  description = "Path to the generated config file"
  value       = local_file.config.filename
}

output "config_content" {
  description = "Content of the generated config file"
  value       = local.config_content
}
