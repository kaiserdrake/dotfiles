#!/bin/bash

packageList=(
    tree
    stow
    xclip
    fzf
    ripgrep
    fd-find
    picocom
    build-essential
    curl
    bash-completion
    libfuse2
    nfs-common
    luarocks
    zoxide
    todotxt-cli
)

install()
{
    # Install common development tools
    # Refrain from installing all tools natively to the host,
    # consider creating build-environment containers
    for i in "${packageList[@]}"; do
        echo "Installing '$i'..."
        sudo apt-get install --yes $i > /dev/null
    done
}

uninstall()
{
    for i in "${packageList[@]}"; do
        echo "Removing '$i'..."
        sudo apt-get remove --yes $i > /dev/null
    done
}

if [ "$1" = "uninstall" ]; then
    uninstall
else
    install
fi
