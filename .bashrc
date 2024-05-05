
export EDITOR="nvim"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.config/emacs/bin/
export PATH="$HOME/.local/go/bin::$PATH"

FZF_CTRL_T_COMMAND= FZF_ALT_C_COMMAND= eval "$(fzf --bash)"
 
alias rm='rm -i'
alias ls='eza'
alias vim='nvim'
alias vi='nvim'

if [ "${TERM}" == 'alacritty' ]; then
    zsh
fi
