#!/bin/bash

source $HOME/.config/shell/functions_preload.sh

function rename-window(){
    tmux rename-window `generate-name`
}

$1
