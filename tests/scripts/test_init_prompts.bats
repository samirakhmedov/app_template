#!/usr/bin/env bats

SCRIPT="scripts/init.sh"

# INIT-01: App name validation

@test "rejects empty app name then accepts valid name" {
  # First line empty (rejected), second line valid name, then bundle IDs + confirm
  run bash -c 'printf "\nMy App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Error: App name cannot be empty"* ]]
  [[ "$output" == *"My App"* ]]
}

@test "accepts non-empty app name" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"My App"* ]]
}

@test "accepts app name with spaces" {
  run bash -c 'printf "My Multi Word App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"My Multi Word App"* ]]
}

# INIT-02: Bundle ID validation

@test "rejects bundle ID without dots" {
  run bash -c 'printf "My App\nnotabundleid\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Invalid format"* ]]
}

@test "rejects bundle ID with leading dot" {
  run bash -c 'printf "My App\n.com.example\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Invalid format"* ]]
}

@test "rejects bundle ID with trailing dot" {
  run bash -c 'printf "My App\ncom.\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Invalid format"* ]]
}

@test "rejects bundle ID starting with digit" {
  run bash -c 'printf "My App\n123.example.app\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Invalid format"* ]]
}

@test "accepts valid 3-segment bundle ID" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"com.example.myapp"* ]]
}

@test "accepts valid 2-segment bundle ID" {
  run bash -c 'printf "My App\ncom.myapp\ncom.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"com.myapp"* ]]
}

@test "accepts valid 4-segment bundle ID" {
  run bash -c 'printf "My App\nio.company.product.feature\nio.company.product.feature\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"io.company.product.feature"* ]]
}
