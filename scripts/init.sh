#!/usr/bin/env bash
set -u

# ANSI color constants (\033[ for bash 3.2 compatibility)
BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
RESET='\033[0m'

# Bundle ID regex: 2+ segments, each starting with a letter, no trailing dot
# Store in variable — do NOT quote inside [[ =~ ]] or it becomes a literal match
BUNDLE_ID_REGEX='^[a-zA-Z][a-zA-Z0-9_-]*(\.[a-zA-Z][a-zA-Z0-9_-]*){1,}$'

# Global result variable — prompt functions set this; caller reads it after function returns
_INPUT_RESULT=""

# Project root: resolved relative to this script's location so the script
# works regardless of the caller's working directory. Tests override PROJECT_ROOT.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${PROJECT_ROOT:-$(cd "$SCRIPT_DIR/.." && pwd)}"

# ---------------------------------------------------------------------------
# Phase 1: Interactive input functions
# ---------------------------------------------------------------------------

show_help() {
  printf "${BOLD}Usage:${RESET} scripts/init.sh [--help]\n"
  printf "\n"
  printf "Interactive script to configure app name and bundle IDs for a new project.\n"
  printf "\n"
  printf "${BOLD}Prompts:${RESET}\n"
  printf "  App display name     Human-readable app name (e.g. My App)\n"
  printf "  Android bundle ID    Reverse-domain package name (e.g. com.example.myapp)\n"
  printf "  iOS bundle ID        Reverse-domain bundle identifier (e.g. com.example.myapp)\n"
}

prompt_app_name() {
  while true; do
    printf "${BOLD}App display name:${RESET} "
    if ! read -r _INPUT_RESULT; then
      printf "\n"
      exit 1
    fi
    if [[ -z "$_INPUT_RESULT" ]]; then
      printf "${RED}Error: App name cannot be empty.${RESET}\n"
      continue
    fi
    break
  done
}

# $1 = label text (e.g. "Android bundle ID")
# $2 = format hint (e.g. "com.example.myapp")
prompt_bundle_id() {
  while true; do
    printf "${BOLD}%s${RESET} (e.g. %s): " "$1" "$2"
    if ! read -r _INPUT_RESULT; then
      printf "\n"
      exit 1
    fi
    if [[ -z "$_INPUT_RESULT" ]]; then
      printf "${RED}Error: Bundle ID cannot be empty.${RESET}\n"
      continue
    fi
    if [[ ! "$_INPUT_RESULT" =~ $BUNDLE_ID_REGEX ]]; then
      printf "${RED}Error: Invalid format. Use reverse-domain notation (e.g. com.example.myapp).${RESET}\n"
      continue
    fi
    break
  done
}

# $1 = app_name, $2 = android_id, $3 = ios_id
show_summary() {
  printf "\n${BOLD}=== Summary ===${RESET}\n"
  printf "  App name:          %s\n" "$1"
  printf "  Android bundle ID: %s\n" "$2"
  printf "  iOS bundle ID:     %s\n" "$3"
  printf "\n"
}

confirm_proceed() {
  printf "${BOLD}Proceed? [y/N]:${RESET} "
  if ! read -r reply; then
    printf "\n"
    return 1
  fi
  if [[ "$reply" =~ ^[yY] ]]; then
    return 0
  else
    return 1
  fi
}

# ---------------------------------------------------------------------------
# Phase 2: Target discovery & file rename functions
# ---------------------------------------------------------------------------

# APP_TARGETS — populated by discover_app_targets; array of directory basenames under apps/.
APP_TARGETS=()

# discover_app_targets
# Scans apps/ for subdirectories and populates APP_TARGETS. Prints what was found.
discover_app_targets() {
  APP_TARGETS=()
  for dir in "$PROJECT_ROOT"/apps/*/; do
    [ -d "$dir" ] || continue
    APP_TARGETS+=("$(basename "$dir")")
  done

  if [[ ${#APP_TARGETS[@]} -eq 0 ]]; then
    printf "${RED}Error: no app targets found under apps/${RESET}\n" >&2
    exit 1
  fi

  printf "${BOLD}Detected app targets:${RESET}\n"
  for target in "${APP_TARGETS[@]}"; do
    local files=""
    [ -f "$PROJECT_ROOT/apps/${target}/android/app/build.gradle.kts" ] && files+="gradle "
    [ -f "$PROJECT_ROOT/apps/${target}/ios/Flutter/common.xcconfig" ] && files+="xcconfig "
    [ -f "$PROJECT_ROOT/apps/${target}/ios/Runner/Info.plist" ] && files+="plist "
    [ -d "$PROJECT_ROOT/apps/${target}/android/app/src/main/kotlin/com/example/app_template" ] && files+="kotlin "
    printf "  %s (%s)\n" "$target" "${files% }"
  done
  printf "\n"
}

# _rename_file <file> <description> [sed-args...]
# Runs sed -i '' with the given args on the file. Prints green check on success,
# red error and exits 1 on failure.
_rename_file() {
  local file="$1"
  local description="$2"
  shift 2
  if sed -i '' "$@" "$file"; then
    printf "${GREEN}✓${RESET} %s\n" "$description"
  else
    printf "${RED}Error: failed to rename %s${RESET}\n" "$file" >&2
    exit 1
  fi
}

# check_already_initialized
# Exits 0 with a warning if the sentinel value is absent from ALL build.gradle.kts files.
check_already_initialized() {
  local found=false
  for gradle in "$PROJECT_ROOT"/apps/*/android/app/build.gradle.kts; do
    if [ -f "$gradle" ] && grep -q "com\.example\.app_template" "$gradle" 2>/dev/null; then
      found=true
      break
    fi
  done
  if [[ "$found" == false ]]; then
    printf "${BOLD}Warning:${RESET} This project appears to already be initialized.\n"
    printf "Sentinel value 'com.example.app_template' not found in any build.gradle.kts.\n"
    printf "If you want to re-initialize, manually restore the sentinel values first.\n"
    exit 0
  fi
}

# derive_dart_package_name <app_name>
# Sets _INPUT_RESULT to snake_case version of app_name ("My Cool App" -> "my_cool_app").
derive_dart_package_name() {
  _INPUT_RESULT="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')"
}

# rename_android <app_name> <android_bundle_id>
# INIT-05: Updates namespace, applicationId, and resValue strings in all
# discovered app targets that have build.gradle.kts.
rename_android() {
  local app_name="$1"
  local android_bundle_id="$2"
  local old_android="com.example.app_template"
  local old_android_escaped
  old_android_escaped="$(printf '%s' "$old_android" | sed 's/\./\\./g')"

  for target in "${APP_TARGETS[@]}"; do
    local file="$PROJECT_ROOT/apps/${target}/android/app/build.gradle.kts"
    [ -f "$file" ] || continue
    # Replace namespace and applicationId (same sentinel, two occurrences)
    _rename_file "$file" "apps/${target}/android/app/build.gradle.kts (bundle ID)" \
      "s/${old_android_escaped}/${android_bundle_id}/g"
    # Replace dev resValue first (must precede prod to avoid double-replace if names overlap)
    _rename_file "$file" "apps/${target}/android/app/build.gradle.kts (dev name)" \
      "s|\"App Template (Dev)\"|\"${app_name} (Dev)\"|g"
    # Replace prod resValue
    _rename_file "$file" "apps/${target}/android/app/build.gradle.kts (prod name)" \
      "s|\"App Template\"|\"${app_name}\"|g"
  done
}

# rename_ios_xcconfig <ios_bundle_id>
# INIT-06: Updates identifier= in all discovered targets that have common.xcconfig.
rename_ios_xcconfig() {
  local ios_bundle_id="$1"
  local old_ios="com.example.appTemplate"
  local old_ios_escaped
  old_ios_escaped="$(printf '%s' "$old_ios" | sed 's/\./\\./g')"

  for target in "${APP_TARGETS[@]}"; do
    local file="$PROJECT_ROOT/apps/${target}/ios/Flutter/common.xcconfig"
    [ -f "$file" ] || continue
    _rename_file "$file" "apps/${target}/ios/Flutter/common.xcconfig" \
      "s/identifier=${old_ios_escaped}/identifier=${ios_bundle_id}/"
  done
}

# rename_ios_plist <app_name> <dart_package_name>
# INIT-07: Updates CFBundleDisplayName and CFBundleName in all discovered targets
# that have Info.plist.
rename_ios_plist() {
  local app_name="$1"
  local dart_package_name="$2"

  for target in "${APP_TARGETS[@]}"; do
    local file="$PROJECT_ROOT/apps/${target}/ios/Runner/Info.plist"
    [ -f "$file" ] || continue
    _rename_file "$file" "apps/${target}/ios/Runner/Info.plist" \
      -e "s|<string>App Template</string>|<string>${app_name}</string>|g" \
      -e "s|<string>app_template</string>|<string>${dart_package_name}</string>|g"
  done
}

# rename_pubspec <dart_package_name>
# INIT-08: Updates the name: field in root pubspec.yaml only (not sub-packages).
rename_pubspec() {
  local dart_package_name="$1"
  local file="$PROJECT_ROOT/pubspec.yaml"
  _rename_file "$file" "pubspec.yaml" \
    "s|^name: app_template$|name: ${dart_package_name}|"
}

# rename_kotlin_dir <android_bundle_id>
# INIT-09: Moves MainActivity.kt from old package path to new path derived from
# the Android bundle ID. Operates on all discovered targets that have the old Kotlin path.
rename_kotlin_dir() {
  local android_bundle_id="$1"
  local old_kotlin_path="com/example/app_template"
  local new_kotlin_path
  new_kotlin_path="$(printf '%s' "$android_bundle_id" | tr '.' '/')"
  local old_android_escaped
  old_android_escaped="$(printf '%s' "com.example.app_template" | sed 's/\./\\./g')"

  for target in "${APP_TARGETS[@]}"; do
    local base="$PROJECT_ROOT/apps/${target}/android/app/src/main/kotlin"
    local old_dir="$base/$old_kotlin_path"
    [ -d "$old_dir" ] || continue
    local new_dir="$base/$new_kotlin_path"

    mkdir -p "$new_dir" || {
      printf "${RED}Error: mkdir -p %s${RESET}\n" "$new_dir" >&2
      exit 1
    }
    mv "$old_dir/MainActivity.kt" "$new_dir/MainActivity.kt" || {
      printf "${RED}Error: mv MainActivity.kt in apps/%s${RESET}\n" "$target" >&2
      exit 1
    }

    # Clean up empty old leaf directory (best-effort; ignore failure if non-empty)
    rmdir "$old_dir" 2>/dev/null
    # Clean up empty parent dirs (best-effort)
    rmdir "$base/com/example" 2>/dev/null
    rmdir "$base/com" 2>/dev/null

    # Fix package declaration in moved file
    if ! sed -i '' \
      "s|^package ${old_android_escaped}$|package ${android_bundle_id}|" \
      "$new_dir/MainActivity.kt"; then
      printf "${RED}Error: sed package declaration in apps/%s/MainActivity.kt${RESET}\n" "$target" >&2
      exit 1
    fi

    printf "${GREEN}✓${RESET} apps/%s android Kotlin dir + MainActivity.kt\n" "$target"
  done
}

# verify_no_residuals
# Scans the project for residual references to old sentinel values.
# Prints warnings but does NOT modify any files (non-blocking).
verify_no_residuals() {
  local found
  found="$(grep -rl \
    --include='*.kt' --include='*.kts' --include='*.plist' \
    --include='*.xcconfig' --include='*.yaml' --include='*.dart' \
    --include='*.pbxproj' \
    --exclude-dir='.git' --exclude-dir='.dart_tool' \
    --exclude-dir='Pods' --exclude-dir='build' \
    -e "com\.example\.app_template" \
    -e "com\.example\.appTemplate" \
    -e "app_template" \
    -e "App Template" \
    "$PROJECT_ROOT" 2>/dev/null || true)"

  if [[ -n "$found" ]]; then
    printf "\n${BOLD}Warning: residual references found in:${RESET}\n"
    printf '%s\n' "$found" | while IFS= read -r f; do
      printf "  %s\n" "${f#"$PROJECT_ROOT"/}"
    done
    printf "Some residuals (e.g. project.pbxproj) are expected — review manually.\n"
    printf "For App Store submissions, update PRODUCT_BUNDLE_IDENTIFIER in Xcode.\n"
  else
    printf "${GREEN}✓${RESET} No residual references found.\n"
  fi
}

# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------

main() {
  # Argument parsing: check for --help or -h
  for arg in "$@"; do
    if [[ "$arg" == "--help" ]] || [[ "$arg" == "-h" ]]; then
      show_help
      exit 0
    fi
  done

  # Idempotency: abort if project already initialized
  check_already_initialized

  printf "${BOLD}=== App Template Init ===${RESET}\n\n"

  prompt_app_name
  app_name="$_INPUT_RESULT"

  prompt_bundle_id "Android bundle ID" "com.example.myapp"
  android_bundle_id="$_INPUT_RESULT"

  prompt_bundle_id "iOS bundle ID" "com.example.myapp"
  ios_bundle_id="$_INPUT_RESULT"

  show_summary "$app_name" "$android_bundle_id" "$ios_bundle_id"

  if confirm_proceed; then
    printf "\n${BOLD}=== Renaming ===${RESET}\n\n"

    derive_dart_package_name "$app_name"
    dart_package_name="$_INPUT_RESULT"

    rename_android "$app_name" "$android_bundle_id"
    rename_ios_xcconfig "$ios_bundle_id"
    rename_ios_plist "$app_name" "$dart_package_name"
    rename_pubspec "$dart_package_name"
    rename_kotlin_dir "$android_bundle_id"

    printf "\n"
    verify_no_residuals

    printf "\n${BOLD}=== Bootstrap ===${RESET}\n\n"
    if make -C "$PROJECT_ROOT" init; then
      printf "\n${GREEN}✓${RESET} Project initialized successfully!\n"
    else
      printf "\n${RED}Renames succeeded but bootstrap (make init) failed.${RESET}\n"
      printf "Run 'make init' manually to complete setup.\n"
      exit 1
    fi
  else
    printf "Aborted.\n"
    exit 0
  fi
}

# Only run main when executed directly (not when sourced for unit testing)
[[ "${BASH_SOURCE[0]}" != "${0}" ]] || main "$@"
