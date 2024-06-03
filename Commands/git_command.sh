#!/bin/bash

# Git Command Project Release Note
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

# Git Repository Setup
Setup() {
    #USER_CONFIG="Claude-Project/config.json"
    INITIALIZE_DIRECTORY="Claude-Project/.git"
    set_user_Name() {
        read -p "Enter the User Name : " USER_USERNAME
        git config --globar user.name "$USER_USERNAME"
    }
    set_user_Email() {
        read -p "Enter the User Email : " USER_EMAIL
        git config --globar user.email "$USER_EMAIL"
    }
    Initialize() {
        read -p "Initialize Git Repository? (y/n): " INITIALIZE_INPUT
        if [[ "$INITIALIZE_INPUT" == [Yy] ]]; then
            echo "Git Repository Initialize Setup..."
            if [[ -d $INITIALIZE_DIRECTORY ]]; then
                echo "Git Repository already exists"
                git_Menulist
            else
                git init
                set_user_Name && set_user_Email
                git_Menulist
            fi
        elif [[ "$INITIALIZE_INPUT" == [Nn] ]]; then
            git_Menulist
        fi
    }
    Clone() {
        read -p "Clone git Repository: " GIT_CLONE_REPOSITORY
        git clone "$GIT_CLONE_REPOSITORY"
        git_Menulist
    }

    PS3=""
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
    Merge() {
        echo "Git Merge Command (to be implemented)"
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

Pull() {
    echo "GitHub repository pull"
    git pull
    git_Menulist
}

# Bash Run to get Menu list 
function git_Menulist() {
    PS3="Git Command to Select One: "
    options=("ReleaseNote" "Setup" "Commit" "Pull" "Branch" "Help" "Exit")
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            "ReleaseNote") ReleaseNote ;;
            "Setup") Setup ;;
            "Commit") Commit ;;
            "Pull") Pull ;;
            "Branch") Branch ;;
            "Help") ReleaseNote ;;  # Assuming 'Help' shows the Release Note
            "Exit") exit 1 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}
git_Menulist