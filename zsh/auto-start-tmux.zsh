if xset q > /dev/null 2>&1; then
  if which tmux 2>&1 >/dev/null && [ "$TERM" != "screen-256color" ]; then
      export DISABLE_AUTO_TITLE=true
      test -z "$TMUX" && (tmux attach || tmux)
  fi
fi
