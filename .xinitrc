#!#/bin/sh
#
# ~/.xinitrc
setxkbmap dk
setxkbmap -option terminate:ctrl_alt_bksp
/usr/bin/start-pulseaudio-x11
#source /etc/X11/xinit/xinitrc.d/30-dbus
#exec ck-launch-session dbus-launch openbox-session
#exec dbus-launch openbox-session
# Here xfce is kept as default
case $1 in
        openbox) exec openbox-session;;
        i3) exec i3;;
        *) exec i3;;
esac
