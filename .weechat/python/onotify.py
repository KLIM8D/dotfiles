#!/usr/bin/env python
# encoding: utf-8
# to read the notifications from your local machine use something like this:
# ssh user@host.tld ": > ~/.weechat/onotify.log ; tail -f -q -s 2 ~/.weechat/onotify.log" | while read message; do notify-send "Weechat" "${message}"; done

import os.path
import weechat

SCRIPT_NAME    = 'onotify'
SCRIPT_AUTHOR  = 'Ole Bergmann <ole@ole.im>'
SCRIPT_VERSION = '0.1'
SCRIPT_LICENSE = 'BSD'
SCRIPT_DESC    = 'Catches highlights and outputs to file'

OLOG_FILE = 'onotify.log'

def hook_notify(data, buffer, date, tags, displayed, highlight, prefix, message):
    if int(highlight)==1 or 'notify_private' in tags:
        line = '{0} | {1}\n'.format(prefix, message)
        with open(OLOG_FILE, 'a') as f:
            f.write(line)
    return weechat.WEECHAT_RC_OK

if __name__ == '__main__':

    if weechat.register(SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE, SCRIPT_DESC, '', ''):
        OLOG_FILE = os.path.join(weechat.info_get('weechat_dir', ''), OLOG_FILE)
        weechat.hook_print('', 'notify_message,notify_private', '', 1, 'hook_notify', '')