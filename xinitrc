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
[[ -f ~/.config/X11/Xresources ]] && xrdb -merge -I$HOME ~/.config/X11/Xresources

# Configure keyboard and mouse
setxkbmap -layout us -variant altgr-intl
setxkbmap -option caps:escape
[ -r $HOME/.config/X11/Xmodmap ] && xmodmap $HOME/.config/X11/Xmodmap
xinput set-prop 11 316 1

# Sync clipboards
#autocutsel -fork
#autocutsel -selection PRIMARY -fork
#autocutsel -selection CLIPBOARD -fork

# Use slock to lock screen
xss-lock slock &

# Config variable for opening Java apps in Awesome
#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING

#systemctl --user start streamdeckd.path

# Turn off middle mouse button on scroll mouse
xinput set-button-map $(xinput list --id-only "Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)") 1 0 3

# Start Awesome window manager
exec awesome
