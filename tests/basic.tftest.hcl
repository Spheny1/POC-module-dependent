# Basic functionality tests
variables {
  name = "myapp"
  environment = "dev"
  tags = {
    Owner = "team-a"
    Cost  = "project-x"
  }
}

run "basic_functionality" {
  # Test that full_name is constructed correctly
  assert {
    condition     = output.full_name == "myapp-dev"
    error_message = "Full name should be 'myapp-dev', got: ${output.full_name}"
  }
  
  # Test name length calculation
  assert {
    condition     = output.name_length == 5
    error_message = "Name length should be 5, got: ${output.name_length}"
  }
  
  # Test production flag
  assert {
    condition     = output.is_production == false
    error_message = "Should not be production environment"
  }
  
  # Test that standard tags include our custom tags
  assert {
    condition     = output.standard_tags["Owner"] == "team-a"
    error_message = "Should preserve custom Owner tag"
  }
  
  # Test that standard tags include managed tags
  assert {
    condition     = output.standard_tags["ManagedBy"] == "opentofu"
    error_message = "Should include ManagedBy tag"
  }
  
  # Test config file was created
  assert {
    condition     = can(file(output.config_file_path))
    error_message = "Config file should be created and readable"
  }
}

run "production_environment" {
  variables {
    name = "webapp"
    environment = "prod"
  }
  
  assert {
    condition     = output.full_name == "webapp-prod"
    error_message = "Production full name incorrect"
  }
  
  assert {
    condition     = output.is_production == true
    error_message = "Should be production environment"
  }
  
  assert {
    condition     = output.standard_tags["Environment"] == "prod"
    error_message = "Environment tag should be 'prod'"
  }
}

run "config_content_test" {
  variables {
    name = "test"
    environment = "staging"
  }
  
  # Test that config content contains expected values
  assert {
    condition     = can(regex("Configuration for: test", output.config_content))
    error_message = "Config should contain app name"
  }
  
  assert {
    condition     = can(regex("Environment: staging", output.config_content))
    error_message = "Config should contain environment"
  }
  
  assert {
    condition     = can(regex("ManagedBy = opentofu", output.config_content))
    error_message = "Config should contain ManagedBy tag"
  }
}
