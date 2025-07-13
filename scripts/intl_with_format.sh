#!/usr/bin/env bash

fvm flutter gen-l10n
fvm dart format -l 100 lib/l10n
