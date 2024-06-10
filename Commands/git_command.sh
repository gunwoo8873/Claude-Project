#!/usr/bin/env bash

# Main File Set list and configuration
BASH_RUNFILE_PATH="./../Bash_run.sh"

# Repository Setup
Settings() {
    Initialize() {
        # ^[] : Indicates the beginning of a string. / 문자열의 시작을 의미한다
        # []$ : means the end of the string / 문자열의 끝을 의미한다
        local USER_NAME="^[a-zA-Z0-9]$"
        local USER_EMAIL="^[a-zA-Z0-9._]+@[a-z]+\.[a-z]{2,2}$"
        local ERROR_STRING="^[!#$%&'*+-/=?^_{|}~]$"

        Init_userName() {
            read -p "Enter the username : " GET_USERNAME
            if [[ ${GET_USERNAME} =~ ${USER_NAME} ]]; then
                git config --global user.name ${GET_USERNAME}
            elif [[ ${GET_USERNAME} =~ ${ERROR_STRING} ]]; then
                echo "Invalid user name format. Please try again."
                Init_userName
            fi
        }

        Init_userEmail() {
            read -p "Enter the user email : " GET_USER_EMAIL
            if [[ ${GET_USER_EMAIL} =~ ${USER_EMAIL} ]]; then
                git config --global user.email ${GET_USER_EMAIL}
            elif [[ ${GET_USER_EMAIL} =~ ${ERROR_STRING} ]]; then
                echo "Invalid user email format. Please try again."
                Init_userEmail
            fi
        }

        Init_Setup() {
            read -p "Do you want to initialize the Repository? (y/n): " GET_INIT_SELECT
            if [[ ${GET_INIT_SELECT} == [yY] ]]; then
                if [[ -d ${GIT_DIR} ]]; then
                    Init_userName && Init_userEmail
                    git config --global -l
                else
                    git init
                    Init_userName && Init_userEmail
                fi
            elif [[ ${GET_INIT_SELECT} == [nN] ]]; then
                echo "This repository is already initialized."
            fi
            Settings
        }
        Init_Setup
    }

    Clone() {
        URL() {
            read -p "Enter the GitHub repository address to clone : " CLONE_REPO_URL
            echo "Clone the GitHub repository"
            git clone ${CLONE_REPO_URL}
            echo "Cloning of the repository is complete"
            Clone
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
                "Back") Settings ;;
            esac
        done
    }

    # TODO(@gunwoo8873) : Pull을 Commit 메뉴에 추가하는 것이 과연 효율적일까?
    Pull() {
        echo "GitHub repository pull"
        git pull
        Settings
    }

    Reset() {
        # Warings : Note that the initializes additional and committed files and returns all of the work.
        # 경고 : 추가 및 커밋된 파일을 초기화하고 모든 작업을 반환합니다.
        Hard() {
            echo "Repository to HRAD reset"
        }

        # Soft : Note that the initializes additional and committed files and returns of the work
        #
        Soft() {
            echo "Repository to SOFT reset"
        }

        #
        Mixed() {
            echo "Repository to MIXED reset"
        }

        PS3=""
        options=("HARD" "SOFT" "MIXED" "Back")
        select RESET_COMMAND in "${options[@]}"
        do
            case $RESET_COMMAND in
                HARD) Hard ;;
                SOFT) Soft ;;
                MIXED) Mixed ;;
                Back) Settings ;;
            esac
        done
    }

    PS3="Select the repository management type : "
    options=("Initialize" "Clone" "Pull" "Back")
    select SETUP_COMMAND in "${options[@]}"
    do
        case $SETUP_COMMAND in
        "Initialize") Initialize ;;
        "Clone") Clone ;;
        "Pull") Pull ;;
        "Back") Menulist ;;
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
                git status
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                echo "GitHub All add and Commit"
                git add * && git commit -m "${COMMIT_MESSAGE}" && Push
                ;;
                Individual)
                git status
                read -p "Please enter the file you want to add: " ADD_FILE
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                git add "${ADD_FILE}" && git commit -m "${COMMIT_MESSAGE}" && Push
                ;;
                Back) Commit ;;
                *) echo "Invalid option. Please try again." ;;
            esac
        done
    }

    Push() {
        echo "Git Add and Commit to Repository Push"
        git push
        Commit
    }

    Remove() {
        echo "Current committed repository logs"
        git log -2
        echo "Git Remove Command (to be implemented)"
        Commit
    }

    Merge() {
        echo "Current committed repository logs"
        git log -2
        read -p "Enter the branch that will receive commits from other launches. : " MERGE_MAIN_BRANCH
        git checkout $MERGE_MAIN_BRANCH
        read -p "Enter Branch to merge : " MERGE_MAIN_BRANCH
        git merge $MERGE_TARGET_BRANCH
        Commit
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
        if [[ $CREATE_BRANCH =~ ^[a-zA-Z]$ ]]; then
            git branch "$CREATE_BRANCH"
        elif [[ $CREATE_BRANCH =~ ^[0-9./%+-_]$ ]]; then
            echo "Invalid branch name"
        fi
        Branch
    }

    Remove() {
        Branch_list
        read -p "Please write down the branch name that you want to remove: " REMOVE_BRANCH
        git branch -D "$REMOVE_BRANCH"
        if [[ $REMOVE_BRANCH =~ ^[a-zA-Z]$ ]]; then
            git branch "$REMOVE_BRANCH"
        elif [[ $REMOVE_BRANCH =~ ^[0-9./%+-_]$ ]]; then
            echo "Invalid branch name"
        fi
        Branch
    }

    Switch() {
        Info.list
        read -p "Please write down the branch name you want to switch to: " SWITCH_BRANCH
        git checkout -b "$SWITCH_BRANCH"
        if [[ $SWITCH_BRANCH =~ ^[a-zA-Z]$ ]]; then
            git branch "$SWITCH_BRANCH"
        elif [[ $SWITCH_BRANCH =~ ^[0-9./%+-_] ]]; then
            echo "Invalid branch name"
        fi
        Branch
    }

    # TODO(@gunwoo8873) : Branch Information에 대한 정보 제공방식을 어떤게 좋을까?
    Info() {
        list() {
            echo "Git current branch list"
            git branch -l
            Branch
        }
        Details() {
            echo "Git current branch version list"
            git branch -v
            Branch
        }
    }

    PS3="Select a branch management option : "
    options=("Create" "Remove" "Switch" "Info" "Back")
    select BRANCH_SELECT_COMMAND in "${options[@]}"
    do
        case $BRANCH_SELECT_COMMAND in
            "Create") Create ;;
            "Remove") Remove ;;
            "Switch") Switch ;;
            "Info") Info ;;
            "Back") Menulist ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

History() {
    Graph() {
        echo "It's a function that's not currently being implemented"
        git log --graph
        wq
    }

    Log() {
        echo "It's a function that's not currently being implemented"
        read -p "Enter the Git logs at Number : "
        git log -p ${LOGS_NUMBER}
    }
}

# Bash Run to get Menu list
function Menulist() {
    PS3="Git Command to Select One: "
    options=("Settings" "Commit" "Branch" "History" "Back")
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            "Settings") Settings ;;
            "Commit") Commit ;;
            "Branch") Branch ;;
            "History") History ;;
            "Back") source BASH_RUNFILE_PATH ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}
Menulist