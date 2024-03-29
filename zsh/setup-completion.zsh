autoload -Uz compinit && compinit
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

[ -d $HOME/.zsh/zsh-completions ] && fpath=($HOME/.zsh/zsh-completions $fpath)
[ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)

[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOME/.zsh/auto-complete-google-cloud-sdk.zsh ] && source $HOME/.zsh/auto-complete-google-cloud-sdk.zsh
[ -f $HOME/.zsh/auto-complete-helm.zsh ] && source $HOME/.zsh/auto-complete-helm.zsh
[ -f $HOME/.zsh/auto-complete-terraform.zsh ] && source $HOME/.zsh/auto-complete-terraform.zsh
[ -f $HOME/.zsh/auto-complete-tanka.zsh ] && source $HOME/.zsh/auto-complete-tanka.zsh

if [ -f $HOME/.zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh ]; then
    source $HOME/.zsh/fzf-tab-completion/zsh/fzf-zsh-completion.sh
    bindkey '^I' fzf_completion
    zstyle ':completion:*' fzf-search-display true
    zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'
    zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'

fi
