#!/usr/bin/env bash
# Quick wrapper to check and set up environment & dependencies
exec "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/scripts/setup_deps.sh" "$@"
