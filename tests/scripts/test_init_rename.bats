#!/usr/bin/env bats

SCRIPT="scripts/init.sh"
PROJECT_DIR="/Users/samirakhmedov/Projects/app_template"

# Each test gets a fresh temp directory that mirrors the relevant project structure.
# We source init.sh to call rename functions directly (no interactive I/O needed).
#
# Sourcing strategy: define main() as a no-op before sourcing init.sh so the
# `main "$@"` call at the bottom does not start the interactive prompt loop.

setup() {
  TMPDIR="$(mktemp -d)"
  export TMPDIR

  # Android dirs for basic + debug
  mkdir -p "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/example/app_template"
  mkdir -p "$TMPDIR/apps/debug/android/app/src/main/kotlin/com/example/app_template"

  # Kotlin source files
  printf 'package com.example.app_template\n\nimport android.os.Bundle\nclass MainActivity {}\n' \
    > "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/example/app_template/MainActivity.kt"
  printf 'package com.example.app_template\n\nimport android.os.Bundle\nclass MainActivity {}\n' \
    > "$TMPDIR/apps/debug/android/app/src/main/kotlin/com/example/app_template/MainActivity.kt"

  # build.gradle.kts for basic
  cat > "$TMPDIR/apps/basic/android/app/build.gradle.kts" <<'GRADLE'
android {
    namespace = "com.example.app_template"
    defaultConfig {
        applicationId = "com.example.app_template"
        resValue("string", "app_name", "App Template (Dev)")
        resValue("string", "app_name_prod", "App Template")
    }
}
GRADLE

  # build.gradle.kts for debug (identical)
  cp "$TMPDIR/apps/basic/android/app/build.gradle.kts" \
     "$TMPDIR/apps/debug/android/app/build.gradle.kts"

  # iOS xcconfig for basic + debug
  mkdir -p "$TMPDIR/apps/basic/ios/Flutter"
  mkdir -p "$TMPDIR/apps/debug/ios/Flutter"
  printf 'app_icon=AppIcon\nidentifier=com.example.appTemplate\n' \
    > "$TMPDIR/apps/basic/ios/Flutter/common.xcconfig"
  cp "$TMPDIR/apps/basic/ios/Flutter/common.xcconfig" \
     "$TMPDIR/apps/debug/ios/Flutter/common.xcconfig"

  # iOS Info.plist for basic + debug
  mkdir -p "$TMPDIR/apps/basic/ios/Runner"
  mkdir -p "$TMPDIR/apps/debug/ios/Runner"
  cat > "$TMPDIR/apps/basic/ios/Runner/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDisplayName</key>
	<string>App Template</string>
	<key>CFBundleName</key>
	<string>app_template</string>
</dict>
</plist>
PLIST
  cp "$TMPDIR/apps/basic/ios/Runner/Info.plist" \
     "$TMPDIR/apps/debug/ios/Runner/Info.plist"

  # Root pubspec.yaml
  printf 'name: app_template\nversion: 1.0.0\n' > "$TMPDIR/pubspec.yaml"
}

teardown() {
  rm -rf "$TMPDIR"
}

# ---------------------------------------------------------------------------
# INIT-05: Android build.gradle.kts rename
# ---------------------------------------------------------------------------

@test "INIT-05: rename_android replaces namespace and applicationId in basic build.gradle.kts" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_android "My App" "com.newco.myapp"
  '
  grep -q 'namespace = "com.newco.myapp"' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
  grep -q 'applicationId = "com.newco.myapp"' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
  ! grep -q 'com.example.app_template' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
}

@test "INIT-05: rename_android replaces namespace and applicationId in debug build.gradle.kts" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_android "My App" "com.newco.myapp"
  '
  grep -q 'namespace = "com.newco.myapp"' "$TMPDIR/apps/debug/android/app/build.gradle.kts"
  grep -q 'applicationId = "com.newco.myapp"' "$TMPDIR/apps/debug/android/app/build.gradle.kts"
  ! grep -q 'com.example.app_template' "$TMPDIR/apps/debug/android/app/build.gradle.kts"
}

@test "INIT-05: rename_android sets dev resValue to 'My App (Dev)'" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_android "My App" "com.newco.myapp"
  '
  grep -q '"My App (Dev)"' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
  ! grep -q '"App Template (Dev)"' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
}

@test "INIT-05: rename_android sets prod resValue to 'My App'" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_android "My App" "com.newco.myapp"
  '
  grep -q '"My App"' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
  ! grep -q '"App Template"[^(]' "$TMPDIR/apps/basic/android/app/build.gradle.kts"
}

# ---------------------------------------------------------------------------
# INIT-06: iOS common.xcconfig rename
# ---------------------------------------------------------------------------

@test "INIT-06: rename_ios_xcconfig replaces identifier in basic common.xcconfig" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_ios_xcconfig "com.newco.myApp"
  '
  grep -q 'identifier=com.newco.myApp' "$TMPDIR/apps/basic/ios/Flutter/common.xcconfig"
  ! grep -q 'com.example.appTemplate' "$TMPDIR/apps/basic/ios/Flutter/common.xcconfig"
}

@test "INIT-06: rename_ios_xcconfig replaces identifier in debug common.xcconfig" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_ios_xcconfig "com.newco.myApp"
  '
  grep -q 'identifier=com.newco.myApp' "$TMPDIR/apps/debug/ios/Flutter/common.xcconfig"
  ! grep -q 'com.example.appTemplate' "$TMPDIR/apps/debug/ios/Flutter/common.xcconfig"
}

# ---------------------------------------------------------------------------
# INIT-07: iOS Info.plist rename
# ---------------------------------------------------------------------------

@test "INIT-07: rename_ios_plist updates CFBundleDisplayName in basic Info.plist" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_ios_plist "My App" "my_app"
  '
  grep -q '<string>My App</string>' "$TMPDIR/apps/basic/ios/Runner/Info.plist"
  ! grep -q '<string>App Template</string>' "$TMPDIR/apps/basic/ios/Runner/Info.plist"
}

@test "INIT-07: rename_ios_plist updates CFBundleName to snake_case in basic Info.plist" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_ios_plist "My App" "my_app"
  '
  grep -q '<string>my_app</string>' "$TMPDIR/apps/basic/ios/Runner/Info.plist"
  ! grep -q '<string>app_template</string>' "$TMPDIR/apps/basic/ios/Runner/Info.plist"
}

@test "INIT-07: rename_ios_plist updates both targets" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_ios_plist "My App" "my_app"
  '
  grep -q '<string>My App</string>' "$TMPDIR/apps/debug/ios/Runner/Info.plist"
  grep -q '<string>my_app</string>' "$TMPDIR/apps/debug/ios/Runner/Info.plist"
}

# ---------------------------------------------------------------------------
# INIT-08: Root pubspec.yaml rename
# ---------------------------------------------------------------------------

@test "INIT-08: rename_pubspec updates name field in root pubspec.yaml" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    rename_pubspec "my_app"
  '
  grep -q '^name: my_app$' "$TMPDIR/pubspec.yaml"
  ! grep -q '^name: app_template$' "$TMPDIR/pubspec.yaml"
}

@test "INIT-08: rename_pubspec does not modify sub-package pubspec files" {
  mkdir -p "$TMPDIR/packages/some_pkg"
  printf 'name: some_pkg\nversion: 1.0.0\n' > "$TMPDIR/packages/some_pkg/pubspec.yaml"

  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    rename_pubspec "my_app"
  '
  grep -q '^name: some_pkg$' "$TMPDIR/packages/some_pkg/pubspec.yaml"
}

# ---------------------------------------------------------------------------
# INIT-09: Kotlin directory move
# ---------------------------------------------------------------------------

@test "INIT-09: rename_kotlin_dir moves MainActivity.kt to new package path in basic" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_kotlin_dir "com.newco.myapp"
  '
  [ -f "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/newco/myapp/MainActivity.kt" ]
}

@test "INIT-09: rename_kotlin_dir moves MainActivity.kt to new package path in debug" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_kotlin_dir "com.newco.myapp"
  '
  [ -f "$TMPDIR/apps/debug/android/app/src/main/kotlin/com/newco/myapp/MainActivity.kt" ]
}

@test "INIT-09: rename_kotlin_dir removes old package directory" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_kotlin_dir "com.newco.myapp"
  '
  [ ! -d "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/example/app_template" ]
}

@test "INIT-09: rename_kotlin_dir updates package declaration in MainActivity.kt" {
  PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    APP_TARGETS=(basic debug)
    rename_kotlin_dir "com.newco.myapp"
  '
  grep -q '^package com.newco.myapp$' \
    "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/newco/myapp/MainActivity.kt"
  ! grep -q 'com.example.app_template' \
    "$TMPDIR/apps/basic/android/app/src/main/kotlin/com/newco/myapp/MainActivity.kt"
}

# ---------------------------------------------------------------------------
# derive_dart_package_name
# ---------------------------------------------------------------------------

@test "derive_dart_package_name converts 'My App' to 'my_app'" {
  result=$(PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    derive_dart_package_name "My App"
    printf "%s" "$_INPUT_RESULT"
  ')
  [ "$result" = "my_app" ]
}

@test "derive_dart_package_name converts 'My Cool App' to 'my_cool_app'" {
  result=$(PROJECT_ROOT="$TMPDIR" bash -c '
    main() { :; }
    source "'"$PROJECT_DIR/$SCRIPT"'"
    derive_dart_package_name "My Cool App"
    printf "%s" "$_INPUT_RESULT"
  ')
  [ "$result" = "my_cool_app" ]
}

# ---------------------------------------------------------------------------
# Idempotency: already-initialized project
# ---------------------------------------------------------------------------

@test "check_already_initialized exits 0 with warning when sentinel absent" {
  sed -i '' 's/com.example.app_template/com.newco.myapp/g' \
    "$TMPDIR/apps/basic/android/app/build.gradle.kts"
  sed -i '' 's/com.example.app_template/com.newco.myapp/g' \
    "$TMPDIR/apps/debug/android/app/build.gradle.kts"

  run bash -c '
    main() { :; }
    export PROJECT_ROOT="'"$TMPDIR"'"
    source "'"$PROJECT_DIR/$SCRIPT"'"
    check_already_initialized
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"already be initialized"* ]]
}

@test "check_already_initialized does NOT exit when sentinel is present" {
  run bash -c '
    main() { :; }
    export PROJECT_ROOT="'"$TMPDIR"'"
    source "'"$PROJECT_DIR/$SCRIPT"'"
    check_already_initialized
    printf "sentinel_found"
  '
  [ "$status" -eq 0 ]
  [[ "$output" == *"sentinel_found"* ]]
}
