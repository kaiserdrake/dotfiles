# Check function if execution context is within a docker container
function within_docker() {
    [[ ! -z "${DOCK_IMAGE_NAME}" ]] || (awk -F/ '$2 == "docker"' /proc/self/cgroup | read dummy)
}

# Command list generator using 'history' as source.
# It truncates the first 7 characters in each line.
# Thus adding timestamp via HISTTIMEFORMAT in the history entry requires
# change of the offset where the actual command starts.
# This is not done automatically in the function.
function get-history-lines(){
    history | \
        sed  's .\{7\}  ' | \
        sed '/do-command/d;/doco/d;/ls/d;/cd */d;/rm/d;/exit/d;/pwd/d;/clear/d;/history */d'
}

# Command list generator using "commands.md" as source.
# This parses multiline commands and joins them into single entry.
# It is intended to work in markdown files where it tgnores lines starting with
# either # or ```.
function get-stored-command-lines(){
    if [ -f "$1" ] && [ "${1: -4}" == ".org" ]; then
        sed '/#+BEGIN_SRC bash/{n;:l N;/#+END_SRC/b; s/\\\n//; s/\n//; bl}' $1 | \
            sed -n '/#+BEGIN_SRC bash/,/#+END_SRC/{//!p}' \
            sed 's/^[[:space:]]*//'

    fi
    if [ -f "$1" ] && [ "${1: -3}" == ".md" ]; then
        sed '/```/{n;:l N;/```/b; s/\\\n//; s/\n//; bl}' $1 | \
            sed -n '/```bash/,/```/{//!p}' | \
            sed 's/^[[:space:]]*//'
    fi
}

# Prompt to press any key except ESC
function prompt_anykey_else_esc() {
    local key
    echo -n "Press any key to continue..."
    read -k1 key # Read a single keypress

    # Check if the key is ESC (ASCII 27)
    if [[ $key == $'\e' ]]; then
        return -1
    fi
    return 0
}

# Command list aggregator.
# Uses fuzzy search to allow searching of commamnds list.
# Sample usage: ARGS="file1 file2" DRYRUN=echo do-command "command"
function do-command(){
    unset MY_FIND_COMMAND
    if [[ -z "${CTX}" ]]; then
        if [[ -z "${DOCOFILE}" ]]; then
            COMFILE="$FILESTORE_PATH/notes/commands.md"
        else
            COMFILE="$DOCOFILE"
        fi
    else
        COMFILE="$HOME/WORKSPACE/${CTX}/DEVNOTES.org"
    fi
    if [ -z "$1" ]; then
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf`
    else
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf -q "$1" -1 -0`
    fi

    if [[ -z "$MY_FIND_COMMAND" ]]; then
        return 0
    fi
    # Append arguments pass to the function to this function,
    # first shift the arguments list to skip first argument
    shift 1
    for arg in "$@"; do
        MY_FIND_COMMAND="$MY_FIND_COMMAND $arg"
    done
    # Replace all positional parameters in found command with the parameters
    # passed to this function
    args=(`echo ${ARGS}`)
    for ((i=0; i<${#args[@]}; i++)) do
        pattern="\$"$(($i+1))
        MY_FIND_COMMAND=${MY_FIND_COMMAND/$pattern/${args[$i]}}
    done

    if [[ ! -z "$MY_FIND_COMMAND" ]]; then
        echo "---------------------------------------------------------------------"
        echo $MY_FIND_COMMAND
        echo "---------------------------------------------------------------------"
        if prompt_anykey_else_esc; then
            eval $MY_FIND_COMMAND
        fi
    fi
}
