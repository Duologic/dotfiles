#!/usr/bin/sh

# Run system-wide xinitrc
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Add fonts in X
#xset +fp /usr/share/fonts/
xset fp rehash

# Configure Compose key
setxkbmap -option compose:ralt

# Scale X resources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Load Xmodmap
[ -r $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap

# Sync clipboards
autocutsel -fork
#autocutsel -selection PRIMARY -fork
autocutsel -selection CLIPBOARD -fork

# Config variable for opening Java apps in Awesome
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING

# Start Awesome window manager
exec awesome
