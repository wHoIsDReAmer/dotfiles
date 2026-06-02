# dotfiles

Hyprland desktop config for Arch Linux, managed as a **bare git repo** tracking
`$HOME`. Includes a one-shot bootstrap that reinstalls every package and service
on a fresh machine.

## What's inside

- **Hyprland stack:** `hypr` (hyprland/hypridle/hyprlock), `waybar`, `rofi`,
  `swaync`, `wlogout`, `waypaper`, `matugen`
- **Terminals & TUIs:** `kitty`, `ghostty`, `cava`, `btop`, `htop`, `fastfetch`,
  `lazygit`, `lazydocker`
- **Theming:** `gtk-3.0/4.0`, `qt5ct`, `qt6ct`, `nwg-look`
- **Shell:** `.zshrc`, `.zshenv`, `.bashrc`, `.gitconfig`, `.nanorc`
- **Reproducibility:** `pkglist-native.txt`, `pkglist-aur.txt`,
  `services-user.txt`, plus `bootstrap.sh` / `backup.sh`

## The `dot` command

This repo has **no working tree of its own** — it overlays `$HOME`. Drive it with:

```sh
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

(Already added to `.zshrc`.) Then `dot status`, `dot add <path>`, `dot commit`,
`dot push` all behave like normal git, rooted at `$HOME`.

> ⚠️ **Never** `dot add -A`. Add files by explicit path. `.gitignore` hard-blocks
> known-sensitive paths (keys, wallets, sessions) as a backstop.

## Restore on a fresh Arch install

```sh
# 1. Clone the bare repo
git clone --bare https://github.com/wHoIsDReAmer/dotfiles "$HOME/.dotfiles"
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 2. Check the dotfiles out into $HOME
#    (if it complains about existing files, back them up and retry)
dot checkout
dot config status.showUntrackedFiles no

# 3. Install all packages + enable services
~/.config/dotfiles/bootstrap.sh

# 4. Log out and start Hyprland
```

## Keep it up to date

```sh
~/.config/dotfiles/backup.sh --commit   # refresh package lists + commit
dot push
```
