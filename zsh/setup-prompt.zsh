SPACESHIP_BATTERY_SHOW=false # disabled because acpi -b is slow

SPACESHIP_AWS_SHOW=false
SPACESHIP_AZURE_SHOW=false
SPACESHIP_DOCKER_SHOW=false
SPACESHIP_GCLOUD_SHOW=false
SPACESHIP_GOLANG_SHOW=false
SPACESHIP_KUBECTL_CONTEXT_SHOW_NAMESPACE=false
SPACESHIP_KUBECTL_CONTEXT_SHOW=false
SPACESHIP_KUBECTL_SHOW=false
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_PACKAGE_SHOW=false

SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_HOST_SHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_TIME_SHOW=false
SPACESHIP_USER_SHOW=false

SPACESHIP_AWS_SYMBOL='  '
SPACESHIP_GIT_SYMBOL=' '
SPACESHIP_KUBECTL_SYMBOL='⛒ '
SPACESHIP_VENV_SYMBOL=' '

SPACESHIP_KUBECTL_COLOR=green
SPACESHIP_VI_MODE_COLOR=green

function kctxshow () {
  if ( $SPACESHIP_KUBECTL_CONTEXT_SHOW ); then
    export SPACESHIP_KUBECTL_CONTEXT_SHOW=false
  else
    export SPACESHIP_KUBECTL_CONTEXT_SHOW=true
  fi
}

autoload -Uz promptinit && promptinit
[ -f $HOME/.zsh/spaceship-prompt/spaceship.zsh ] && source $HOME/.zsh/spaceship-prompt/spaceship.zsh
[ -f $HOME/.zsh/spaceship-vi-mode/spaceship-vi-mode.plugin.zsh ] && source $HOME/.zsh/spaceship-vi-mode/spaceship-vi-mode.plugin.zsh
spaceship add --before char vi_mode
eval spaceship_vi_mode_enable

export BAT_THEME="Solarized (light)"

# e in vis mode will open command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd e edit-command-line

function zsh_prompt_small () {
    SPACESHIP_HOST_SHOW=false
    SPACESHIP_KUBECTL_CONTEXT_SHOW=false
    SPACESHIP_KUBECTL_SHOW=false
    SPACESHIP_TIME_SHOW=false
    SPACESHIP_GIT_SHOW=false
    SPACESHIP_DIR_TRUNC_REPO=false
}
function zsh_prompt_git () {
    SPACESHIP_HOST_SHOW=false
    SPACESHIP_KUBECTL_CONTEXT_SHOW=false
    SPACESHIP_KUBECTL_SHOW=false
    SPACESHIP_TIME_SHOW=false
    SPACESHIP_GIT_SHOW=true
    SPACESHIP_DIR_TRUNC_REPO=true
}
