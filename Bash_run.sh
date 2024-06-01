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
    ===================================================================
    "
    git_Menulist
}

# Git Repository Setup
Setup() {
    USER_CONFIG="/config.json"
    INITIALIZE_DIRECTORY="/.git"
    INITIALIZE() {
        read -p "Initialize Git Repository? (y/n): " INITIALIZE_INPUT
        if [[ "$INITIALIZE_INPUT" == [Yy] ]]; then
            echo "Git Repository Initialize Setup..."
            git init
            git_Menulist
        elif [[ "$INITIALIZE_INPUT" == [Nn] ]]; then
            git_Menulist
        fi
    }
    CLONE() {
        read -p "Clone git Repository: " GIT_CLONE_REPOSITORY
        git clone "$GIT_CLONE_REPOSITORY"
        git_Menulist
    }
}

Commit() {
    Add_Commit() {
        PS3="Please enter the scope of the file to commit: "
        options=("ALL" "INDIVIDUAL")
        select COMMIT_RANGE in "${options[@]}"
        do
            case $COMMIT_RANGE in
                ALL)
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                echo "GitHub All add and Commit"
                git add . && git commit -m "$COMMIT_MESSAGE"
                git_Menulist
                ;;
                INDIVIDUAL)
                git status
                read -p "Please enter the file you want to add: " ADD_FILE
                read -p "Please enter a message to commit: " COMMIT_MESSAGE
                git add "$ADD_FILE" && git commit -m "$COMMIT_MESSAGE"
                git_Menulist
                ;;
                *)
                echo "Invalid option. Please try again."
                ;;
            esac
        done
    }
    Push() {
        echo "Git Add and Commit to Repository Push"
        git push
    }
    Merge() {
        echo "Git Merge Command (to be implemented)"
    }
    Back(){
        return
    }
    PS3="Please select a commit option: "
    options=("Add_Commit" "Push" "Merge" "Back")
    select COMMIT_COMMAND in "${options[@]}"
    do
        case $COMMIT_COMMAND in
            Add_Commit) Add_Commit ;;
            Push) Push ;;
            Merge) Merge ;;
            Back) return ;;
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
        git checkout "$SWITCH_BRANCH"
        git_Menulist
    }
    Branch_Info(){
        echo "Current branch list"
        git branch -v
        git_Menulist
    }
    Back(){
        return
    }
    PS3="Select a branch management option: "
    options=("Create" "Remove" "Switch" "Branch_Info" "Back")
    select BRANCH_COMMAND in "${options[@]}"
    do
        case $BRANCH_COMMAND in
            Create) Create ;;
            Remove) Remove ;;
            Switch) Switch ;;
            Branch_Info) Branch_Info ;;
            Back) return ;;
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
    options=("ReleaseNote" "Initialize" "Commit" "Pull" "Branch" "Help" "Exit")
    
    select GIT_MENULIST in "${options[@]}"
    do
        case "$GIT_MENULIST" in
            "ReleaseNote") ReleaseNote ;;
            "Initialize") Setup ;;
            "Commit") Commit ;;
            "Pull") Pull ;;
            "Branch") Branch ;;
            "Help") ReleaseNote ;;  # Assuming 'Help' shows the Release Note
            "Exit") exit 1 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
    done
}

# Start the menu
git_Menulist