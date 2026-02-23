# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh/

# Powerlevel10k theme path
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=(alias-finder fzf-tab git man sudo zsh-256color zsh-autosuggestions zsh-completions zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# Set default editor to nvim
export EDITOR=nvim

# Helpful aliases
alias c='clear && pokemon-colorscripts --no-title -r 1,3,6' # clear terminal
alias ll='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias lsl='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias lsd='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias ld='ld'
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor
alias btry='upower -i $(upower -e | grep BAT)' # battery checker
alias cal='calcure' # calendar

# Directory navigation shortcuts
alias cd='z'
alias ..='z ..'
alias ...='z ../..'
alias .3='z ../../..'
alias .4='z ../../../..'
alias .5='z ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# Python alias
alias py='python3'

# Zathura
alias za='zathura'

# Wiki
alias wiki='wiki-tui'

# Fastfetch
alias ff='fastfetch'

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin z -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# Neovim
alias v='nvim'
alias vi='nvim .'
alias vim='nvim'

# Quit
alias q='exit'

# Zellij
alias zel='zellij'

function zela() {
  if zellij list-sessions | grep "home"; then
    echo "Session 'home' found. Attaching..."
    zellij attach home
  else
    echo "Session 'home' not found. Creating..."
    zellij --session home
  fi
}

# Google
alias google='ddgr'

alias gae='~/.local/share/bin/gae.sh'

alias temp='try-rs'

alias speedtest='cloudflare-speed-cli'

alias download='surge'

alias waybar='killall waybar 2>/dev/null; hyprctl dispatch exec waybar &'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initializing rustup
. "$HOME/.cargo/env"

# Display Pokemon
pokemon-colorscripts --no-title -r 1,3,6

# Qemu setup
export LIBVIRT_DEFAULT_URI="qemu:///system"

# Alias finder
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' longer yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# FZF
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath'

# Open manual in vim
export MANPAGER='nvim +Man!'

export PATH=$PATH:$HOME/.local/go/bin
export PATH=$PATH:$HOME/go/bin
export ZEIT_DB=$HOME/.config/zeit.db

setopt GLOB_DOTS

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# try-rs integration
source '/home/aurevelle/.config/try-rs/try-rs.zsh'
