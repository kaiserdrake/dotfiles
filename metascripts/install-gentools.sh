packageList=(
  tmux
  trash-cli
  tree
  stow
  xclip
  fzf
  ripgrep
  universal-ctags
)

preconfigure()
{
  # Set default shell to bash
  echo "Setting default shell to 'bash'..."
  echo dash dash/sh boolean false | sudo debconf-set-selections
  sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

  echo "Updating package library..."
  sudo apt-get --yes update > /dev/null
  sudo DEBIAN_FRONTEND=noninteractive apt-get --yes upgrade > /dev/null
}

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

if [ "$1" == "uninstall" ]; then
  uninstall
else
  preconfigure
  install
fi

