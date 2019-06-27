export PYTHONSTARTUP=$HOME/.config/python/startup.py
export IPYTHONDIR=$HOME/.config/ipython
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/virtualenvs

function auto_activate {
    SEARCHPATH=$PWD
    function activate_env {
        # ZSH outputs errors for the ls * command if you don't disable the nomatch output
        unsetopt nomatch 2>/dev/null
        ls $SEARCHPATH/.venv/bin/activate > /dev/null 2> /dev/null
        if [ "$?" = '0' ]; then
            deactivate > /dev/null 2> /dev/null
            source $SEARCHPATH/.venv/bin/activate
            VIRTUAL_ENV=$(basename $SEARCHPATH)
            return
        else
            SEARCHPATH=$(dirname "$SEARCHPATH")
            VIRTUAL_ENV=''
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
function chpwd() {
    auto_activate
}

if [ -x /usr/local/bin/python2.7 ]; then
    # Mac OS (with Brew)
    [ -x /usr/local/bin/python2.7 ] && export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
    [ -x /usr/local/bin/virtualenv ] && export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    [ -x /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh
else
    # Arch Linux
    [ -x /usr/bin/python2.7 ] && export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    [ -x /usr/bin/virtualenv2 ] && export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2
    [ -x /usr/bin/virtualenvwrapper.sh ] && source /usr/bin/virtualenvwrapper.sh
fi
