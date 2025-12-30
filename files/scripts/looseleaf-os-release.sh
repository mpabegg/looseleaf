#!/usr/bin/env bash
set -euo pipefail

# Looseleaf branding: update the OS display name while preserving base IDs.
if [[ -f /usr/lib/os-release ]]; then
  sed -i 's/^NAME=.*/NAME="Looseleaf"/' /usr/lib/os-release
  sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Looseleaf (Bazzite KDE)"/' /usr/lib/os-release
  if grep -q '^DEFAULT_HOSTNAME=' /usr/lib/os-release; then
    sed -i 's/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME="looseleaf"/' /usr/lib/os-release
  fi
fi
