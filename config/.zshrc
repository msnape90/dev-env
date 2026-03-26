# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'r:|[._-pc]=* r:|=*'
zstyle :compinstall filename '/home/debian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
# End of lines configured by zsh-newuser-install

# paths to set
export PATH=~/.npm-global/bin:$PATH
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.local/scripts

autoload -U +X bashcompinit && bashcompinit

# autocomplete
complete -o nospace -C /usr/bin/terraform terraform

## terminal tool init
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

function run-tmux-sessionizer() {
  zle -I  # Invalidate the current line to clear it
  BUFFER="tmux-sessionizer"  # Set the command in the input buffer
  zle accept-line  # Execute the command
}
zle -N run-tmux-sessionizer
bindkey "" run-tmux-sessionizer

# command aliases
## general
alias cls="clear"

## eza
alias ls="eza -l -g -h"
alias lsa="eza -l -g -h -a"
alias lst="eza -l -g -h -T -L 2"

# terraform
alias tf="terraform"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tff="terraform fmt"
alias tfd="terraform destroy"
alias tfo="terraform output"
alias tfi="terraform init"
alias tfv="terraform validate"
