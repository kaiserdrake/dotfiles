packageList=(
  tmux
  trash-cli
  tree
  stow
  xclip
  fzf
  ripgrep
  build-essential
  universal-ctags
  clangd
  python3-pip
)

pipModules=(
  compiledb
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
  # Install python3 pip modules
  for i in "${pipModules[@]}"; do
    echo "Installing '$i'..."
    yes | pip install $i
  done
}

uninstall()
{
  for i in "${pipModules[@]}"; do
    echo "Removing '$i'..."
    pip uninstall --yes $i > /dev/null
  done
  for i in "${packageList[@]}"; do
    echo "Removing '$i'..."
    sudo apt-get remove --yes $i > /dev/null
  done
}

if [ "$1" == "uninstall" ]; then
  uninstall
else
  install
fi

