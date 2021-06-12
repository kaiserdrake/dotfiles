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
    . $DEFAULT_FILESTORE_PATH/profiles/shell/profile.docker.sh
elif [ -f $DEFAULT_FILESTORE_PATH/profiles/shell/profile.$OSTYPE.sh ]; then
    . $DEFAULT_FILESTORE_PATH/profiles/shell/profile.$OSTYPE.sh
fi
