#!/bin/bash

GIT_SCRIPT_PATH="./Commands/git_command.sh"
DOCKER_SCIRPT_PATH="./Commands/docker_command.sh"

ReleaseNote() {
    echo "
    ===================================================================
    Shell Scripting Command Automation for Git Command Skip Target
    1. Terminal Bash Version in 2.25.*
    2. This Script the Beta 1.0.0 is New Shell Scripting git Command
    3. The Shell Scripting and Language to Tutorial for Link
    Tutorial : https://github.com/gunwoo8873/Tutorial.git
    Claude Project : https://github.com/gunwoo8873/Claude-Project.git
    ===================================================================
    "
}

git_Command(){
    if [[ -f "$GIT_SCRIPT_PATH" ]]; then
        source "$GIT_SCRIPT_PATH"
    elif [[ ! -f "$GIT_SCRIPT_PATH" || ! -n "$GIT_SCRIPT_PATH" || ! -r "$GIT_SCRIPT_PATH" ]]; then
        echo Error:
        bash_Run
    fi
}

docker_Command(){
    if [[ -f "$DOCKER_SCIRPT_PATH" ]]; then
        source "$DOCKER_SCIRPT_PATH"
    elif [[ ! -f "$DOCKER_SCRIPT_PATH" || ! -n "$DOCKER_SCRIPT_PATH" || ! -r "$DOCKER_SCRIPT_PATH" ]]; then
        echo Error:
        bash_Run
    fi
}

function bash_Run(){
    ReleaseNote
}