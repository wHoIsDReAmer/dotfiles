#!/usr/bin/env bash
# Cycle ASUS platform power profile: quiet -> balanced -> performance -> quiet
# Reads current from ACPI sysfs (no root needed) and sets the next one via
# asusctl (asusd exposes it over D-Bus, so no sudo required at runtime).
set -euo pipefail

PP=/sys/firmware/acpi/platform_profile

cur=$(cat "$PP" 2>/dev/null || echo balanced)
case "$cur" in
  quiet)       next=balanced ;;
  balanced)    next=performance ;;
  performance) next=quiet ;;
  *)           next=balanced ;;
esac

if command -v asusctl >/dev/null 2>&1; then
  case "$next" in
    quiet)       p=Quiet ;;
    balanced)    p=Balanced ;;
    performance) p=Performance ;;
  esac
  asusctl profile -P "$p" >/dev/null 2>&1 || true
else
  # Fallback if asusctl isn't installed yet (usually needs root to write)
  echo "$next" | tee "$PP" >/dev/null 2>&1 || true
fi

sleep 0.3
now=$(cat "$PP" 2>/dev/null || echo "$next")

if command -v notify-send >/dev/null 2>&1; then
  notify-send -t 1500 \
    -h string:x-canonical-private-synchronous:powerprofile \
    "Power profile" "→ ${now^}"
fi
