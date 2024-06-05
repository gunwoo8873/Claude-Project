function ReleaseNote() {
    Write-Output "
    ===================================================================
    Warning : this git Command the PowerShell an Windows version
    PowerShell Scripting command Automation for Windows User
    1. PowerShell Terminal Version 7.4.*
    3. The Shell Scripting and Language to Tutorial for Link
    Tutorial : https://github.com/gunwoo8873/Language-Tutorial.git
    Claude Project : https://github.com/gunwoo8873/Claude-Project.git
    ===================================================================
    "
}

$GIT_SCRIPT_PATH="./Commands/git_command.ps1"
$DOCKER_SCIRPT_PATH="./Commands/docker_command.ps1"

# TODO(@gunwoo8873) : PowerShell Scripting and Main Command Menu
class DebugCommand {
    <# Define the class. Try constructors, properties, or methods. #>
}
function Command_Run() {
    Set-PSDebug -Trace 1
    git_command{
        if (Test-Path -Path $GIT_SCRIPT_PATH -PathType Leaf ) {}
        elseif () {}
    }
}