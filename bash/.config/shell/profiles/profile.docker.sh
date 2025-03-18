
# -----------------------------------------------------------------------------
# Exports
# -----------------------------------------------------------------------------
export PRIMARY_WORKSPACE=$HOME/WORKSPACE
export FILESTORE_PATH=$HOME/.filestore
export PATH=$PATH:~/.local/bin:~/.bin
export GTAGSLABEL=ctags # default gtags tag provider
# fzf/ripgrep
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
# Set editor to vim (bye emacs)
export VISUAL=vim
export EDITOR="$VISUAL"

export DISPLAY=:0

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ls='ls --color=always'           # file listing
alias ssh='TERM=xterm-256color ssh'    # ssh to use xterm
alias nvim='~/.bin/nvim-linux-x86_64.appimage'      # alis neovim appimage
alias vim='nvim'                       # use neovim

alias fzf='~/.bin/fzf'

# When using Docker Desktop, containers within WSL2 are not able to access
# to the host docker IP address as described here:https://docs.docker.com/network/
KERNEL_RELEASE=$(cat /proc/sys/kernel/osrelease | sed -n 's/.*\( *Microsoft *\).*/\L\1/ip')
if [ "$KERNEL_RELEASE" = "microsoft" ]; then
    # WSL2 runs virtualization where linux kernel runs on different network
    # thus use of localhost is different
    [ -z $DISPLAY ] && DISPLAY=host.docker.internal:0.0 && export DISPLAY
fi

