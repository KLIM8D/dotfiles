#!/usr/bin/env python3
#
# A battery indicator blocklet script for i3blocks

from subprocess import check_output

status = check_output(['acpi'], universal_newlines=True)
state = status.split(": ")[1].split(", ")[0]
commasplitstatus = status.split(", ")
percentleft = int(commasplitstatus[1].rstrip("%\n"))

FA_LIGHTNING = "\uf0e7"
FA_PLUG = "\uf1e6"

fulltext = "<span color='#BA2020'>{}</span>".format(FA_LIGHTNING)
timeleft = ""

if state == "Discharging":
    time = commasplitstatus[-1].split()[0]
    time = ":".join(time.split(":")[0:2])
    timeleft = " ({})".format(time)
else:
    fulltext += " " + FA_PLUG


def color(percent):
    if percent < 10:
        return "#FF0000"
    if percent < 20:
        return "#FF3300"
    if percent < 30:
        return "#FF6600"
    if percent < 40:
        return "#FF9900"
    if percent < 50:
        return "#FFCC00"
    if percent < 60:
        return "#FFFF00"
    if percent < 70:
        return "#FFFF33"
    if percent < 80:
        return "#FFFF66"
    return "#A0A0A0"

form = ' <span color="{}">{}%</span>'
fulltext += form.format(color(percentleft), percentleft)
fulltext += timeleft

print(fulltext)
print(fulltext)
