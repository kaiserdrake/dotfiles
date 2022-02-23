# neovim installation
# requires version >= 5.0

packageList=(
    neovim
    universal-ctags
    clangd
    python3-pip
    npm
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

install()
{
    # Add neovim PPA
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt-get update

    for i in "${packageList[@]}"; do
        echo "Installing '$i'..."
        sudo apt-get install --yes $i > /dev/null
    done
    # Install python3 pip modules
    for i in "${pipModules[@]}"; do
        echo "Installing '$i'..."
        yes | pip3 install $i 2> /dev/null
    done
    # install npm modules
    for i in "${npmModules[@]}"; do
        echo "Installing '$i'..."
        sudo npm i -g --silent $i 2> /dev/null
    done

    # Install plugins
    ln -nfs ~/.dotfiles/artifacts/nvim-lua/custom ~/.config/nvim/lua/custom
    nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
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
else
    install
fi
