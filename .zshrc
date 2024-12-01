
# Enable colors and change prompt:


export EDITOR="nvim"
export VISUAL="nvim"


#colors 38;5;27
autoload -U colors && colors
eval "$(starship init zsh)"
# source "$HOME/.config/zsh/git-prompt.zsh/git-prompt.zsh"
#PROMPT='%B%m%~%b$(git_super_status) %# '
# PS1='%B{%F{033}%n%F{7}}{%F{130}%~%F{7}}%b: '
#PROMPT='%B⊸{%F{033}%n%F{7}}{%F{130}%~%F{7}}%b: '
# RPROMPT='$(gitprompt)'
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY # emedietly append history
export HISTTIMEFORMAT="[%F %T] "
HISTFILE=~/.cache/zsh/history
setopt HIST_FIND_NO_DUPS # remove duplicet history
setopt HIST_IGNORE_ALL_DUPS


# ctr r history search
bindkey -v
bindkey '^R' history-incremental-search-backward

source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh


export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
# lfcd () {
#    tmp="$(mktemp)"
#    lf -last-dir-path="$tmp" "$@"
#    if [ -f "$tmp" ]; then
#        dir="$(cat "$tmp")"
#        rm -f "$tmp"
#        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#    fi
#}
# bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# source "$HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# aliases
alias ls="ls --color"

alias python="/Applications/Python3.12/IDLE.app"

alias pifs="sshfs -o default_permissions pi@10.0.0.84:/home/pi ~/bus/pi/"

alias tmuxs="tmux source ~/.config/tmux/tmux.conf"

alias ls="exa -h --git -l --group-directories-first"
alias ll="exa -lah --git --group-directories-first"
alias lsf="exa -lah --git --group-directories-first --reverse"

alias s="source $HOME/.zshrc"

alias perf="/usr/lib/linux-tools/5.4.0-148-generic/perf"

alias acli="/mnt/c/Users/jonas/arduino-cli.exe"

alias store="git -C ~/dotfiles_3/ add . && git -C ~/dotfiles_3/ commit -m 'commit using store' && git -C ~/dotfiles_3/ push"

function help () {
  "$1" --help | awk 'NF' | fzf --preview="$1 --help | rg --color always --context 8 -F {}"
}

alias fzh="cat $HISTFILE | fzf"
alias fd="cd ~ && cd \$(find * -type d | fzf)"
alias fzc="compgen -A function -abck | fzf"

# export go path
export PATH=$PATH:/usr/local/go/bin

# export bin path for homebrew
export PATH=$PATH:/opt/homebrew/bin/


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# zoxide
eval "$(zoxide init zsh)"

# go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:/home/prop/.local/share/bob/nvim-bin:$PATH"
export PERF="/usr/lib/linux-tools/5.4.0-148-generic/perf"

# zellij setup
# eval "$(zellij setup --generate-auto-start zsh)"

# sheldon plugin manager
eval "$(sheldon source)"

# Wasmer
export WASMER_DIR="/home/prop/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
export PATH=$PATH:/Users/jonas/code/wabt/out/clang/Debug
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:/usr/local/bin

. "$HOME/.cargo/env"
