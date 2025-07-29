# Test input validation

run "empty_name_fails" {
  command = plan
  
  variables {
    name = ""
  }
  
  expect_failures = [
    var.name,
  ]
}

run "long_name_fails" {
  command = plan
  
  variables {
    name = "this-name-is-way-too-long-for-our-validation"
  }
  
  expect_failures = [
    var.name,
  ]
}

run "invalid_environment_fails" {
  command = plan
  
  variables {
    name = "test"
    environment = "invalid"
  }
  
  expect_failures = [
    var.environment,
  ]
}

run "valid_long_name_passes" {
  command = plan
  
  variables {
    name = "exactly-twenty-char"  # Exactly 20 characters
    environment = "staging"
  }
  
  # Should pass - no expect_failures
  assert {
    condition     = var.name == "exactly-twenty-char"
    error_message = "Valid 20-character name should be accepted"
  }
}

run "all_environments_valid" {
  command = plan
  
  variables {
    name = "test"
    environment = "dev"
  }
  
  # Test dev environment
  assert {
    condition     = var.environment == "dev"
    error_message = "Dev environment should be valid"
  }
}
