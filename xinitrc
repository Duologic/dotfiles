#!/usr/bin/sh

# Run system-wide xinitrc
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Add fonts in X
xset +fp /usr/share/fonts/noto
xset fp rehash
xset -dpms
xset s off

# Scale X resources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Configure keyboard and mouse
setxkbmap -layout us -variant altgr-intl
[ -r $HOME/.Xmodmap ] && xmodmap $HOME/.Xmodmap
xinput set-prop 11 316 1

# Sync clipboards
autocutsel -fork
#autocutsel -selection PRIMARY -fork
autocutsel -selection CLIPBOARD -fork

# Use slock to lock screen
xss-lock slock &

# Config variable for opening Java apps in Awesome
_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING

# Start Awesome window manager
exec awesome
