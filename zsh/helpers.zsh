## ls
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias lsi='ls -ilah'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFl'
alias tarls='tar -tvf'

## grep
alias sgrep='grep --color -i -n -r -s --exclude-dir=".git"'
alias sgrepy='sgrep --include="*.py"'
alias sgreph='sgrep --include="*.html"'
alias sgrepp='sgrep --include="*.php"'
alias sgrepj='sgrep --include="*.java"'
alias sgrepc='sgrep --include="*.c"'

## Opens first rg match in vim and put cursor at linenumber
function rgvim() {
  INPUT=$(rg --line-number $@ | head -1)

  filename=$(echo $INPUT|awk -F':' '{ print $1 }')
  linenumb=$(echo $INPUT|awk -F':' '{ print $2 }')

  vim +$linenumb $filename
}

## git
alias grebase="git fetch origin master && git rebase origin/master"
alias gfetch="git fetch --prune"
alias gdelete='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias gupdate="git pull origin master; gfetch; gdelete"
alias glogmaster="git log --oneline master..HEAD"
alias gdiffmaster="git diff master..HEAD"
alias gfilemaster="git diff --name-only master HEAD"
function gmkbranch { git checkout -b $(date +%Y%m%d)_$1 }

## other
alias dfs='df --total -hx tmpfs -x devtmpfs'
alias findfile='find . -name '
alias rm='rm -i'
alias sdig='dig +noall +answer'
function udig() { echo $1 | awk -F/ '{print $3}' | awk -F':' '{print $1}' | xargs dig }
alias view='vim -R'
alias xsel='xsel -l $HOME/.local/log/xsel.log'
alias webshare='python2.7 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias battery='echo $(cat /sys/class/power_supply/BAT0/capacity)\% $(cat /sys/class/power_supply/BAT0/status)'
alias watchgitstatus='watch -c git -c color.ui=always status'
alias maps='telnet mapscii.me'

# special aliases
#  Transforms Markdown to Man pages with pandoc
function md2man () { pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less -S }
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

mov2gif (){
  ffmpeg -i "${1}" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "${2}"
}

# Source: https://github.com/jessfraz/dotfiles/blob/a7fd3df6ab423e6dd04f27727f653753453db837/.dockerfunc#L8-L11
dcleanup(){
  docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}
dtop(){
   watch 'docker ps -a && printf %"$COLUMNS"s |tr " " "-" && docker container ls -a && printf %"$COLUMNS"s |tr " " "-" && docker image ls -a'
}
fluxtop(){
  watch "fluxctl --k8s-fwd-ns flux list-workloads -a | cut -c -$(tput cols)"
}
kpodtop(){
  watch kubectl get pods -A -o wide --sort-by={.spec.nodeName}
}

tfplansummarize (){
  terraform show -no-color "$1" | grep '^-\|^ *[~+-<]'
}

gcloud_cpu_limits (){
  watch "gcloud compute regions describe us-central1 --project "$1" | grep -A1 -B1 :\ CPUS"
}

decode_k8s_secret (){
  awk -F':' '{ print $2 }' | base64 -D
}

kubectx () {
  export SPACESHIP_KUBECONTEXT_SHOW=true
  /usr/bin/kubectx $1
}
k3d_set_context () {
  export KUBECONFIG="$(k3d get-kubeconfig --name=$1):$HOME/.kube/config"
  export SPACESHIP_KUBECONTEXT_SHOW=true
  kubectx $1
}

alias wttr='curl -s "wttr.in?T&0"'
alias watchwttr='watch curl -s "wttr.in\?T\&0"'
alias watch='watch '
httpstatuses () { links "https://httpstatuses.com/$1" }

export KUBECTL_EXTERNAL_DIFF=icdiff-kubectl
alias k9x='kubectx && k9s'

# for `gh`
export GLAMOUR_STYLE=light

# set up a window for a git project in tmux
function gitwindow() {
    NAME=$1
    PROJ=$2

    tmux new-window -c $PROJ -n $NAME
    sleep 1
    tmux split-window -c $PROJ -t $NAME -h
    tmux split-window -c $PROJ -t $NAME
    tmux send-keys -t 2 'watchgitstatus'
    tmux send-keys -t 2 Enter
    tmux send-keys -t 1 'cd . && clear'
    tmux send-keys -t 1 Enter
    tmux send-keys -t 0 'cd . && clear'
    tmux send-keys -t 0 Enter
}

