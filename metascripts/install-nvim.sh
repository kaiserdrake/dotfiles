#!/bin/bash

# neovim installation
# requires version >= 5.0

packageList=(
    universal-ctags
    clangd
    python3
    python3-virtualenv
    python3-pip
    npm
    ninja-build
)

pipModules=(
    compiledb
    pynvim
    python-lsp-server[all]
)

npmModules=(
    bash-language-server
    dockerfile-language-server-nodejs
    yarn
)

download()
{
    # Download neovim via appimage
    echo "Download neovim appimage..."
    mkdir -p ~/.bin
    NVIM_URL=https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-x86_64.appimage
    wget $NVIM_URL -P ~/.bin --quiet
    chmod u+x ~/.bin/nvim-linux-x86_64.appimage
}

install()
{
    download
    for i in "${packageList[@]}"; do
        echo "Installing '$i'..."
        sudo apt-get install --yes $i > /dev/null
    done

    # Install python3 pip modules
    for i in "${pipModules[@]}"; do
        echo "Installing '$i'..."
        yes | pip3 install --break-system-packages $i 2> /dev/null
    done

    # install nodejs
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install stable
    # install npm modules
    for i in "${npmModules[@]}"; do
        echo "Installing '$i'..."
        sudo npm i -g $i 2> /dev/null
    done

    # install sumneko language server
    if [ ! -d "~/.lua/sumneko_lua" ]; then
        mkdir -p ~/.lua
        ( cd ~/.lua; git clone https://github.com/sumneko/lua-language-server sumneko_lua --recursive; )
    fi
    pushd ~/.lua/sumneko_lua > /dev/null
    cd 3rd/luamake
    ./compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild
    popd > /dev/null

    # Install plugins
    rm -rf ~/.local/share/nvim
    ~/.bin/nvim-linux-x86_64.appimage
}

uninstall()
{
    for i in "${npmModules[@]}"; do
        echo "Removing '$i'..."
        sudo npm uninstall -g $i > /dev/null
    done
    for i in "${pipModules[@]}"; do
        echo "Removing '$i'..."
        pip uninstall --yes $i > /dev/null
    done
    for i in "${packageList[@]}"; do
        echo "Removing '$i'..."
        sudo apt-get remove --yes $i > /dev/null
    done
}

if [ "$1" = "uninstall" ]; then
    uninstall
elif [ "$1" = "download" ]; then
    download
else
    install
fi
