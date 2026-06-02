#!/usr/bin/env bash
# Fresh-Arch bootstrap: install every package this setup needs, then enable the
# user services. Run this AFTER the dotfiles are already checked out into $HOME
# (see README). Safe to re-run — every step is idempotent (--needed / enable).
set -euo pipefail

META_DIR="$HOME/.config/dotfiles"

echo "==> Updating system (pacman -Syu)"
sudo pacman -Syu --noconfirm

# Ensure an AUR helper exists
if ! command -v yay >/dev/null 2>&1; then
  echo "==> Installing yay (AUR helper)"
  sudo pacman -S --needed --noconfirm git base-devel
  tmp="$(mktemp -d)"
  git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  ( cd "$tmp/yay-bin" && makepkg -si --noconfirm )
  rm -rf "$tmp"
fi

echo "==> Installing native (official-repo) packages"
sudo pacman -S --needed --noconfirm - < "$META_DIR/pkglist-native.txt"

echo "==> Installing AUR packages"
yay -S --needed --noconfirm - < "$META_DIR/pkglist-aur.txt"

echo "==> Enabling user systemd services"
while read -r unit; do
  [[ -z "$unit" ]] && continue
  systemctl --user enable "$unit" 2>/dev/null && echo "    enabled $unit" || echo "    skip    $unit"
done < "$META_DIR/services-user.txt"

echo
echo "==> Done. Log out and pick Hyprland at your display manager (or run Hyprland)."
