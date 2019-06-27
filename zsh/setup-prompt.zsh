SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_USER_SHOW=false
SPACESHIP_HOST_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=false

function toggle_kubecontext () {
  if ( $SPACESHIP_KUBECONTEXT_SHOW ); then
    export SPACESHIP_KUBECONTEXT_SHOW=false
  else
    export SPACESHIP_KUBECONTEXT_SHOW=true
  fi
}

autoload -Uz promptinit && promptinit
[ -f $HOME/.zsh/spaceship-prompt/spaceship.zsh ] && source $HOME/.zsh/spaceship-prompt/spaceship.zsh
spaceship_vi_mode_enable

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
[ -r $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f $HOME/.zsh/zsh-vimode-visual/zsh-vimode-visual.zsh ] && source $HOME/.zsh/zsh-vimode-visual/zsh-vimode-visual.zsh
