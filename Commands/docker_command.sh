#!/bin/bash

################################################################
# Start developing Docker management commands (2024. 06. 08 ~ )
################################################################
# TODO
# 1. 특수문자열 검증 방식
# 2. 각 연계성을 지닌 명령어에 대한 대응 방식
################################################################

# Main File Set list and configuration
DOCKERFILE_PATH="../Dockerfile"
DOCKERIGNORE_PATH="../Dockerignore"
BASH_RUNFILE_PATH="./../Bash_run.sh"

# Local special string and regular string cross-validation
Input="$1"
pattern="^[a-zA-Z0-9./]$"
Special_pattern="[!@#$%^&*()+?]"

# Docker Container Managerment
Container() {
    Create() {}
    Remove() {}
    Start() {}
    Stop() {}
    Pause() {}
    Restart() {}
    Exit() {}

    List() {
        echo "Current Docker Container list"
        docker container ls
        Container
    }

    Back() {
        Menulist
    }

    PS3="Select the container menu : "
    opstions=("Create" "Remove" "Start" "Stop" "Pause" "Restart" "Exit" "List" "Back")
    select CONTAINER_MANAGERMENT in "${opstions[@]}"
    do
    done
}

Image() {
    Build() {
        # Docker Image Build Create to Setup
        echo "Image Build at Dockerfile to Create"
        read -p "Enter the image name: " IMAGE_BUILD_NAME
        read -p "Enter the image tag: " IMAGE_BUILD_TAG
        if [[ ${IMAGE_BUILD_NAME} =~ ${pattern} && ${IMAGE_BUILD_TAG} =~ ${pattern} ]]
            docker build -t ${IMAGE_BUILD_NAME}:${IMAGE_BUILD_TAG} .
        elif [[ ${IMAGE_BUILD_NAME} =~ ${Special_pattern} || ${IMAGE_BUILD_TAG} =~ ${Special_pattern} ]]
            echo "Error: Special symbols cannot be entered. Please re-enter them."
            Image
        fi
    }

    Push() {}

    Merge() {}

    Remove() {
        List
        read -p "Enter the Image name to remove : " IMAGE_NAME
        docker image rm ${IMAGE_NAME}
    }

    List() {
        echo "Docker Image list"
        docker image ls
    }

    DockerHub_Push() {
        List
        echo "경고: 푸시할 이미지가 도커 허브 리포지토리 이름과 같아야 합니다"
        echo "Warning: The image you want to push must have the same name as your Docker Hub repository"
        read -p "Enter the image name: " REPOSITORY_NAME
        read -p "Enter the image tag: " REPOSITORY_TAG
        if [[ ${REPOSITORY_NAME} =~ ${pattern} && ${REPOSITORY_TAG} =~ ${pattern} ]]
            docker push ${REPOSITORY_NAME}:${REPOSITORY_TAG}
            echo "DockerHub Image Push"
            Image
        elif [[ ${REPOSITORY_NAME} =~ ${Special_pattern} || ${REPOSITORY_TAG} =~ ${Special_pattern} ]]
            echo "Error: Special symbols cannot be entered. Please re-enter them."
            Image
        fi
    }

    Back() {
        Menulist
    }

    PS3="Select the image menu : "
    opstions=("Back")
    select CONTAINER_MANAGERMENT in "${opstions[@]}"
    do
    done
}

# Docker Volume Managerment
Volume() {
    Create() {}
    Remove() {}
    Mount() {}
    Unmount() {}

    Back() {
        Menulist
    }

    PS3=""
    opstions=("Create" "Remove" "Mount" "Unmount" "List" "Back")
    select CONTAINER_MANAGERMENT in "${opstions[@]}"
    do
    done
}

# Docker Build Managerment
Build() {
    echo "It's a function that's not currently being implemented"

    Back() {
        Menulist
    }
}

# Docker Settings Managerment
Settings() {
    echo "It's a function that's not currently being implemented"
    Login() {
        docker login
    }
    Logout() {
        docker logout
    }

    Back() {
        Menulist
    }

    PS3=""
    opstions=("Back")
    select CONTAINER_MANAGERMENT in "${opstions[@]}"
    do
    done
}

Back() {
    if [[ -x ${BASH_RUNFILE_PATH} ]]; then
        source ${BASH_RUNFILE_PATH}
    elif [[ ! -x ${BASH_RUNFILE_PATH} || ! -f ${BASH_RUNFILE_PATH} ]]
        echo error
    fi
}

# Docker Main Managerment
function Menulist() {
    PS3="Select the menu to run : "
    docker_menu=("Container" "Image" "Volume" "Build" "Settings" "Back")
    select DOCKER_MENU_SELECT in 
    do
        Container) Container ;;
        Image) Image ;;
        Volume) Volume ;;
        Build) Build ;;
        Settings) Settings ;;
        Back) Back ;;
        *) echo "Invalid Input" ;;
    done
}