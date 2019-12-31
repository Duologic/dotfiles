if command -v terraform > /dev/null 2>&1; then
  complete -o nospace -C $(which terraform) terraform
fi
