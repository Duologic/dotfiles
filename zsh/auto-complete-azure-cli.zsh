if command -v az > /dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  eval "$(register-python-argcomplete az)"
fi
