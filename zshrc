# tty config
# no-op to force push
stty -ixon
ttyctl -f

# options
setopt AUTO_CD EXTENDED_GLOB NOTIFY COMPLETE_ALIASES
unsetopt BEEP

# general exported variables
export DISPLAY=:0
export EDITOR=nvim
#export PAGER='less --mouse --wheel-lines=5'
#export MANPAGER='less --mouse --wheel-lines=5'
export XDG_CACHE_HOME=$HOME/.cache
export JAVA_HOME=/usr/lib/jvm/default
export GOPATH=$HOME/gocode
export LC_ALL=en_US.UTF-8

# History files
HISTFILE=$HOME/.local/history/zhst
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
export LESSHISTFILE=$HOME/.local/history/lesshst
export PSQLRC=$HOME/.config/psql/psqlrc
export MYSQL_HISTFILE=$HOME/.local/history/mysqlhst
export REDISCLI_HISTFILE=$HOME/.local/history/redisclihst

# Export PATHs
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/node_modules/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH" # Gettext path on macOS for Django i18n
export PATH="/usr/local/kubebuilder/bin:$PATH"

[ -f $HOME/.do ] && source $HOME/.do # Exports Digital Ocean keys

[ -f $HOME/.zsh/setup-keys.zsh ] && source $HOME/.zsh/setup-keys.zsh
[ -f $HOME/.zsh/setup-completion.zsh ] && source $HOME/.zsh/setup-completion.zsh
[ -f $HOME/.zsh/setup-prompt.zsh ] && source $HOME/.zsh/setup-prompt.zsh
[ -f $HOME/.zsh/setup-keychain.zsh ] && source $HOME/.zsh/setup-keychain.zsh
[ -f $HOME/.zsh/setup-python-virtualenv.zsh ] && source $HOME/.zsh/setup-python-virtualenv.zsh
[ -f $HOME/.zsh/setup-dotenv.zsh ] && source $HOME/.zsh/setup-dotenv.zsh
[ -f $HOME/.zsh/helpers.zsh ] && source $HOME/.zsh/helpers.zsh
[ -f $HOME/.zsh/auto-start-tmux.zsh ] && source $HOME/.zsh/auto-start-tmux.zsh
[ -f $HOME/.zsh/setup-history-search.zsh ] &&  source $HOME/.zsh/setup-history-search.zsh

alias oldvim=/usr/bin/vim
alias vim=/usr/bin/nvim
alias vimdiff='/usr/bin/nvim -d'
