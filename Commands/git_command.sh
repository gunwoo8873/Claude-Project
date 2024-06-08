#!/bin/bash

################################################################
# Start developing Git management commands (2024. 05. 20 ~ )
################################################################
# TODO
# 1. 특수문자열 검증 방식
# 2. 각 연계성을 지닌 명령어에 대한 대응 방식
################################################################

# Main File Set list and configuration
BASH_RUNFILE_PATH="./../Bash_run.sh"

# Local special string and regular string cross-validation
Input="$1"
pattern="^[a-zA-Z0-9./]$"
Special_pattern="[!@#$%^&*()+?]"

# Repository Setup
Setup() {
    USER_CONFIG="../config.json"
    INITIALIZE_DIRECTORY="../.git"

    Initialize() {
        # TODO(@gunwoo8873) : Init에 대한 유저 데이터 저장방식 모색
        Init_userName() {
            read -p "Enter the username you want to save to Git : " USER_NAME
            # []$ : means the end of the string / 문자열의 끝을 의미한다
            # ^[] : Indicates the beginning of a string. / 문자열의 시작을 의미한다
            if [[ $USER_NAME =~ ^[a-zA-Z0-9]$ ]]; then
                git config --global user.name "$USER_NAME"
            else
                echo "Please enter a valid username."
                Init_userName
            fi
        }

        Init_userEmail() {
            echo "Warings : For Git configuration user data, enter the a and z lowercase strings."
            read -p "Enter the user email you want to save to Git : " USER_EMAIL
            if [[ $USER_EMAIL =~ ^[a-zA-Z0-9._]+@[a-z]+\.[a-z]{2,2}$ ]]; then
                git config --global user.email "$USER_EMAIL"
            else
                echo "Please enter a valid email address."
                Init_userEmail
            fi
        }

        Init_Setup() {
            read -p "Do you want to initialize the Repository? (y/n): " INIT_SELECT_RESET
            if [[ ${INIT_SELECT_RESET} == [yY] ]]; then
                if [[ -d ${INITIALIZE_DIRECTORY} ]]; then
                    Init_userName && Init_userEmail
                    Menulist
                else
                    git init
                    Init_userName && Init_userEmail
                    Menulist
                fi
            elif [[ ${INIT_SELECT_RESET} == [nN] ]]; then
                echo "This repository is already initialized."
                Menulist
            fi
        }
    }

    Clone() {
        URL() {
            read -p "Enter the GitHub repository address to clone : " CLONE_REPO_URL
            echo "Clone the GitHub repository"
            git clone ${CLONE_REPO_URL}
            echo "Cloning of the repository is complete"
        }
        # TODO(@gunwoo8873) : Github의 SSH 토큰 발급 및 관리 방법 모색
        SSH() {
            echo "It's a function that's not currently being implemented"
        }

        CLI() {
            echo "It's a function that's not currently being implemented"
        }

        PS3="Select the type of repository you want to copy : "
        options=("URL" "SSH" "CLI" "Back")
        select SETUP_COMMAND in "${options[@]}"
        do
            case $SETUP_COMMAND in
                "URL") URL ;;
                "SSH") SSH ;;
                "CLI") CLI ;;
                "Back") Menulist ;;
            esac
        done
    }

    # TODO(@gunwoo8873) : Pull을 Commit 메뉴에 추가하는 것이 과연 효율적일까?
    Pull() {
        echo "GitHub repository pull"
        git pull
        # TODO(@gunwoo8873) : Home외에 메뉴리스트로 돌아가는 방법은 뭘까?
        git_Menulist
    }

    PS3="Select the repository management type : "
    options=("Initialize" "Clone" "Pull" "Back")
    select SETUP_COMMAND in "${options[@]}"
    do
        case $SETUP_COMMAND in
        "Initialize") Initialize ;;
        "Clone") Clone ;;
        "Pull") Pull ;;
        "Back") git_Menulist ;;
        esac
    done
}

# TODO(@gunwoo8873): Command to Commit and Repository Pull (2024. 05. 20 ~ **)
Commit() {
    Add_Commit() {
        PS3="Please enter the scope of the file to commit : "
        options=("All" "Individual" "Back")
        select ADD_COMMIT_COMMAND_SELECT in "${options[@]}"
        do
            case $ADD_COMMIT_COMMAND_SELECT in
                All)
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                echo "GitHub All add and Commit"
                git add * && git commit -m "${COMMIT_MESSAGE}"
                git_Menulist
                ;;
                Individual)
                git status
                read -p "Please enter the file you want to add: " ADD_FILE
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                git add "${ADD_FILE}" && git commit -m "${COMMIT_MESSAGE}"
                git_Menulist
                ;;
                Back) break 1 ;;
                *) echo "Invalid option. Please try again." ;;
            esac
        done
    }

    Push() {
        echo "Git Add and Commit to Repository Push"
        git push
        git_Menulist
    }

    Remove() {
        echo "Current committed repository logs"
        git log -2
        echo "Git Remove Command (to be implemented)"
        git_Menulist
    }

    Merge() {
        echo "Current committed repository logs"
        git log -2
        read -p "Enter the branch that will receive commits from other launches. : " MERGE_MAIN_BRANCH
        git checkout $MERGE_MAIN_BRANCH
        read -p "Enter Branch to merge : " MERGE_MAIN_BRANCH
        git merge $MERGE_TARGET_BRANCH
        break
    }

    PS3="Please select a commit option : "
    options=("Add_Commit" "Push" "Merge" "Back")
    select COMMIT_SELECT_COMMAND in "${options[@]}"
    do
        case $COMMIT_SELECT_COMMAND in
            "Add_Commit") Add_Commit ;;
            "Push") Push ;;
            "Merge") Merge ;;
            "Back") Menulist ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Branch Command for User
# TODO(@gunwoo8873) : Branch의 기능을 구현하는데 공통 코드는 별도로 작성?
Branch() {
    Create() {
        Branch_list
        read -p "Please write down the branch name you want to add: " CREATE_BRANCH
        if [[ $CREATE_BRANCH =~ ^[a-zA-Z0-9]$ ]]; then
            git branch "$CREATE_BRANCH"
            break
        elif [[ $REMOVE_BRANCH =~ ^[0-9./%+-_]$ ]]; then
            echo "Invalid branch name"
            break
        fi
    }

    Remove() {
        Branch_list
        read -p "Please write down the branch name that you want to remove: " REMOVE_BRANCH
        git branch -D "$REMOVE_BRANCH"
        if [[ $REMOVE_BRANCH =~ ^[a-zA-Z]$ ]]; then
            git branch "$REMOVE_BRANCH"
            break
        elif [[ $REMOVE_BRANCH =~ ^[0-9./%+-_]$ ]]; then
            echo "Invalid branch name"
            break
        fi
    }

    Switch() {
        Branch_list.list
        read -p "Please write down the branch name you want to switch to: " SWITCH_BRANCH
        git checkout -b "$SWITCH_BRANCH"
        if [[ $SWITCH_BRANCH =~ ^[a-zA-Z0-9]$ ]]; then
            git branch "$SWITCH_BRANCH"
            break
        elif [[ $REMOVE_BRANCH =~ ^[0-9./%+-_] ]]; then
            echo "Invalid branch name"
            break
        fi
    }

    # TODO(@gunwoo8873) : Branch Information에 대한 정보 제공방식을 어떤게 좋을까?
    Branch_list() {
        list() {
            echo "Git current branch list"
            git branch -l
            break
        }
        Details() {
            echo "Git current branch version list"
            git branch -v
            break
        }
    }

    PS3="Select a branch management option : "
    options=("Create" "Remove" "Switch" "Branch_Info" "Back")
    select BRANCH_SELECT_COMMAND in "${options[@]}"
    do
        case $BRANCH_SELECT_COMMAND in
            "Create") Create ;;
            "Remove") Remove ;;
            "Switch") Switch ;;
            "Branch_Info") Branch_Info ;;
            "Back") Menulist ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

History() {
    Graph() {
        echo "It's a function that's not currently being implemented"
    }
    Log() {
        echo "It's a function that's not currently being implemented"
    }
}

# Bash Run to get Menu list
function Menulist() {
    PS3="Git Command to Select One: "
    options=("Setup" "Commit" "Branch" "Log" "Back")
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            "Setup") Setup ;;
            "Commit") Commit ;;
            "Branch") Branch ;;
            "Log") Log ;;
            "Back") source BASH_RUNFILE_PATH ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}
Menulist