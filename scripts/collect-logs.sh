#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Cargar entorno y variables desde .env
source "$SCRIPT_DIR/common_env.sh"

LOG_DIR="$PROJECT_ROOT/logs"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="$LOG_DIR/gunbros_${TIMESTAMP}.log"

mkdir -p "$LOG_DIR"

ADB_CMD="adb"
if [[ -n "${ADB_SERIAL:-}" ]]; then
    ADB_CMD="adb -s $ADB_SERIAL"
fi

echo "=== [GunBros Logcat] Collecting logs to $OUT_FILE ==="
echo "Filtered tags: GunBros, GunBrosBridge, GunBrosFS, GLU, dynarmic, DEBUG, AndroidRuntime"

$ADB_CMD logcat -c || true
$ADB_CMD logcat -v time \
  GunBros:V \
  GunBrosBridge:V \
  GunBrosFS:V \
  GLU:V \
  dynarmic:V \
  DEBUG:V \
  AndroidRuntime:E \
  *:S | tee "$OUT_FILE"
