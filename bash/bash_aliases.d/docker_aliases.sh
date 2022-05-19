#!/usr/bin/env bash

export DOCKER_USER=lu0alv
export DOCKER_TOKEN_FILE=~/.docker/docker-token

# Remove from docker hub
#   $1 repository
#   $2 tag
# > dhub-rm repository:tag
function dhub-rm() {
    [[ ! $1 =~ ":" ]] && echo "Wrong REPO:TAG specification" && return

    local hub_repo=$(echo $1 | cut -d':' -f1)
    local hub_tag=$(echo $1 | cut -d':' -f2)

    [ -z "$hub_tag" ] && echo "Tag was not specified" && return

    api_url=https://hub.docker.com/v2/repositories/$DOCKER_USER/$hub_repo
    [ -n "$hub_tag" ] && api_url=${api_url}/tags/$hub_tag

    curl -i -X DELETE \
        -H "Accept: application/json" \
        -H "Authorization: JWT $(<"")" \
        ${api_url}
}


function dockerhub() {
    usage() {
        echo
        echo "Docker hub api for terminal."
        echo
        echo "Usage: dockerhub [-l|r] [REPO]:[TAG]"
        echo
        echo "Options:"
        echo "   -l     Print the list of tags in the [REPO]."
        echo "   -r     Remove a [TAG] from the [REPO]."
        echo
    }

    PASSED_OPT="true"
    local OPTIND=1
    local hub_repo hub_tag api_url
    while getopts :lr opt; do
        case $opt in
        l)
            [[ -z $2 ]] && echo "Wrong REPO specification" && return
            hub_repo=$2
            api_url=https://hub.docker.com/v2/repositories/$DOCKER_USER/$hub_repo/tags
            echo "Tags in $DOCKER_USER/${hub_repo}:"
            echo
            # -s to supress progress meter when piping
            curl -s ${api_url} | grep -oh '"name":"[^,]*' | cut -d ':' -f 2 | tr -d '"'
            return
            ;;
        r)
            [[ ! $2 =~ ":" ]] && echo "Wrong REPO:TAG specification" && return

            hub_repo=$(echo $2 | cut -d ':' -f 1)
            hub_tag=$(echo $2 | cut -d ':' -f 2)
            [ -z "$hub_tag" ] && echo "Tag was not specified" && return

            api_url=https://hub.docker.com/v2/repositories/$DOCKER_USER/$hub_repo
            [ -n "$hub_tag" ] && api_url=${api_url}/tags/$hub_tag/

            curl -i -X DELETE \
                -H "Accept: application/json" \
                -H "Authorization: JWT $(<"${DOCKER_TOKEN_FILE}")" \
                ${api_url}

            return
            ;;
        *)
            usage
            return
            ;;
        esac
    done

    PASSED_OPT=
    [ -z "$PASSED_OPT" ] && usage && return
}

# Deprecated, modify ~/.docker/config.json
# alias dps='docker ps -a --no-trunc --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Command}}"'
