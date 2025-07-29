# Just use locals to demonstrate logic without real resources
locals {
  # Combine name and environment
  full_name = "${var.name}-${var.environment}"
  
  # Create standardized tags
  standard_tags = merge(var.tags, {
    Name        = local.full_name
    Environment = var.environment
    ManagedBy   = "opentofu"
  })
  
  # Some computed values to test
  name_length = length(var.name)
  is_production = var.environment == "prod"
  tag_count = length(local.standard_tags)
  
  # Generate config content using template syntax
  config_content = templatestring(<<-EOT
Configuration for: ${var.name}
Environment: ${var.environment}
Full Name: ${local.full_name}
Tags:
%{~ for k, v in local.standard_tags ~}
  ${k} = ${v}
%{~ endfor ~}
Generated at: ${timestamp()}
EOT
  , {
    name        = var.name
    environment = var.environment
    full_name   = local.full_name
    tags        = local.standard_tags
  })
}

# Create a simple local file (gets cleaned up automatically)
resource "local_file" "config" {
  filename = "${path.module}/generated-${local.full_name}.txt"
  content  = local.config_content
}
