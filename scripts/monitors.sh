#!/bin/bash

CONF="/home/klim/.i3/config"
XINIT="/home/klim/.xinitrc"

case "$3" in
    "high")
        sed -i '21 s/^/#/' $CONF
        sed -i '20 s/#//' $CONF

        sed -i '35 s/^/#/' $CONF
        sed -i '34 s/#//' $CONF

        sed -i '42 s/^/#/' $CONF
        sed -i '41 s/#//' $CONF

        sed -i '48 s/^/#/' $CONF
        sed -i '47 s/#//' $CONF

        sed -i '9 s/#//' $XINIT
        ;;
    "low")
        sed -i '20 s/^/#/' $CONF
        sed -i '21 s/#//' $CONF

        sed -i '34 s/^/#/' $CONF
        sed -i '35 s/#//' $CONF

        sed -i '41 s/^/#/' $CONF
        sed -i '42 s/#//' $CONF

        sed -i '47 s/^/#/' $CONF
        sed -i '48 s/#//' $CONF

        sed -i '9 s/^/#/' $XINIT
        ;;
    *)
        ;;
esac

xrandr --screen 0 --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
case $1 in
    1)
        if [ "$2" = "laptop" ]
        then
            xrandr --addmode eDP1 1920x1080_60.00
            xrandr --output eDP1 --mode 1920x1080_60.00
        elif [ "$2" = "ex" ]
        then
            xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --off --output VGA1 --off
        else
            echo "Bad 2. argument"
        fi
        ;;

    2)
        if [ "$2" = "laptop" ]
        then
            xrandr --addmode eDP1 1920x1080_60.00
            xrandr --output eDP1 --mode 1920x1080_60.00
            xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080_60.00 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output VGA1 --off
        elif [ "$2" = "ex" ]
        then
            xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VGA1 --off

        elif [ "$2" = "vert" ]
        then
            xrandr --output VIRTUAL1 --off --output eDP1 --off --output DP1 --off --output HDMI2 --primary --mode 1920x1080 --pos 0x384 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate left --output VGA1 --off
        else
            echo "Bad 2. argument\n"
        fi
        ;;

    3)
        xrandr --addmode eDP1 1920x1080_60.00
        xrandr --output eDP1 --mode 1920x1080_60.00
        xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP1 --off --output HDMI2 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VGA1 --off
        ;;

    *)
        echo "Bad 1. argument\n"
        ;;
esac
