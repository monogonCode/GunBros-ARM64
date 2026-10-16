#!/usr/bin/env bash
# GunBros ARM64 Bridge Root Build Wrapper
# Forwards to scripts/build.sh

set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$DIR/scripts/build.sh" "$@"
