# Be carefull not to overload bash with custom functions since these are
# loaded upon initialization. When on-demand or lazy loading can already
# be supported by bash, then this restriction can be lifted.

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
    history | sed  's .\{7\}  ' | sed '/do-command/d;/doco/d;/ls/d;/cd */d;/rm/d;/exit/d;/pwd/d;/clear/d;/history */d'
}

# Command list generator using "commands.md" as source.
# This parses multiline commands and joins them into single entry.
# It is intended to work in markdown files where it tgnores lines starting with
# either # or ```.
function get-stored-command-lines(){
    if [ -f "$1" ]; then
        sed '/#+BEGIN_SRC bash/{n;:l N;/#+END_SRC/b; s/\\\n//; s/\n//; bl}' $1 | sed -n '/#+BEGIN_SRC bash/,/#+END_SRC/{//!p}'
    fi
}

# Output the ROM and RAM Data Size of a particular object file.
function get-code-size(){
    output=$(size -t $1 | grep "TOTALS")
    echo "--------------------------------------------------------------------------------"
    echo "ROM Code + Data : `echo ${output} | awk '{print $1}'` bytes"
    echo "RAM Data : `echo ${output} | awk '{print $2+$3}'` bytes"
}

# Command list aggregator.
# Uses fuzzy search to allow searching of commamnds list.
# Sample usage: ARGS="file1 file2" DRYRUN=echo do-command "command"
function do-command(){
    unset MY_FIND_COMMAND
    if [[ -z "${CTX}" ]]; then
        COMFILE="$FILESTORE_PATH/orgs/commands.org"
    else
        COMFILE="$HOME/WORKSPACE/${CTX}/DEVNOTES.org"
    fi
    if [ -z "$1" ]; then
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf`
    else
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf -q "$1" -1 -0`
    fi
    # Replace all positional parameters in found command with the parameters
    # passed to this function
    args=(`echo ${ARGS}`)
    for ((i=0; i<${#args[@]}; i++)) do
        pattern="\$"$(($i+1))
        MY_FIND_COMMAND=${MY_FIND_COMMAND/$pattern/${args[$i]}}
    done
    if [[ ! -z "$MY_FIND_COMMAND" ]]; then
        if [[ -z $DRYRUN ]]; then
            echo "---------------------------------------------------------------------"
            echo $MY_FIND_COMMAND
            echo "---------------------------------------------------------------------"
            if [[ -z "$ZSH_VERSION" ]]; then
                read -p "Press any key to continue"
            else
                echo "Press any key to continue"; read -k1 -s
            fi
            eval $MY_FIND_COMMAND
        else
            ${DRYRUN} $MY_FIND_COMMAND
        fi
    fi
}

# Alias to shorten call to do-command
# "doco" shortened "do"-"co"mmand and a wordplay for the Japanese "doko"
alias doco='do-command'

# Function [wrapper] to generate random name ala docker
function generate-name(){
    if [ -x /usr/bin/python3 ]; then
        echo `/usr/bin/python3 ~/.config/python3/names.generate.py`
    fi
}

# docker run
function docker-run(){
    unset DOCKOPTS IMAGENAME COMMANDS DOCKHOST ABODE
    # Identify image name through selection from the list of images returned by
    # 'docker image ls' command.
    if [ -z "$1" ]; then
        IMAGENAME=`docker image list | awk '{if(NR>1)print}'| fzf | awk '{printf "%s:%s\n",$1,$2}'`
    else
        IMAGENAME=`docker image list | awk '{if(NR>1)print}'| fzf -q $1 -1 -0 | awk '{printf "%s:%s\n",$1,$2}'`
    fi

    # Remote registry images results to empty IMAGENAME, user probably pressed
    # <Esc> during the selection. This means a new image from remote registry.
    # In such case, use the value initially provided by the user.
    if [ -z "$IMAGENAME" ]; then
        # revert value to original argument
        IMAGENAME=$1
    fi

    # Fetch run command configuration through the docker_context.org file.
    COMFILE="$FILESTORE_PATH/orgs/docker_contexts.org"
    if [ -f "$COMFILE" ] && [ -n "$CTX" ]; then
        ABODE=`get-stored-command-lines $COMFILE | grep $CTX | fzf --prompt=Context: --header "CTXID | NETHOST | OPTIONS | COMMAND" -1 -0`
    fi
    # Found a corresponding configuration, tokenize it and set to approriate variables.
    if [ -n "$ABODE" ]; then
        ABODE=$(echo $ABODE | tr -s " ")
        OLDIFS=$IFS
        IFS='|'
        tokens=($ABODE)
        IFS=$OLDIFS
        DOCKHOST=$(echo ${tokens[0]} | tr -s " ")
        NETHOST=$(echo ${tokens[1]} | tr -s " ")
        DOCKOPTS=${tokens[2]}
        COMMANDS=${tokens[3]}
    fi

    # Append run configuration from docker_mapping.md and default.
    DOCKOPTS=$(echo "$DOCKER_DEFOPTIONS $DOCKER_USEROPTIONS $DOCKOPTS" | tr -s " ")
    if [ -z "$COMMANDS" ]; then
        COMMANDS=$(echo "$DOCKER_DEFCOMMAND")
    fi

    if [ "$NETHOST" = "0" ]; then
        # do not use HOSTOPTIONS
        if [ -n "$DOCKHOST" ]; then
            DOCKOPTS=$(echo "$DOCKOPTS -h $DOCKHOST -e DOCK_IMAGE_NAME=$IMAGENAME")
        else
            DOCKOPTS=$(echo "$DOCKOPTS -e DOCK_IMAGE_NAME=$IMAGENAME")
        fi
    else
        # set DOCK_IMAGE_NAME (used in PS1 identifier) same as image name
        DOCKOPTS=$(echo "$DOCKER_HOSTOPTIONS $DOCKOPTS -e DOCK_IMAGE_NAME=$IMAGENAME")
    fi

    DOCKOPTS=$(echo "$DOCKER_OPTIONS $DOCKOPTS -w `pwd` $EXTRAOPTS")
    ${DRYRUN} eval docker run $DOCKOPTS $IMAGENAME $COMMANDS
}

# docker exec
function docker-exec(){
    unset CONTAINERHASH
    # Identify container hash through selection from the list of containers
    # returned by 'docker container ls' command.
    if [ -z "$1" ]; then
        CONTAINERHASH=`docker container list | awk '{if(NR>1)print}'| fzf | awk '{printf "%s\n",$1}'`
    else
        CONTAINERHASH=`docker container list | awk '{if(NR>1)print}'| fzf -q $1 -1 -0 | awk '{printf "%s\n",$1}'`
    fi

    # Container search results to empty IMAGENAME, user probably pressed
    # <Esc> during the selection.
    # In such case, use the value initially provided by the user.
    if [ -z "$CONTAINERHASH" ]; then
        # revert value to original argument
        CONTAINERHASH=$1
    fi
    ${DRYRUN} eval docker exec -it $CONTAINERHASH $DOCKER_DEFCOMMAND
}

# docker create custom environment
function docker-devenv(){
    unset IMAGENAME BUILD_LABEL BASE_TAG TAG_APPEND USER_CREATE
    # Fetch target docker image to customize
    IMAGENAME=$(docker image list | awk '{if(NR>1)print}'| fzf --prompt="Base Image:" -0)
    BUILD_LABEL=$(echo $IMAGENAME | awk '{print $1}')
    BASE_TAG=$(echo $IMAGENAME | awk '{print $2}')
    echo "Base Image: ${BUILD_LABEL}":"${BASE_TAG}"
    read -k TAG_APPEND?"Prepend user to tag? [y/N]? " && echo
    [[ "${(U)TAG_APPEND}" == "Y" ]] && RESTAG=${USER}-${BASE_TAG} || RESTAG=${BASE_TAG}
    read -k USER_CREATE?"Create new user? [y/N]? " && echo
    [[ "${(U)USER_CREATE}" == "Y" ]] && read -s DEV_ENV_PWD\?"Password: "|| echo "Skipping new user creation..."
    ${DRYRUN} eval DOCKER_BUILDKIT=1 docker build \
    --build-arg DEV_ENV_USR=${USER} \
    --build-arg DEV_ENV_PWD=${DEV_ENV_PWD} \
    --build-arg DEV_ENV_UID=${UID} \
    --build-arg DEV_ENV_GID=${GID} \
    --build-arg FROMIMAGE=${BUILD_LABEL} \
    --build-arg TAG=${BASE_TAG} \
    --build-arg USER_CREATE=${(U)USER_CREATE} \
    -f ${FILESTORE_PATH}/dockerfiles/Dockerfile.devenv \
    --network host \
    --ssh default -t ${BUILD_LABEL}:${RESTAG} .
    unset DEV_ENV_PWD
}

# docker attach
function docker-image-command(){
    unset IMAGENAME IAMGE_LABEL IMAGE_TAG
    # Fetch target docker image to customize
    if [ -z "$2" ]; then
        IMAGENAME=$(docker image list | awk '{if(NR>1)print}'| fzf --prompt="Image:" -0)
    else
        IMAGENAME=$(docker image list | awk '{if(NR>1)print}'| fzf --prompt="Image:" -q $2 -0)
    fi

    if [ -n "$IMAGENAME" ]; then
        IMAGE_LABEL=$(echo "$IMAGENAME" | awk '{print $1}')
        IMAGE_TAG=$(echo "$IMAGENAME" | awk '{print $2}')
        ${DRYRUN} eval docker "$1" "$IMAGE_LABEL":"$IMAGE_TAG"
    fi
}

# docker command alias
function dockercl(){
    if [ -n "$1" ]; then
        if [ "$1" = "devenv" ]; then
            docker-devenv "$2"
        elif [ "$1" = "run" ]; then
            docker-run "$2"
        elif [ "$1" = "exec" ]; then
            docker-exec "$2"
        elif [ "$1" = "attach" ]; then
            docker-attach "$2"
        else
            docker-image-command "$@"
        fi;
    fi;
}
