#!/usr/bin/env zsh
# Modular .zshrc configuration

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ============================================================================
# ZSH OPTIONS
# ============================================================================

# History options
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history items
setopt INC_APPEND_HISTORY    # Save history entries as soon as they are entered
setopt SHARE_HISTORY         # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_IGNORE_SPACE     # Don't record an entry starting with a space

# Directory options
setopt AUTO_CD               # Type directory name to cd
setopt AUTO_PUSHD            # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS     # Don't push multiple copies of the same directory
setopt PUSHD_SILENT          # Do not print the directory stack after pushd or popd

# Completion options
setopt ALWAYS_TO_END         # Move cursor to end of word after completion
setopt AUTO_MENU             # Show completion menu on successive tab press
setopt COMPLETE_IN_WORD      # Complete from both ends of a word
setopt AUTO_LIST             # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH      # If completed parameter is a directory, add a trailing slash

# Globbing options
setopt EXTENDED_GLOB         # Use extended globbing syntax
setopt NO_CASE_GLOB          # Case insensitive globbing
setopt GLOB_DOTS             # Include dotfiles in globbing

# Other options
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive mode
setopt NO_BEEP               # Don't beep on errors
setopt PROMPT_SUBST          # Enable parameter expansion in prompts

# ============================================================================
# HISTORY CONFIGURATION
# ============================================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# Path configuration
typeset -U path  # Keep unique entries in path
path=($HOME/scripts $HOME/.local/bin /usr/local/go/bin $HOME/.cargo/bin $path)

add_paths_from_file() {
  file=$1

  # if dir is a valid path and isnt already in PATH then add it to path
  add_paths() {
    dirs=$1
    typeset -U path
    for dir in ${dirs[@]}; do
      [[ -d "$dir" && path=("$dir" $path) ]]
    done
  }

  var_expand_file() {
    file=$1
    while IFS= read -r raw; do
      expanded=$(envsubst <<<"$raw")
      echo "$expanded"
    done <"$file"
  }

  PATHS_TO_ADD=$(var_expand_file "$file")
  echo $PATHS_TO_ADD
  # add_paths "$PATHS_TO_ADD"

}

add_paths_from_file "$HOME/.config/shell/common/paths"

unset -f add_paths
unset -f add_paths_from_file

# Default editors
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
elif command -v vim >/dev/null 2>&1; then
    export EDITOR=vim
elif command -v micro >/dev/null 2>&1; then
    export EDITOR=micro
else
    export EDITOR=nano
fi
export VISUAL="$EDITOR"

# Better less defaults
export LESS='-R -F -X -i -P %f (%i/%m) '
export LESSHISTFILE=/dev/null

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Locale - set to en_US.UTF-8 if available, otherwise fall back to C.UTF-8
if locale -a 2>/dev/null | grep -qi "en_US.utf"; then
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
elif locale -a 2>/dev/null | grep -qi "C.UTF"; then
    export LANG=C.UTF-8
    export LC_ALL=C.UTF-8
fi

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================

# Sets the path for newly installed apps to place their zsh auto completions
typeset -gaU fpath=($fpath $HOME/.local/share/zsh/completions)

# Initialize completion system
autoload -Uz compinit

# Speed up compinit by only checking cache once a day
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Completion styling
zstyle ':completion:*' menu select                         # Enable menu selection with arrow keys
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colored completion (match ls colors)
zstyle ':completion:*' group-name ''                       # Group results by category
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}No matches found%f'

# Cache completions for better performance
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"

# ============================================================================
# ZSH PLUGINS
# ============================================================================

# Plugin directory
ZSH_PLUGIN_DIR="/usr/share"

# Load zsh-syntax-highlighting (shows correct/incorrect commands as you type)
if [ -f "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Load zsh-autosuggestions (fish-like autosuggestions from history)
if [ -f "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
    # Accept suggestion with Ctrl+Space or Right Arrow
    bindkey '^ ' autosuggest-accept
fi

# ============================================================================
# LOAD MODULAR CONFIGURATIONS
# ============================================================================

ZSH_CONFIG_DIR="$HOME/.config/shell/zsh"

# Load all zsh configuration files
if [ -d "$ZSH_CONFIG_DIR" ]; then
    # Load main configuration files
    for config in "$ZSH_CONFIG_DIR"/*.zsh(N); do
        [ -f "$config" ] && source "$config"
    done

    # Load function files
    if [ -d "$ZSH_CONFIG_DIR/functions" ]; then
        for func in "$ZSH_CONFIG_DIR/functions"/*.zsh(N); do
            [ -f "$func" ] && source "$func"
        done
    fi

fi

# ============================================================================
# LOCAL OVERRIDES
# ============================================================================

# Source local zshrc if it exists (for machine-specific settings)
if [ -f "$HOME/.zshrc.local" ]; then
    . "$HOME/.zshrc.local"
fi
