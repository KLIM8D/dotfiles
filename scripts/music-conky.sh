#! /bin/bash

SERVICE='spotify'
SERVICE2='ncmpcpp'

if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    ARTIST=`sh ~/Scripts/spotify-nowplaying.sh artist`
    TITLE=`sh ~/Scripts/spotify-nowplaying.sh title`
    echo -e "{ \"full_text\" : \"♪\", \"color\" : \"\#EEE8D5\", \"separator\" : false, \"separator_block_width\" : 3 }, { \"full_text\" : \"$ARTIST - $TITLE\", \"color\" : \"\#268BD2\", \"min_width\" : 300, \"separator\" : false, \"separator_block_width\" : 10 },"
else
    if ps ax | grep -v grep | grep $SERVICE2 > /dev/null
    then
        echo -e "{ \"full_text\" : \"♪\", \"color\" : \"\#EEE8D5\", \"separator\" : false, \"separator_block_width\" : 3 }, { \"full_text\" : \"\${\$mpd_artist 20} - \${\$mpd_titleE 30}\", \"color\" : \"\#268BD2\", \"min_width\" : 300, \"separator\" : false, \"separator_block_width\" : 10 },"
    fi
fi
