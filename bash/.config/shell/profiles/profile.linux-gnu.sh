# -----------------------------------------------------------------------------
# Global exports
# -----------------------------------------------------------------------------
# As much as possible place exports here since usual guides and tips uses appends of exports
# at the end of this file. The intention is previous exports made by this file should be
# overwritten in those cases.
# path additions

# extend path
export PATH=$PATH:~/.local/bin

# gtags
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
# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ls='ls --color=always'                          # file listing
alias ssh='TERM=xterm-256color ssh'                   # ssh to use xterm
alias pbcopy="xclip -selection c"                     # put into clipboard
alias pbpaste="xclip -selection clipboard -o"         # get from clipboard

# Apply host specific overrides from this section.
# This is useful when the configuration is used in multiple machines with
# subtle changes  (e.g. PRIMARY_WORKSPACE location difference).
HOSTN=`echo $HOSTNAME | awk '{print tolower($0)}'`
case $HOSTN in
    alfheim)
        # fallthrough
        ;&
    niflheim)
        # fallthrough
        ;&
    vanaheim)
        # fallthrough
        ;&
    muspelheim)
        # fallthrough
        ;&
    midgard)
        alias nvim="~/.bin/nvim.appimage"             # nvim from appimage
        alias vim='nvim'                              # use neovim
        alias vimdiff='nvim -d'                       # use neovim also for vimdiff

        export PRIMARY_WORKSPACE=$HOME/WORKSPACE
        export FILESTORE_PATH=$HOME/.filestore
        export DOCKER_HOSTOPTIONS="-h $HOSTN --network host"
        ;;
    *)
        # default for unknown clients
        export PRIMARY_WORKSPACE=$HOME/WORKSPACE
        export FILESTORE_PATH=$HOME/.filestore
        export DOCKER_HOSTOPTIONS="-h $HOSTN --network host"
        ;;
esac

# Docker run default option - mandatory configuration items for all images.
export DOCKER_USEROPTIONS=" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:/home/${USER} \
    "

export DOCKER_DEFOPTIONS="-it \
    --privileged \
    -e DISPLAY=${DISPLAY} \
    -e TERM=xterm-256color \
    -e TZ=Asia/Tokyo \
    -v /mnt:/mnt \
    -v /media/${USER}:/media/${USER} \
    -v /var/lib/lxc:/var/lib/lxc
    "

export DOCKER_DEFCOMMAND="/bin/zsh"

# -----------------------------------------------------------------------------
# X11 forwarding
# -----------------------------------------------------------------------------
# Set X11 server windows application keyboard layout
# When unders WSL and using X410 x11 server, default keyboard layout is US
KERNEL_RELEASE=$(cat /proc/sys/kernel/osrelease | sed -n 's/.*\( *Microsoft *\).*/\L\1/ip')
if [ "$KERNEL_RELEASE" = "microsoft" ]; then
    # WSL2 runs virtualization where linux kernel runs on different network
    # thus use of localhost is different
    [ -z $DISPLAY ] && export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

    # Perform after setting DISPLAY value
    # set keyboard layout
    # if [ -f /usr/bin/setxkbmap ]; then
    #     /usr/bin/setxkbmap jp
    # fi
else
    # Set display for X11 forwarding
    [ -z $DISPLAY ] && DISPLAY=:0 && export DISPLAY
fi
