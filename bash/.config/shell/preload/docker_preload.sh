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
