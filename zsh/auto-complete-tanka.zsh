if command -v tk > /dev/null 2>&1; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C $(which tk) tk
fi
