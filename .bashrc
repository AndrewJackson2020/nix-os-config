
# Source global definitions

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="$HOME/bin:$PATH"
fi

export PATH="$HOME/.local/go/bin::$PATH"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# alias ls='eza'
alias vim='nvim'
alias vi='nvim'

if [ "${TERM}" == 'alacritty' ]; then
    zsh
fi
