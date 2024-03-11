# dotfiles boostrap
SRCLOC=`dirname $0`

preconfigure()
{
    # Set default shell to bash
    echo "Setting default shell to 'bash'..."
    echo dash dash/sh boolean false | sudo debconf-set-selections
    sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

    echo "Backing-up and deleting .bashrc..."
    mv ~/.bashrc ~/.bashrc_bk

    echo "Updating package library..."
    sudo apt-get --yes update > /dev/null
    sudo DEBIAN_FRONTEND=noninteractive apt-get --yes upgrade > /dev/null

    echo "Updating submodule configs..."
    pushd $SRCLOC/../ > /dev/null
    git submodule update --init --recursive
    popd > /dev/null
}

# create symbolic link
load_symlink()
{
    pushd $SRCLOC/../ > /dev/null
    for f in *; do
        # loop through all directories
        if [[ -d "$f" && ! -L "$f" ]]; then
            # skip metascripts
            if [[ "$f" = "metascripts" || "$f" = "not_linked_dir" ]]; then
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
            if [ "$f" = "metascripts" ]; then
                continue
            fi
            echo "Removing link for $f..."
            stow -D $f > /dev/null 2>&1
        fi
    done
    popd > /dev/null
}

if [ "$1" = "uninstall" ]; then
    preconfigure
    unalias rm mv vim 2>dev/null
    sh $SRCLOC/install-zsh.sh uninstall
    sh $SRCLOC/install-nvim.sh uninstall
    unload_symlink
    sh $SRCLOC/install-gentools.sh uninstall
elif [ "$1" = "unsymlink" ]; then
    unload_symlink
elif [ "$1" = "symlink" ]; then
    load_symlink
elif [ "$1" = "nvim" ]; then
    sh $SRCLOC/install-nvim.sh
else
    preconfigure
    sh $SRCLOC/install-gentools.sh
    load_symlink
    sh $SRCLOC/install-zsh.sh
fi
