class Setup{
    [void] Initialize()
    {
        $INIT_SELET = Read-Host "Enter the repository Initialize? (y/n) : "
        if ( $INIT_SELET -eq "y" -or $INIT_SELET -eq "Y" ) {
            
        }
        elseif ( $INIT_SELET -eq "n" -or $INIT_SELET -eq "N" ) {
        }
        else {
            Write-Output "Invalid Input"
        }
    }

    [void] Clone()
    {
        URL() {
        }
        SSH() {
        }
        $CLONE_INPUT = Read-Host "Enter the repository Clone type? : "
        
    }
}

class Commit {}
class Branch {}
class History {}

function Menulist() {
    $GIT_MENULIST = ("Setup", "Commit", "Branch", "History", "Back")
    $MENU_SELECT = Read-Host "Select one the Menulist : "
    Select-Object [[]]
}