function auto_activate_dotenv {
    SEARCHPATH=$PWD
    function activate_env {
        # ZSH outputs errors for the ls * command if you don't disable the nomatch output
        unsetopt nomatch 2>/dev/null
        ls $SEARCHPATH/.env > /dev/null 2> /dev/null
        if [ "$?" = '0' ]; then
            deactivate > /dev/null 2> /dev/null
            source $SEARCHPATH/.env
            return
        else
            SEARCHPATH=$(dirname "$SEARCHPATH")
            if [ "$SEARCHPATH" = "/" ]; then
                return
            fi
            activate_env
            return $?
        fi
    }
    #unset SEARCHPATH
    activate_env
    setopt nomatch
}
function chpwd_dotenv () {
    auto_activate_dotenv
}

chpwd_functions=(${chpwd_functions[@]} "chpwd_dotenv")
