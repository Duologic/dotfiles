[ -d $HOME/.zsh/zsh-completions ] && fpath=($HOME/.zsh/zsh-completions $fpath)
[ -d /usr/local/share/zsh-completions ] && fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit && compinit
zstyle :compinstall filename '$HOME/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOME/.zsh/auto-complete-google-cloud-sdk.zsh ] && source $HOME/.zsh/auto-complete-google-cloud-sdk.zsh
[ -f $HOME/.zsh/auto-complete-helm.zsh ] && source $HOME/.zsh/auto-complete-helm.zsh
[ -f $HOME/.zsh/auto-complete-terraform.zsh ] && source $HOME/.zsh/auto-complete-terraform.zsh
[ -f $HOME/.zsh/auto-complete-tanka.zsh ] && source $HOME/.zsh/auto-complete-tanka.zsh

if [ -f $HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh ]; then
    source $HOME/.zsh/fzf-tab/fzf-tab.plugin.zsh

    zstyle ':fzf-tab:*' default-color $'\033[30m'
    zstyle ':fzf-tab:*' fzf-flags --color=light

    export FZF_PREVIEW_LINES=25
    local script='
    if [ -f "$realpath" ]; then
        bat --style snip --color always -r0:25 $realpath
    else
        tree -C $realpath
    fi'
    # plain text files/directories
    zstyle ':fzf-tab:complete:(l|ll|ls|cd|cat|bat|vim):*' fzf-preview $script
    # git
    zstyle ':fzf-tab:complete:git-stash-pop:*' fzf-preview 'git stash show --color=always -p $word'
    # env variables
    zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
    # systemctl
    zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
    # arguments and options
    zstyle ':fzf-tab:complete:*:options' fzf-preview
    zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
fi

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

[ -f /usr/share/1pass/fuzzpass.sh ] && source /usr/share/1pass/fuzzpass.sh
