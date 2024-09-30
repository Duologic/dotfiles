if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi
if [ -d /opt/google-cloud-cli ]; then
  source /opt/google-cloud-cli/path.zsh.inc
  source /opt/google-cloud-cli/completion.zsh.inc
fi
