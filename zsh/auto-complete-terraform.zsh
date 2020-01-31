if command -v terraform > /dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C $(which terraform) terraform
fi
