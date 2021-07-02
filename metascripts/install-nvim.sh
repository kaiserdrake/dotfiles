# neovim installation
# requires version >= 5.0

NVIMTARGET=${HOME}/.bin

nvimLatest=https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
nvimNightly=https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

install()
{
  mkdir -p ${NVIMTARGET}
  pushd $NVIMTARGET
  curl -LO $1
  chmod u+x nvim.appimage
  popd
}

uninstall()
{
  echo "Removing neovim binary..."
  rm -rf ${NVIMTARGET}/nvim.appimage
}

if [ "$1" == "uninstall" ]; then
  uninstall
elif [ "$1" == "nightly" ]; then
  echo "Downloading neovim nightly release..."
  install $nvimNightly > /dev/null
else
  echo "Downloading neovim latest stable release..."
  install $nvimLatest > /dev/null
fi

