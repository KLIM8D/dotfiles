#! /usr/bin/env python

from urllib import request
import json as simplejson
import sys

data_source = 'https://api.kraken.com/0/public/Ticker?pair=ETHEUR'
req = request.Request(data_source, None, {'user-agent': 'text/json'})

opener = request.build_opener()
f = opener.open(req).read().decode("utf-8")
data = simplejson.loads(f)

if sys.argv[1] == "price":
    price = data['result']['XETHZEUR']['c'][0]
    print("{0:.2f}".format(float(price)))
elif sys.argv[1] == "high":
    high = data['result']['XETHZEUR']['h'][0]
    print("{0:.2f}".format(float(high)))
elif sys.argv[1] == "low":
    low = data['result']['XETHZEUR']['l'][0]
    print("{0:.2f}".format(float(low)))
elif sys.argv[1] == "vol":
    volume = data['result']['XETHZEUR']['v'][0]
    print("{0:.2f}".format(float(volume)))
