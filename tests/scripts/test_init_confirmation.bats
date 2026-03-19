#!/usr/bin/env bats

SCRIPT="scripts/init.sh"

# INIT-04: Confirmation flow

@test "confirmation with y exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\ny\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"=== Summary ==="* ]]
}

@test "confirmation with yes exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\nyes\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "confirmation with n exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "confirmation with empty input (default No) exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\n\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "summary shows all three values" {
  run bash -c 'printf "Test App\ncom.test.android\ncom.test.ios\nn\n" | bash '"$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Test App"* ]]
  [[ "$output" == *"com.test.android"* ]]
  [[ "$output" == *"com.test.ios"* ]]
}

@test "--help flag shows usage and exits 0" {
  run bash "$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage"* ]]
  [[ "$output" == *"App display name"* ]]
  [[ "$output" == *"Android bundle ID"* ]]
  [[ "$output" == *"iOS bundle ID"* ]]
}

@test "-h flag shows usage and exits 0" {
  run bash "$SCRIPT" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage"* ]]
}
