SPACESHIP_DOCKER_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_HOST_SHOW=true
SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=false
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_TIME_SHOW=true
SPACESHIP_USER_SHOW=false
SPACESHIP_VENV_SYMBOL=$'\xF0\x9F\x90\x8D '
SPACESHIP_AWS_SYMBOL=$'\xE2\x98\x81\xEF\xB8\x8F  '

function kctxshow () {
  if ( $SPACESHIP_KUBECONTEXT_SHOW ); then
    export SPACESHIP_KUBECONTEXT_SHOW=false
  else
    export SPACESHIP_KUBECONTEXT_SHOW=true
  fi
}

SPACESHIP_GOLANG_SHOW=false
autoload -Uz promptinit && promptinit
[ -f $HOME/.zsh/spaceship-prompt/spaceship.zsh ] && source $HOME/.zsh/spaceship-prompt/spaceship.zsh
spaceship_vi_mode_enable

#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
#[ -f $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export BAT_THEME="Solarized (light)"
