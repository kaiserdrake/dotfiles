#!/bin/bash

packageList=(
    tmux
)

install()
{
    # Install tmux related applications and libraries
    for i in "${packageList[@]}"; do
        echo "Installing '$i'..."
        sudo apt-get install --yes $i > /dev/null
    done
    # Install TPM
    if [ ! -d '~/.tmux/plugins/tpm' ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

}

uninstall()
{
    for i in "${packageList[@]}"; do
        echo "Removing '$i'..."
        sudo apt-get remove --yes $i > /dev/null
    done
    rm -rf ~/.tmux/plugins/tpm
}

if [ "$1" = "uninstall" ]; then
    uninstall
else
    install
fi
