#!/bin/bash

# Repository Setup
Setup() {
    USER_CONFIG="../config.json"
    INITIALIZE_DIRECTORY="../.git"

    Initialize() {
        # TODO(@gunwoo8873) : Init에 대한 유저 데이터 저장방식 모색
        Init_userName() {
            read -p "Enter the username you want to save to Git : " USER_NAME
            git config --globar user.name "$USER_NAME"
        }

        Init_userEmail() {
            read -p "Enter the user email you want to save to Git : " USER_EMAIL
            git config --globar user.email "$USER_EMAIL"
        }

        Init_Setup() {
            read -p "Do you want to initialize the Repository? (y/n): " INIT_SELECT_RESET
            if [[ ${INIT_SELECT_RESET} == [Yy] ]]; then
                if [[ -d ${INITIALIZE_DIRECTORY} ]]; then
                    Init_userName && Init_userEmail
                    git_Menulist
                else
                    git init
                    Init_userName && Init_userEmail
                    git_Menulist
                fi
            elif [[ ${INIT_SELECT_RESET} == [Nn] ]]; then
                echo "This repository is already initialized."
                git_Menulist
            fi
        }
        Init_Setup
    }

    Clone() {
        URL() {
            read -p "Enter the GitHub repository address to clone : " CLONE_REPO_URL
            echo "Clone the GitHub repository"
            git clone ${CLONE_REPO_URL}
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
                "Back") git_Menulist ;;
            esac
        done
    }

    PS3="# : "
    options=("Initialize" "Clone" "Back")
    select SETUP_COMMAND in "${options[@]}"
    do
        case $SETUP_COMMAND in
        "Initialize") Initialize ;;
        "Clone") Clone ;;
        "Back") git_Menulist ;;
        esac
    done
}

# TODO(@gunwoo8873): Command to Commit and Repository Pull (2024. 05. 20 ~ **)
Commit() {
    Add_Commit() {
        PS3="Please enter the scope of the file to commit : "
        options=("All" "Individual" "Back")
        select COMMIT_OPTIONS in "${options[@]}"
        do
            case $COMMIT_OPTIONS in
                All)
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                echo "GitHub All add and Commit"
                git add * && git commit -m "$COMMIT_MESSAGE" || git commit -a -m "$COMMIT_MESSAGE"
                git_Menulist
                ;;
                Individual)
                git status
                read -p "Please enter the file you want to add: " ADD_FILE
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                git add "$ADD_FILE" && git commit -m "$COMMIT_MESSAGE"
                git_Menulist
                ;;
                Back) git_Menulist ;;
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
    }

    Merge() {
        echo "Current committed repository logs"
        git log -2
        read -p "Enter the branch that will receive commits from other launches. : " MERGE_MAIN_BRANCH
        git checkout $MERGE_MAIN_BRANCH
        read -p "???? : " MERGE_MAIN_BRANCH
        git merge $MERGE_TARGET_BRANCH
    }

    PS3="Please select a commit option : "
    options=("Add_Commit" "Push" "Merge" "Back")
    select COMMIT_COMMAND in "${options[@]}"
    do
        case $COMMIT_COMMAND in
            "Add_Commit") Add_Commit ;;
            "Push") Push ;;
            "Merge") Merge ;;
            "Back") git_Menulist ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Pull file updates
# Pull을 Commit 메뉴에 추가하는 것이 과연 효율적일까?
Pull() {
    echo "GitHub repository pull"
    git pull
    git_Menulist
}

Branch_Info() {
    echo "Add current Github branch list"
    git branch -l
}

# Branch Command for User
# TODO(@gunwoo8873) : Branch Command list Refactoring
Branch() {
    Create(){
        echo "Current branch list"
        git branch -l
        read -p "Please write down the branch name you want to add: " CREATE_BRANCH
        git branch "$CREATE_BRANCH"
        git_Menulist
    }

    Remove(){
        echo "Current branch list"
        git branch -l
        read -p "Please write down the branch name that you want to remove: " REMOVE_BRANCH
        git branch -D "$REMOVE_BRANCH"
        git_Menulist
    }

    Switch(){
        echo "Current branch list"
        git branch -l
        read -p "Please write down the branch name you want to switch to: " SWITCH_BRANCH
        git checkout -b "$SWITCH_BRANCH"
        git_Menulist
    }

    Branch_Info(){
        echo "Current branch list"
        git branch -v
    }

    PS3="Select a branch management option : "
    options=("Create" "Remove" "Switch" "Branch_Info" "Back")
    select BRANCH_COMMAND in "${options[@]}"
    do
        case $BRANCH_COMMAND in
            "Create") Create ;;
            "Remove") Remove ;;
            "Switch") Switch ;;
            "Branch_Info") Branch_Info ;;
            "Back") git_Menulist ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Bash Run to get Menu list 
function git_Menulist() {
    Bash_run_dir() {
        BASH_RUN_DIRECTORY="../Bash_run.sh"
        if [[ -x ${BASH_RUN_DIRECTORY} ]]; then
            source ${BASH_RUN_DIRECTORY}
        else
            echo "Bash_run.sh not found"
        fi
    }

    PS3="Git Command to Select One: "
    options=("Setup" "Commit" "Pull" "Branch" "Help" "Back")
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            "Setup") Setup ;;
            "Commit") Commit ;;
            "Pull") Pull ;;
            "Branch") Branch ;;
            "Help") Help ;;  # Assuming 'Help' shows the Release Note
            "Back") Bash_run_dir ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}
git_Menulist