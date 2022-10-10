#!/bin/sh

cd `dirname "$0"`

stack_deploy() {
    stack=${1:-${PWD##*/}} # by default, the name of the cointaining folder
    compose_file=${2:-docker-compose.yml}

    if [ ! -f $compose_file ]; then
        echo "Misses compose file: $compose_file" >&2
        return 1
    fi

    # execute as a subcommand in order to avoid the variables remain set
    (
        # export variables excluding comments
        [ -f .env ] && export $(sed '/^#/d' .env)

        # Use dsd your_stack your_compose_file to override the defaults
        docker stack deploy --compose-file $compose_file $stack
    )
}

stack_deploy $*