#!#/bin/sh
#
# ~/.xinitrc
setxkbmap dk

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp

# start pulseaudio
/usr/bin/start-pulseaudio-x11

# start dbus, for thunar trash
source /etc/X11/xinit/xinitrc.d/30-dbus

# load .Xresources
xrdb -merge $HOME/.Xresources

case $1 in
        openbox) exec openbox-session;;
        i3) exec i3;;
        *) exec i3;;
esac
