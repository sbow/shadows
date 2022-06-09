#!/usr/bin/env python3

"""Ugly sock drawer - copy pasta"""
import googlemaps
from datetime import datetime

with open('apikey.txt') as f:
    api_key = f.readline()
    
gmaps = googlemaps.Client(key=api_key)

# Geocoding an address
geocode_result = gmaps.geocode('1600 Amphitheatre Parkway, Mountain View, CA')

# Look up an address with reverse geocoding
reverse_geocode_result = gmaps.reverse_geocode((40.714224, -73.961452))

# Request directions via public transit
now = datetime.now()
directions_result = gmaps.directions("Sydney Town Hall",
                                     "Parramatta, NSW",
                                     mode="transit",
                                     departure_time=now)

# Make a static map... don't know how to use
map =gmaps.static_map(center=(40.714,-73.999), zoom=12, size=(500,400),format='png8',maptype='satellite')

# Example url that adds markers
# https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=1200x1200&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:X%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyAoJwbpcHvfDG6XlNYxh2JOmTl1lQBDwcU
# Broken out:
# https://maps.googleapis.com/maps/api/staticmap?
#   center=Brooklyn+Bridge,New+York,NY
#   &zoom=13
#   &size=1200x1200
#   &maptype=roadmap
#   &markers=color:blue%7Clabel:S%7C40.702147,-74.015794
#   &markers=color:green%7Clabel:X%7C40.711614,-74.012318
#   &markers=color:red%7Clabel:C%7C40.718217,-73.998284
#   &key=AIzaSyAoJwbpcHvfDG6XlNYxh2JOmTl1lQBDwcU
#
# Info on setting marker style, including usig a "image" at a given url: suggest gen images w [0..9A..Z][][] 3 char code
# 64x64 pixels
# https://developers.google.com/maps/documentation/maps-static/start#ImageFormats
#   &markers=anchor:bottomright%7Cicon:https://bit.ly/3xjGpR1%7c40.702147,-74.015794
# https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=1200x1200&maptype=roadmap&markers=anchor:bottomright%7Cicon:https://bit.ly/3xjGpR1%7c40.702147,-74.015794&markers=color:green%7Clabel:X%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=AIzaSyAoJwbpcHvfDG6XlNYxh2JOmTl1lQBDwcU

import urllib.parse
url = 'https://maps.googleapis.com/maps/api/staticmap?'
params = {
    'center': 'Brooklyn+Bridge',
    'zoom': 13,
    'size': '1200x1200',
    'maptype': 'roadmap',
    'markers': 'color:blue%7C40.702147,-74.015794',
    'key' : api_key 
} 
print(url + urllib.parse.urlencode(params))

spin = 1