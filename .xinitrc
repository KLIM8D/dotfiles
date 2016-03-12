#!#/bin/sh
#
# ~/.xinitrc
#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

setxkbmap dk

# enable restart X
setxkbmap -option terminate:ctrl_alt_bksp

#xrandr --dpi 168 &
#FF 1.5 pixels
# start pulseaudio
/usr/bin/start-pulseaudio-x11

# start dbus, for thunar trash
#source /etc/X11/xinit/xinitrc.d/30-dbus.sh

# load .Xresources
xrdb -merge $HOME/.Xresources

case $1 in
        openbox) exec openbox-session;;
	bspwm) 
		sxhkd & 
		urxvt &
		exec bspwm
		;;
        i3) exec i3;;
        *) exec i3;;
esac
