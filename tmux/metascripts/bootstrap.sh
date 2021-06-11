# dotfiles boostrap
SRCLOC=`dirname $0`

# create symbolic link
load_symlink()
{
  pushd $SRCLOC/../ > /dev/null
  for f in *; do
    # loop through all directories
    if [[ -d "$f" && ! -L "$f" ]]; then
      # skip metascripts
      if [ "$f" == "metascripts" ]; then
        continue
      fi
      echo "Linking $f..."
      stow $f
    fi
  done
  popd > /dev/null
}

unload_symlink()
{
  pushd $SRCLOC/../ > /dev/null
  for f in *; do
    # loop through all directories
    if [[ -d "$f" && ! -L "$f" ]]; then
      # skip metascripts
      if [ "$f" == "metascripts" ]; then
        continue
      fi
      echo "Removing link for $f..."
      stow -D $f > /dev/null 2>1
    fi
  done
  popd > /dev/null
}


if [ "$1" == "uninstall" ]; then
  sh $SRCLOC/install-gentools.sh uninstall
  sh $SRCLOC/install-nvim.sh uninstall
  unload_symlink
else
  sh $SRCLOC/install-gentools.sh
  sh $SRCLOC/install-nvim.sh nightly
  load_symlink
fi

