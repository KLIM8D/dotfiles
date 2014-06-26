#! /usr/bin/env python

from urllib import request
import json as simplejson
import sys

data_source = 'https://api.kraken.com/0/public/Ticker?pair=XXBTZEUR'
req = request.Request(data_source, None, {'user-agent': 'text/json'})

opener = request.build_opener()
f = opener.open(req).read().decode("utf-8")
data = simplejson.loads(f)

if sys.argv[1] == "price":
    price = data['result']['XXBTZEUR']['c'][0]
    print("{0:.2f}".format(float(price)))
elif sys.argv[1] == "high":
    high = data['result']['XXBTZEUR']['h'][0]
    print("{0:.2f}".format(float(high)))
elif sys.argv[1] == "low":
    low = data['result']['XXBTZEUR']['l'][0]
    print("{0:.2f}".format(float(low)))
elif sys.argv[1] == "vol":
    volume = data['result']['XXBTZEUR']['v'][1]
    print("{0:.2f}".format(float(volume)))
