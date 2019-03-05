#!/bin/bash
# Bash wrappers for docker run commands
export DOCKER_REPO_PREFIX=jess

gitsome(){
        docker run --rm -it \
                -v /etc/localtime:/etc/localtime:ro \
                --name gitsome \
                --hostname gitsome \
                -v "${HOME}/.gitsomeconfig:/home/anon/.gitsomeconfig" \
                -v "${HOME}/.gitsomeconfigurl:/home/anon/.gitsomeconfigurl" \
                ${DOCKER_REPO_PREFIX}/gitsome
}

http(){
        docker run -t --rm \
                -v /var/run/docker.sock:/var/run/docker.sock \
                --log-driver none \
                ${DOCKER_REPO_PREFIX}/httpie "$@"
}

alias figlet="docker run -it --rm mbentley/figlet"
alias pcat='docker run --rm -v $(pwd):/local rahulsom/pcat'
alias yq="docker run --rm -i dotlou/yq"
alias jq="docker run --rm -i dotlou/jq"
