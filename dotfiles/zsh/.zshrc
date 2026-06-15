# Created by newuser for 5.9.1

# --- Better Completion ---
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- Colours ---
autoload -U colors && colors

# --- Custom Two-Line Prompt ---
# Line 1: Time, Date, and Absolute Directory Path
# Line 2: Dynamic User Identity & Input Cursor
PROMPT='
%F{#f9e2af} %D{%H:%M:%S}%f %F{#6c7086}│%f %F{#a6e3a1}%D{%a, %b %d}%f  %F{#89b4fa} %~%f
%F{#cba6f7} %n%f ❯ '

# Clear the old right-side prompt
RPROMPT=''

# --- Keybindings ---
bindkey '^[[3~' delete-char
bindkey '^[[3;5~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt inc_append_history
setopt share_history

# --- Aliases ---
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

# --- Environment ---
export EDITOR=nvim
export VISUAL=nvim
