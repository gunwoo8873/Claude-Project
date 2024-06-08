#!/bin/bash

ReleaseNote() {
echo "
============================================================================
Shell Script 기반으로 제작한 선택형 명령어 수행 프로세스 입니다.
주의 : 현재 Git과 Docker 명령어 간편화는 테스트중이므로 오류가 발생할 수 있습니다.
Shell과 Powershell의 튜토리얼 내용과 스크립트는 아래 저장소에 있습니다.
============================================================================
This is a selection-based command execution process created with Shell Script.
Note: The simplification of Git and Docker commands is currently being tested, so errors may occur.
The tutorial content and scripts for Shell and Powershell are available in the following repositories.
============================================================================
Tutorial : https://github.com/gunwoo8873/Tutorial.git
Claude Project : https://github.com/gunwoo8873/Claude-Project.git
============================================================================"
}

function Command_Run() {
    # Git and Docker Commands Script Directory
    GIT_SCRIPT_PATH="./Commands/git_command.sh"
    DOCKER_SCIRPT_PATH="./Commands/docker_command.sh"

    Git_Command_Run() {
        # -x : Check whether the file exists and can be read and written
        if [[ -x ${GIT_SCRIPT_PATH} ]]; then
            # source : Outside file the Run
            source ${GIT_SCRIPT_PATH}
        elif [[ ! -x ${DOCKER_SCIRPT_PATH} ]]; then
            echo error;
        fi
    }

    Docker_Command_Run() {
        if [[ -x ${DOCKER_SCIRPT_PATH} ]]; then
            source ${DOCKER_SCIRPT_PATH}
        elif [[ ! -x ${DOCKER_SCIRPT_PATH} ]]; then
            echo error;
        fi
    }

    PS3="Select a category for your console: "
    run_category=("Git" "Docker" "Exit")
    select COMMAND_RUN_CATEGORY in ${run_category[@]}
    do
        case $COMMAND_RUN_CATEGORY in
            Git) Git_Command_Run ;;
            Docker) Docker_Command_Run ;;
            Exit) exit 1 ;;
            *) echo $! ;;
        esac
    done
}
ReleaseNote
sleep 1
Command_Run