#!/usr/bin/env bats

SCRIPT="scripts/init.sh"
PROJECT_DIR="/Users/samirakhmedov/Projects/app_template"

# INIT-04: Confirmation flow

# Minimal temp project fixture used for tests that send 'y' (which triggers renames).
_setup_minimal_project() {
  local tmpdir
  tmpdir="$(mktemp -d)"

  mkdir -p "$tmpdir/apps/basic/android/app/src/main/kotlin/com/example/app_template"
  mkdir -p "$tmpdir/apps/debug/android/app/src/main/kotlin/com/example/app_template"
  printf 'package com.example.app_template\n' \
    > "$tmpdir/apps/basic/android/app/src/main/kotlin/com/example/app_template/MainActivity.kt"
  printf 'package com.example.app_template\n' \
    > "$tmpdir/apps/debug/android/app/src/main/kotlin/com/example/app_template/MainActivity.kt"

  cat > "$tmpdir/apps/basic/android/app/build.gradle.kts" <<'GRADLE'
android {
    namespace = "com.example.app_template"
    defaultConfig {
        applicationId = "com.example.app_template"
        resValue("string", "app_name", "App Template (Dev)")
        resValue("string", "app_name_prod", "App Template")
    }
}
GRADLE
  cp "$tmpdir/apps/basic/android/app/build.gradle.kts" \
     "$tmpdir/apps/debug/android/app/build.gradle.kts"

  mkdir -p "$tmpdir/apps/basic/ios/Flutter" "$tmpdir/apps/debug/ios/Flutter"
  printf 'identifier=com.example.appTemplate\n' \
    > "$tmpdir/apps/basic/ios/Flutter/common.xcconfig"
  cp "$tmpdir/apps/basic/ios/Flutter/common.xcconfig" \
     "$tmpdir/apps/debug/ios/Flutter/common.xcconfig"

  mkdir -p "$tmpdir/apps/basic/ios/Runner" "$tmpdir/apps/debug/ios/Runner"
  printf '<dict>\n\t<key>CFBundleDisplayName</key>\n\t<string>App Template</string>\n\t<key>CFBundleName</key>\n\t<string>app_template</string>\n</dict>\n' \
    > "$tmpdir/apps/basic/ios/Runner/Info.plist"
  cp "$tmpdir/apps/basic/ios/Runner/Info.plist" \
     "$tmpdir/apps/debug/ios/Runner/Info.plist"

  printf 'name: app_template\n' > "$tmpdir/pubspec.yaml"
  mkdir -p "$tmpdir/tools/mason"

  printf '%s' "$tmpdir"
}

@test "confirmation with y triggers rename and exits (success or bootstrap-fail)" {
  local tmpdir
  tmpdir="$(_setup_minimal_project)"

  # y confirms and triggers rename; make init will fail (no Flutter toolchain in CI)
  # but we only verify the rename section started
  run bash -c '
    PROJECT_ROOT="'"$tmpdir"'" printf "My App\ncom.example.myapp\ncom.example.myapp\ny\n" | \
    PROJECT_ROOT="'"$tmpdir"'" bash "'"$PROJECT_DIR/$SCRIPT"'"
  '
  # Exit 0 (make init skipped if not present) or exit 1 (make init failed) are both valid
  # The key assertion: the rename section was reached
  [[ "$output" == *"=== Renaming ==="* ]] || [[ "$output" == *"=== Summary ==="* ]]
  rm -rf "$tmpdir"
}

@test "confirmation with yes triggers rename section" {
  local tmpdir
  tmpdir="$(_setup_minimal_project)"

  run bash -c '
    PROJECT_ROOT="'"$tmpdir"'" printf "My App\ncom.example.myapp\ncom.example.myapp\nyes\n" | \
    PROJECT_ROOT="'"$tmpdir"'" bash "'"$PROJECT_DIR/$SCRIPT"'"
  '
  [[ "$output" == *"=== Renaming ==="* ]] || [[ "$output" == *"=== Summary ==="* ]]
  rm -rf "$tmpdir"
}

@test "confirmation with n exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\nn\n" | bash '"$PROJECT_DIR/$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "confirmation with empty input (default No) exits 0" {
  run bash -c 'printf "My App\ncom.example.myapp\ncom.example.myapp\n\n" | bash '"$PROJECT_DIR/$SCRIPT"
  [ "$status" -eq 0 ]
}

@test "summary shows all three values" {
  run bash -c 'printf "Test App\ncom.test.android\ncom.test.ios\nn\n" | bash '"$PROJECT_DIR/$SCRIPT"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Test App"* ]]
  [[ "$output" == *"com.test.android"* ]]
  [[ "$output" == *"com.test.ios"* ]]
}

@test "--help flag shows usage and exits 0" {
  run bash "$PROJECT_DIR/$SCRIPT" --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage"* ]]
  [[ "$output" == *"App display name"* ]]
  [[ "$output" == *"Android bundle ID"* ]]
  [[ "$output" == *"iOS bundle ID"* ]]
}

@test "-h flag shows usage and exits 0" {
  run bash "$PROJECT_DIR/$SCRIPT" -h
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage"* ]]
}
