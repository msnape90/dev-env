#!/usr/bin/env zsh
# FZF configuration and functions

if command -v fzf >/dev/null 2>&1; then
    # Open file in editor with fzf
    vf() {
        local file
        file=$(fzf --preview "bat --color=always {} 2>/dev/null || cat {}") && ${EDITOR:-vim} "$file"
    }

    # Kill process with fzf
    fkill() {
        local pid
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
        if [ "x$pid" != "x" ]; then
            echo "$pid" | xargs kill -${1:-9}
        fi
    }

    # FZF default options
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"

    # Use fd if available for faster searching
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    fi

    # Source fzf key bindings and completion for zsh
    if [ -f /usr/share/fzf/key-bindings.zsh ]; then
        source /usr/share/fzf/key-bindings.zsh
    fi

    if [ -f /usr/share/fzf/completion.zsh ]; then
        source /usr/share/fzf/completion.zsh
    fi

    # Alternative paths for fzf
    if [ -f ~/.fzf.zsh ]; then
        source ~/.fzf.zsh
    fi

    # Debian/Ubuntu specific path
    if [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
    fi

    if [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
        source /usr/share/doc/fzf/examples/completion.zsh
    fi
fi
