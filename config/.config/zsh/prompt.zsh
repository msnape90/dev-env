#!/usr/bin/env zsh
# Prompt configuration

# Color definitions
RED='%F{red}'
GREEN='%F{green}'
YELLOW='%F{yellow}'
BLUE='%F{blue}'
MAGENTA='%F{magenta}'
CYAN='%F{cyan}'
WHITE='%F{white}'
GRAY='%F{240}'
ENDC='%f'

# Git prompt helpers
_prompt_git() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch dirty
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return

    # Fast dirtiness check
    if [[ -n "$(git status --porcelain --ignore-submodules=dirty -uno 2>/dev/null | head -n 1)" ]]; then
        dirty='*'
    else
        dirty=''
    fi

    print -r -- " (${branch}${dirty})"
}

# Build PROMPT each command so we can show last exit status
_prompt_update() {
    local exit_code=$?
    local status_color status_icon

    if [[ $exit_code -eq 0 ]]; then
        status_color=${GREEN}
        status_icon='✔'
    else
        status_color=${RED}
        status_icon="✘ $exit_code"
    fi

    local ssh_message
    if [[ -n "$SSH_CLIENT" ]]; then
        ssh_message=" ${RED}[ssh]${ENDC}"
    else
        ssh_message=''
    fi

    PROMPT="${GREEN}%n${ssh_message} ${WHITE}at ${YELLOW}%M ${WHITE}in ${BLUE}%~${CYAN}\$(_prompt_git)
${status_color}${status_icon} ${CYAN}\$${ENDC} "
}

# Ensure our prompt builder runs first
if (( ${precmd_functions[(I)_prompt_update]} == 0 )); then
    precmd_functions=(_prompt_update ${precmd_functions[@]})
fi

# Display system info once per session
if [[ -o interactive ]] && [[ -z "${_PROMPT_HEADER_SHOWN:-}" ]]; then
    _PROMPT_HEADER_SHOWN=1

    # Detect window manager
    _wm="${XDG_CURRENT_DESKTOP:-${DESKTOP_SESSION:-}}"
    if [[ -z "$_wm" ]]; then
        for _w in i3 sway openbox bspwm xfwm4 kwin mutter herbstluftwm qtile; do
            pgrep -x "$_w" &>/dev/null && _wm="$_w" && break
        done
    fi
    _wm="${_wm:-unknown}"

    _os=$(grep '^NAME' /etc/os-release 2>/dev/null | cut -d'"' -f2)
    _os_id=$(grep '^ID=' /etc/os-release 2>/dev/null | cut -d'=' -f2)
    case "${_os_id}" in
        debian)   _os_icon=$'\uf306' ;;
        ubuntu)   _os_icon=$'\uf31b' ;;
        arch)     _os_icon=$'\uf303' ;;
        fedora)   _os_icon=$'\uf30a' ;;
        manjaro)  _os_icon=$'\uf312' ;;
        *)        _os_icon=$'\u2699' ;;
    esac
    _kernel=$(uname -r)
    _kernel_short=$(echo "${_kernel}" | awk -F'[.-]' '{print ($1 && $2 && $3) ? $1"."$2"."$3 : ($1 && $2) ? $1"."$2 : $1}')
    _shell_name="${SHELL##*/}"
    _shell_name="${_shell_name:-zsh}"
    _shell_ver="${ZSH_VERSION:-unknown}"
    printf "  \e[38;5;244m─ \e[38;5;199m%s \e[1;37m${_os:-Debian}\e[0m \e[38;5;244m·\e[0m \e[36m${_kernel_short}\e[0m \e[38;5;244m·\e[0m \e[33m${_wm}\e[0m \e[38;5;244m·\e[0m \e[35m${_shell_name} ${_shell_ver}\e[0m \e[38;5;244m─\e[0m\n\n" "${_os_icon}"
fi
