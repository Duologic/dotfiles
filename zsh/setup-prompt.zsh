autoload -Uz promptinit && promptinit
[ -f $HOME/.zsh/spaceship-prompt/spaceship.zsh ] && source $HOME/.zsh/spaceship-prompt/spaceship.zsh

SPACESHIP_PROMPT_ASYNC=true
SPACESHIP_GIT_SYMBOL=' '
SPACESHIP_VENV_SYMBOL=' '
SPACESHIP_PROMPT_ORDER=(
  time           # Time stamps section
  user           # Username section
  dir            # Current directory section
  git            # Git section (git_branch + git_status)
  venv           # virtualenv section
  exec_time      # Execution time
  line_sep       # Line break
  jobs           # Background jobs indicator
  exit_code      # Exit code section
  sudo           # Sudo indicator
  char           # Prompt character
)

[ -f $HOME/.zsh/spaceship-vi-mode/spaceship-vi-mode.plugin.zsh ] && source $HOME/.zsh/spaceship-vi-mode/spaceship-vi-mode.plugin.zsh

SPACESHIP_VI_MODE_COLOR=green
spaceship add --before char vi_mode
eval spaceship_vi_mode_enable

export BAT_THEME="Solarized (light)"

# e in vis mode will open command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd e edit-command-line
