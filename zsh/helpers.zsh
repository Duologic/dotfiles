## ls
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll='ls --time-style=long-iso --sort=time -h -l -F -A'
alias l='ll -o'
alias tarls='tar -tvf'

## watch
alias watch='watch '

## grep
alias sgrep='grep --color -i -n -r -s --exclude-dir=".git"'

## Opens first rg match in vim and put cursor at linenumber
function rgvim() {
  INPUT=$(rg --line-number $@ | head -1)

  filename=$(echo $INPUT|awk -F':' '{ print $1 }')
  linenumb=$(echo $INPUT|awk -F':' '{ print $2 }')

  vim +$linenumb $filename
}

# vimln file.name:line:col
function vimln() {
  INPUT=$@

  filename=$(echo $INPUT|awk -F':' '{ print $1 }')
  linenumb=$(echo $INPUT|awk -F':' '{ print $2 }')
  colnumb=$(echo $INPUT|awk -F':' '{ print $3 }')

  vim -c $linenumb'norm '$colnumb'|' $filename
}

## other
alias dfs='df --total -hx tmpfs -x devtmpfs'
alias findfile='find . -name '
alias rm='rm -i'
alias sdig='dig +noall +answer'
function udig() { echo $1 | awk -F/ '{print $3}' | awk -F':' '{print $1}' | xargs dig }
alias view='vim -R'
alias xsel='xsel -l $HOME/.local/log/xsel.log'
#alias webshare='python2.7 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias webshare='docker run -v "$PWD":"/usr/local/apache2/htdocs" -p 0.0.0.0:8080:80 httpd:2.4-alpine'
alias battery='echo $(cat /sys/class/power_supply/BAT0/capacity)\% $(cat /sys/class/power_supply/BAT0/status)'

# tools
# Transforms Markdown to Man pages with pandoc
function md2man () { pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less -S }
# Convert file to qrcode
function qrdecode() { zbarimg -S\*.disable -Sqrcode.enable "$1" -q | sed '1s/^[^:]\+://'; }
function mov2gif (){ ffmpeg -i "${1}" -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "${2}" }

# set Tmux pane title
tmux_rename_pane() { printf "\033]2;$1\033\\" }

# k8s
alias k9x='kubectx && k9s'
kubectx () {
  export SPACESHIP_KUBECONTEXT_SHOW=true
  /usr/bin/kubectx $1
}
k3d_set_context () {
  export KUBECONFIG="$(k3d get-kubeconfig --name=$1):$HOME/.kube/config"
  export SPACESHIP_KUBECONTEXT_SHOW=true
  kubectx $1
}

# ascii fun
alias maps='telnet mapscii.me'
alias wttr='curl -s "wttr.in?T&0"'
alias watchwttr='watch curl -s "wttr.in\?T\&0"'

# for `gh`
export GLAMOUR_STYLE=light
