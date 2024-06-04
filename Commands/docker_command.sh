#!/bin/bash
Container() {
    Container_Name() {}
    Create() {}
    Remove() {}
    Start() {}
    Stop() {}
    Restart() {}
    Pause() {}
}
Image() {
    Build() {}
    Push() {}
    Remove() {}
}
Volume() {
    Create() {}
    Remove() {}
    Mount() {}
    Unmount() {}
}
Build() {
    echo "Non Builde Command Line"
}
Settings() {
    echo "Non Builde Command Line"
    Login() {}
}

function Docker_Menulist() {
    $?
}