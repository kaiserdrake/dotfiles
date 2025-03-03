# Be carefull not to overload bash with custom functions since these are
# loaded upon initialization.

# Lazy loading
# reference: https://gist.github.com/QinMing/364774610afc0e06cc223b467abe83c0
# $1: space separated list of alias to release after the first load
# $2: file to source
# $3: name of the command to run after it's loaded
# $4+: argv to be passed to $3
function lazy_load(){
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

# Batch lazy load
function group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

group_lazy_load $HOME/.config/shell/preload/common_preload.sh \
    within_docker \
    get-history-lines \
    get-stored-command-lines \
    do-command

group_lazy_load $HOME/.config/shell/preload/docker_preload.sh \
    docker-run \
    docker-exec \
    docker-devenv \
    docker-image-command \
    dockercl

unset -f group_lazy_load


# Alias to shorten call to do-command
# "doco" shortened "do"-"co"mmand and a wordplay for the Japanese "doko"
alias doco='do-command'
