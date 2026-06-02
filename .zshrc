# If you come from bash you might have to change your $PATH.
PROMPT='%F{green}%n@%m%f %B%F{blue}%~%f%b %# '
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="dd.mm.yyyy"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
git
archlinux
zsh-autosuggestions
zsh-syntax-highlighting
dirhistory
# zsh-wakatime
# docker
# poetry
)

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# User configuration
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:~/go/bin/
export PATH=$PATH:$HOME/.npm-global/bin

# pnpm
export PNPM_HOME="/home/developer/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Aliases
if [ -x "$(command -v lsd)" ]; then
    alias ls="lsd"
    alias la="lsd --long --all --group-dirs first"
    alias lt="lsd --tree --group-dirs first"
fi

alias clck="tty-clock -c -s -b -C 6"
alias ff='fastfetch'
alias psu='sudo pacman -Syuu'

alias rmt='trash-put'
alias clean-trash='trash-empty 29'

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# opencode
export PATH=/home/developer/.opencode/bin:$PATH

alias claude='claude --dangerously-skip-permissions'

# Android SDK
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator

# dotfiles bare repo
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
