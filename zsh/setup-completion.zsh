autoload -Uz compinit && compinit
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

[ -f /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)

[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOME/.zsh/auto-complete-google-cloud-sdk.zsh ] && source $HOME/.zsh/auto-complete-google-cloud-sdk.zsh
[ -f $HOME/.zsh/auto-complete-helm.zsh ] && source $HOME/.zsh/auto-complete-helm.zsh
[ -f $HOME/.zsh/auto-complete-terraform.zsh ] && source $HOME/.zsh/auto-complete-terraform.zsh
