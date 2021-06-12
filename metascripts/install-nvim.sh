# neovim installation
# requires version >= 5.0

NVIMTARGET=${HOME}/.bin

nvimLatest=https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
nvimNightly=https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

packageList=(
  universal-ctags
  clangd
  python3-pip
  npm
)

pipModules=(
  compiledb
  pynvim
  python-language-server[all]
)

npmModules=(
  bash-language-server
  dockerfile-language-server-nodejs
)

install()
{
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

  mkdir -p ${NVIMTARGET}
  pushd $NVIMTARGET > /dev/null
  rm nvim.appimage
  curl -LO $1
  chmod u+x nvim.appimage
  popd > /dev/null
}

uninstall()
{
  echo "Removing neovim binary..."
  rm -rf ${NVIMTARGET}/nvim.appimage

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

if [ "$1" == "uninstall" ]; then
  uninstall
elif [ "$1" == "nightly" ]; then
  echo "Downloading neovim nightly release..."
  install $nvimNightly
else
  echo "Downloading neovim latest stable release..."
  install $nvimLatest
fi

