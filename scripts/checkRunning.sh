#!/bin/sh
SERVICE='spotify'
SERVICE2='ncmpcpp'

function quit_message
{
	echo "Usage: `basename $0` {play|pause|playpause|next|previous|stop}"
	exit 1
}


if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    
case "$1" in
        play)
		sh ~/Scripts/spotify-remote.sh play
                ;;
        pause)
	    sh ~/Scripts/spotify-remote.sh pause
	            ;;
        playpause)
		sh ~/Scripts/spotify-remote.sh playpause
                ;;
        next)
	    sh ~/Scripts/spotify-remote.sh next
                ;;
        previous)
        sh ~/Scripts/spotify-remote.sh previous
                ;;
        stop)
        sh ~/Scripts/spotify-remote.sh stop
                ;;
        *)
                echo -e "Bad argument.\n"
                quit_message
                ;;
esac

else
    echo "$SERVICE is not running"

    if ps ax | grep -v grep | grep $SERVICE2 > /dev/null
    then
        case "$1" in
            play)
		    mpc play
                ;;
            pause)
	        mpc pause
	            ;;
            playpause)
            mpc toggle    
                ;;
            next)
            mpc stop     
                ;;
            previous)
            mpc prev       
                ;;
            stop)
            mpc stop 
                ;;
            *)
                echo -e "Bad argument.\n"
                quit_message
                ;;
    esac

    else
        echo "$SERVICE2 is not running"
    fi
fi
