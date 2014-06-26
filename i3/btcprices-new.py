#! /usr/bin/env python

from urllib import request
import json as simplejson
import sys

data_source = 'https://api.kraken.com/0/public/Ticker?pair=XXBTZEUR'
req = request.Request(data_source, None, {'user-agent': 'text/json'})

opener = request.build_opener()
f = opener.open(req).read().decode("utf-8")
data = simplejson.loads(f)

text = ""
for arg in sys.argv:
    if arg == "price":
        price = float(data['result']['XXBTZEUR']['c'][0])
        text += "{{\"full_text\":\"Now\",\"color\":\"\#888888\",\"separator\":false,\"separator_block_width\":6}},\
{{\"full_text\":\"{0:.2f}\",\"color\":\"\#EEEEEE\",\"separator\":false}},".format(price)
    elif arg == "high":
        high = float(data['result']['XXBTZEUR']['h'][0])
        text += "{{\"full_text\":\"High\",\"color\":\"#888888\",\"separator\":false,\"separator_block_width\":6}}, \
{{\"full_text\":\"{0:.2f}\",\"color\":\"#AAF096\",\"separator\":false}},".format(high)
    elif arg == "low":
        low = float(data['result']['XXBTZEUR']['l'][0])
        text += "{{\"full_text\":\"Low\",\"color\":\"#888888\",\"separator\":false,\"separator_block_width\":6}}, \
{{\"full_text\":\"{0:.2f}\",\"color\":\"#FF3333\",\"separator\":false}},".format(low)
    elif arg == "vol":
        volume = float(data['result']['XXBTZEUR']['v'][0])
        text += "{{\"full_text\":\"Vol\",\"color\":\"#888888\",\"separator\":false,\"separator_block_width\":6}}, \
{{\"full_text\":\"{0:.2f}\",\"color\":\"#F0DC64\",\"separator\":false}},".format(volume)

print(text)
