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

main() {
  # Argument parsing: check for --help or -h
  for arg in "$@"; do
    if [[ "$arg" == "--help" ]] || [[ "$arg" == "-h" ]]; then
      show_help
      exit 0
    fi
  done

  printf "${BOLD}=== App Template Init ===${RESET}\n\n"

  prompt_app_name
  app_name="$_INPUT_RESULT"

  prompt_bundle_id "Android bundle ID" "com.example.myapp"
  android_bundle_id="$_INPUT_RESULT"

  prompt_bundle_id "iOS bundle ID" "com.example.myapp"
  ios_bundle_id="$_INPUT_RESULT"

  show_summary "$app_name" "$android_bundle_id" "$ios_bundle_id"

  if confirm_proceed; then
    exit 0
  else
    exit 0
  fi
}

main "$@"
