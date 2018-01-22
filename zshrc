# tty config
stty -ixon
ttyctl -f

# some zsh variables
ZDOTDIR=$HOME/.config/zsh
GITUSER=`git config user.name`

# special chars
LDART=$'\ue0b0'
RDART=$'\ue0b2'
BRNCH=$'\ue0a0'
ENVIR=$'\u2709'
DIRIC=$'\u27b2'
SMILY=$'\u2620'

# history
HISTFILE=$HOME/.local/history/zhst
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS

# modules
autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload edit-command-line
zle -N edit-command-line
autoload -Uz vcs_info
function preexec() { timer=${timer:-$SECONDS} }
function precmd () {
    vcs_info
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        export RPROMPT="%F{16}%k\$RDART%F{231}%K{16} \$? %F{220}\$RDART%F{24}%K{220} %* %F{16}\$RDART%F{231}%K{16} ${timer_show}s "
        unset timer
    fi
}
RPROMPT="%F{16}%k\$RDART%F{231}%K{16} \$? %F{220}\$RDART%F{24}%K{220} %* "

# options
setopt autocd extendedglob notify prompt_subst completealiases
unsetopt beep
bindkey -v
bindkey -M vicmd v edit-command-line

# autocomplete and command-not-found hook
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh
[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOME/.zsh/zsh-vimode-visual/zsh-vimode-visual.zsh ] && source $HOME/.zsh/zsh-vimode-visual/zsh-vimode-visual.zsh
bindkey '^ ' autosuggest-accept

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
alias autoactivate="auto_activate"

# add virtualenv info to prompt
function virtualenv_info(){
    venv=''
    [[ -n "$VIRTUAL_ENV" ]] && venv="${VIRTUAL_ENV##*/}"
    [[ -n "$venv" ]] && echo "%F{231}%K{74} $ENVIR $venv %F{74}%k"
}

# add vcs information to prompt
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{240}%K{236}$LDART%F{250} $BRNCH %s:%r/%b %m%u%c %F{236}"

# add vi-mode to prompt
VI_MODE="%F{22}%K{148}%B INSERT %b%F{148}%K{166}$LDART"
function zle-line-init zle-keymap-select {
    case ${KEYMAP} in
      (vicmd)      VI_MODE="%F{23}%K{231}%B COMMND %b%F{231}%K{166}$LDART" ;;
      (main|viins) VI_MODE="%F{22}%K{148}%B INSERT %b%F{148}%K{166}$LDART" ;;
      (*)          VI_MODE="%F{22}%K{148}%B INSERT %b%F{148}%K{166}$LDART" ;;
    esac
    zle reset-prompt
}

# setup prompt
PROMPT="
\$VI_MODE%F{220} %m %F{166}%K{31}\$LDART%F{231}%B \$SMILY %n %b%F{31}%K{240}\$LDART%F{252}%B \$DIRIC %3~ %b%F{240}\$vcs_info_msg_0_%k$LDART
\$(virtualenv_info)$LDART%f%k "
zle -N zle-line-init
zle -N zle-keymap-select

# setup keys
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key actions
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       history-beginning-search-backward
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     history-beginning-search-forward
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# zle only in application mode
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# general aliases
## ls
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias lsi='ls -ilah'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFl --group-directories-first'
alias tarls='tar -tvf'
## grep
alias sgrep='grep --color -i -n -r -s --exclude-dir=".git"'
alias sgrepy='sgrep --include="*.py"'
alias sgreph='sgrep --include="*.html"'
alias sgrepp='sgrep --include="*.php"'
alias sgrepj='sgrep --include="*.java"'
alias sgrepc='sgrep --include="*.c"'
alias sigrepy='sigrep --include="*.py"'
## git
alias gfetch="git fetch --prune"
alias gdelete='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gmerge="git merge --no-ff --no-commit"
alias gupdate="git pull origin master; gfetch; gdelete"
alias glogmaster="git log --oneline master..HEAD"
alias gdiffmaster="git diff master..HEAD"
alias gfilemaster="git log --oneline --name-status master..HEAD | grep '^[ADM]' | sort | uniq"
alias grstart="git checkout master; gupdate; git checkout -b release"
alias grmaster="git checkout master; gmerge release; git commit"
## other
alias dfs='df --total -hx tmpfs -x devtmpfs'
alias findfile='find . -name '
alias rm='rm -i'
alias sdig='dig +noall +answer'
function udig() { echo $1 | awk -F/ '{print $3}' | awk -F':' '{print $1}' | xargs dig }
alias view='vim -R'
alias xsel='xsel -l $HOME/.local/log/xsel.log'
alias webshare='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

# special aliases
#  Transforms Markdown to Man pages with pandoc
function md2man () { pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less }
#  Use ncurses for gpg on zsh
function pass_cmd () {
    sed -i -e "s/gtk-2/curses/g" $HOME/.gnupg/gpg-agent.conf
    echo RELOADAGENT | gpg-connect-agent
    /usr/bin/pass "$@"
    sed -i -e "s/curses/gtk-2/g" $HOME/.gnupg/gpg-agent.conf
    echo RELOADAGENT | gpg-connect-agent
}
alias pass='pass_cmd'
#  Convert file to qrcode
qrdecode() { zbarimg -S\*.disable -Sqrcode.enable "$1" -q | sed '1s/^[^:]\+://'; }

cp_p()
{
   # https://chris-lamb.co.uk/posts/can-you-get-cp-to-give-a-progress-bar-like-wget
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# SSH keychain
which keychain &>/dev/null 2>&1 && eval $(keychain --dir $HOME/.cache/keychain --nogui --eval --agents ssh -Q --quiet --ignore-missing id_rsa)

# general exported variables
export DISPLAY=:0
export EDITOR=vim
export LESSHISTFILE=$HOME/.local/history/lesshst
export PSQLRC=$HOME/.config/psql/psqlrc
export MYSQL_HISTFILE=$HOME/.local/history/mysqlhst
export REDISCLI_HISTFILE=$HOME/.local/history/redisclihst
export XDG_CACHE_HOME=$HOME/.cache
export PYTHONSTARTUP=$HOME/.config/python/startup.py
export IPYTHONDIR=$HOME/.config/ipython

# OS specific paths
export JAVA_HOME=/usr/lib/jvm/default
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
export PATH="$HOME/node_modules/.bin:$PATH"

# virtualenvwrapper
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/virtualenvs

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

# import extra zsh config
[ -r $HOME/.zshrc.extra ] && source $HOME/.zshrc.extra

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tmux config
if which tmux 2>&1 >/dev/null && [ "$TERM" != "screen-256color" ]; then
    export DISABLE_AUTO_TITLE=true
    test -z "$TMUX" && (tmux attach || tmux)
    #test -n "$TMUX" && ssh() {
    #    tmux rename-window "$(echo $* | cut -d . -f 1)"
    #    command ssh "$@"
    #    tmux set-window-option automatic-rename "on" 1>/dev/null
    #}
fi
