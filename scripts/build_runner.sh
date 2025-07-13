#!/usr/bin/env bash

if [ "$(basename "$PWD")" = 'scripts' ]; then cd ..; fi

fvm flutter pub get &&
  fvm dart run build_runner build --delete-conflicting-outputs &&
  sh scripts/format.sh
