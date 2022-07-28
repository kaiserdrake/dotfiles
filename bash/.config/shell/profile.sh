# -----------------------------------------------------------------------------
# Personal profile
# -----------------------------------------------------------------------------
# Apply OS specific personal profile.
export DEFAULT_FILESTORE_PATH=$HOME/.filestore
export FILESTORE_PATH=$DEFAULT_FILESTORE_PATH

# preload shell functions
if [ -f ~/.config/shell/functions_preload.sh ]; then
    . ~/.config/shell/functions_preload.sh
fi

if within_docker; then
    . ~/.config/shell/profiles/profile.docker.sh
elif [ -f ~/.config/shell/profiles/profile.$OSTYPE.sh ]; then
    . ~/.config/shell/profiles/profile.$OSTYPE.sh
fi

# override with local profile
if [ -f ~/.profile.local ]; then
    . ~/.profile.local
fi
