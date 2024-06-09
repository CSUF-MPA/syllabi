# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  ubuntu
  zsh-syntax-highlighting
  zsh-autosuggestions
  web-search
  fzf
  history-substring-search
  fzf-tab
  command-not-found
  per-directory-history
  colored-man-pages
)

# Customizations
export HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"
zstyle ':omz:update' mode reminder

source $ZSH/oh-my-zsh.sh

# Environment variables
export DB_USER="postgres"
export DB_PASS="MandyLinkToby3"
export PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Conda initialization
__conda_setup="$('/home/dadams/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dadams/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dadams/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dadams/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias md2docx='pandoc -s -o "${2:-${1%.md}.docx}" "$1" && echo "Converted $1 to ${2:-${1%.md}.docx}"'

# Functions
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1"    ;;
      *.tar.gz)   tar xzf "$1"    ;;
      *.bz2)      bunzip2 "$1"    ;;
      *.rar)      unrar x "$1"    ;;
      *.gz)       gunzip "$1"     ;;
      *.tar)      tar xf "$1"     ;;
      *.tbz2)     tar xjf "$1"    ;;
      *.tgz)      tar xzf "$1"    ;;
      *.zip)      unzip "$1"      ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1"       ;;
      *)          echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# fzf configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-tab configuration
zstyle ':completion:*' completer _complete _fzf_tab
zstyle ':fzf-tab:*' fzf-preview 'bat --style=numbers --color=always --line-range :200 {}'
zstyle ':fzf-tab:*' switch-group ','

# fzf-tab key bindings
zstyle ':fzf-tab:*' fzf-bindings 'tab:down,btab:up'

# fzf options
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --info=inline
  --border
  --pointer="👉"
  --preview="([[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always --line-range :200 {} || cat {}) 2> /dev/null)"
'

# Enable fzf-tab auto-completion window
zmodload zsh/complist

# Key bindings for history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Source the fzf-tab plugin
source ~/.oh-my-zsh/custom/plugins/fzf-tab/fzf-tab.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
