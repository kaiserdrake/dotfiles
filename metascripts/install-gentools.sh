#!/bin/bash

packageList=(
    tree
    stow
    xauth
    xclip
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

install_apt()
{
    # Install common development tools
    # Refrain from installing all tools natively to the host,
    # consider creating build-environment containers
    for i in "${packageList[@]}"; do
        echo "Installing '$i'..."
        sudo apt-get install --yes $i > /dev/null
    done
}

install_fzf()
{
    # Install fzf from source
    echo "Download fzf binary release..."
    mkdir -p ~/.bin
    # release: v0.60.3
    BIN_URL=https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-linux_amd64.tar.gz
    wget $BIN_URL -P ~/.bin --quiet
    tar zxvf ~/.bin/$(basename $BIN_URL) -C ~/.bin/
    chmod u+x ~/.bin/fzf
    rm ~/.bin/$(basename $BIN_URL)
    sudo ln -sf ~/.bin/fzf /usr/bin/fzf
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
    install_apt
    install_fzf
fi
