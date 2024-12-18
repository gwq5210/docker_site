#!/bin/sh

cd `dirname "$0"`

compose_deploy() {
    compose_file=${1:-docker-compose.yml}

    if [ ! -f $compose_file ]; then
        echo "Misses compose file: $compose_file" >&2
        return 1
    fi

    # execute as a subcommand in order to avoid the variables remain set
    (
        # export variables excluding comments
        [ -f .env ] && export $(sed '/^#/d' .env)

        # Use dsd your_stack your_compose_file to override the defaults
        shift
        docker compose --compatibility -f $compose_file up -d $*
    )
}

compose_deploy $*