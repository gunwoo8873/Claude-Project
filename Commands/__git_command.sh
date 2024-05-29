#!/bin/bash

# Git Command Project Release Note
git_ReleaseNote() {
    echo "==================================================================="
    echo "Shell Scripting Command Automation for Git Command Skip Target"
    echo "1. Terminal Bash Version in 2.25.*"
    echo "2. This Script the Beta 1.0.0 is New Shell Scripting git Command"
    echo "3. The Shell Scripting and Language to Tutorial for Link 
    Tutorial : https://github.com/gunwoo8873/Tutorial.git"
    echo "==================================================================="
}

# Git Repository Setup
git_Setup() {
    INITIALIZE() {
        USER_CONFIG="config.json"
        INITALIZE_DIRECTORY=".git"
        read -p "" INITALIZE_INPUT
        if [[ "$INITALIZE_INPUT" == [Y,y] ]]; then
            echo "Git Repository Initalize Setup..."
            git init
            git_Menulist
        elif [[ "$INITALIZE_INPUT" == [N,n] ]]; then
            git_Menulist
        fi
    }
    CLONE() {
        read -p "Clone git Repository : " GIT_CLONE_REPOSITORY
        git clone $GIT_CLONE_REPOSITORY
        git_Menulist
    }
}

git_Commit() {
    ADD_COMMIT() {
        read -p "Commit"
    }
    PUSH() {

    }
    MERGE() {

    }
}

git_Branch() {
    CREATE(){
        echo "Branch List"
        git branch -l
        read -p "Enter a New Branch to add : " CREATE_BRANCH
        git branch $CREATE_BRANCH
        break 1
    }
    REMOVE(){
        git branch -l
        read -p "Enter a Branch to remove : " REMOVE_BRANCH
        git branch -D $REMOVE_BRANCH
        break 1
    }
    SWITCH(){
        git branch -l
        read -p "Switching Branch : " SWITCH_BRANCH
        git checkout $SWITCH_BRANCH
        break 1
    }
    BRANCH_INFO(){
        git branch -v
        break 1
    }
}

git_Pull() {
    PULL() {
        echo "Git Repository Pull"
        git pull
    }
}

function git_Menulist(){
    PS3="Git Command to Select One : "
    options=("Release Note" "Initialize" "Commit" "Pull" "Branch" "Exit")
    
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            NOTIE)
            git_ReleaseNote
            ;;
            INIT)
            git_Setup
            ;;
            COMMIT)
            git_Commit
            ;;
            PULL)
            git_Pull
            ;;
            BRANCH)
            git_Branch
            ;;
            EXIT) 
            exit 1 
            ;;
            *) 
            echo git_Menulist
            ;;
        esac
    done
}
git_Menulist