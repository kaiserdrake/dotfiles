#!/bin/bash
onedark_black="#282c34"
onedark_blue="#61afef"
onedark_yellow="#e5c07b"
onedark_red="#e06c75"
onedark_white="#aab2bf"
onedark_green="#98c379"
onedark_purple="#c678dd"
onedark_visual_grey="#282c34"
onedark_comment_grey="#5c6370"

set() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

setw() {
    local option=$1
    local value=$2
    tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$onedark_white"
set "message-bg" "$onedark_black"

set "message-command-fg" "$onedark_white"
set "message-command-bg" "$onedark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$onedark_black"
setw "window-status-bg" "$onedark_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$onedark_black"
setw "window-status-activity-fg" "$onedark_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$onedark_comment_grey"
set "window-active-style" "fg=$onedark_white"

set "pane-border-fg" "$onedark_white"
set "pane-border-bg" "$onedark_black"
set "pane-active-border-fg" "$onedark_green"
set "pane-active-border-bg" "$onedark_black"

set "display-panes-active-colour" "$onedark_yellow"
set "display-panes-colour" "$onedark_blue"

set "status-bg" "$onedark_visual_grey"
set "status-fg" "$onedark_white"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_green"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_green"
set "@prefix_highlight_output_prefix" " > "

if [ ! -z "$VIM_TERMINAL" ]; then
    set "status-right" \
        "#[fg=$onedark_blue, bg=$onedark_visual_grey] #{?window_zoomed_flag, zoomed,} \
        #[fg=$onedark_red,bg=$onedark_visual_grey,nobold] VIMTERM \
        #[fg=$onedark_yellow, bg=$onedark_visual_grey]  $(basename $SHELL) #[fg=$onedark_black,bg=$onedark_purple,bold] #h "
elif [ ! -z "$META_IMAGEREF" ]; then
    set "status-right" \
        "#[fg=$onedark_blue, bg=$onedark_visual_grey] #{?window_zoomed_flag, zoomed,} \
         #[fg=$onedark_yellow, bg=$onedark_visual_grey]  $(basename $SHELL) #[fg=$onedark_black,bg=$onedark_green] ${META_IMAGEREF##*/} #[fg=$onedark_black,bg=$onedark_purple,bold] #h "
else
    set "status-right" \
        "#[fg=$onedark_blue, bg=$onedark_visual_grey] #{?window_zoomed_flag, zoomed,} \
         #[fg=$onedark_yellow, bg=$onedark_visual_grey]  $(basename $SHELL) #[fg=$onedark_black,bg=$onedark_purple,bold] #h "
fi
set "status-left" "#[fg=$onedark_black,bg=$onedark_green,bold] #S #{prefix_highlight}"
set "window-status-format" "#[fg=$onedark_comment_grey,bg=$onedark_visual_grey,nobold] [#I] #W "
set "window-status-current-format" "#[fg=$onedark_white,bg=$onedark_black,nobold] [#I] #W "
