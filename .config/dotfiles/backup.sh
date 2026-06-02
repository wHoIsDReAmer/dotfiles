#!/usr/bin/env bash
# Snapshot the current Arch system (explicit packages + enabled user services)
# into the dotfiles repo. Run occasionally to keep the lists fresh.
#
#   ~/.config/dotfiles/backup.sh            # just refresh the list files
#   ~/.config/dotfiles/backup.sh --commit   # refresh, then commit via `dot`
set -euo pipefail

META_DIR="$HOME/.config/dotfiles"
dot() { git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"; }

echo "==> Snapshotting explicitly-installed packages"
pacman -Qqen > "$META_DIR/pkglist-native.txt"   # official repos
pacman -Qqem > "$META_DIR/pkglist-aur.txt"       # AUR / foreign

echo "==> Snapshotting enabled user systemd units"
systemctl --user list-unit-files --state=enabled --no-legend 2>/dev/null \
  | awk '{print $1}' > "$META_DIR/services-user.txt"

printf '    native=%s  aur=%s  services=%s\n' \
  "$(wc -l < "$META_DIR/pkglist-native.txt")" \
  "$(wc -l < "$META_DIR/pkglist-aur.txt")" \
  "$(wc -l < "$META_DIR/services-user.txt")"

if [[ "${1:-}" == "--commit" ]]; then
  dot add "$META_DIR/pkglist-native.txt" "$META_DIR/pkglist-aur.txt" "$META_DIR/services-user.txt"
  if dot diff --cached --quiet; then
    echo "==> No changes to commit"
  else
    dot commit -m "snapshot: package & service lists ($(date +%Y-%m-%d))"
    echo "==> Committed. Push with:  dot push"
  fi
fi
