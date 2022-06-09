#!~/venv38/bin python3

"""A points on map script"""

import googlemaps
from datetime import datetime

# load googlemaps API key from file:
with open('apikey.txt') as f:
    api_key = f.readline()

# setup googlemaps api:
gmaps = googlemaps.Client(key=api_key)

# get lat lon of location using geocode api
loc1 = gmaps.geocode('1860 N Maple Rd, Ann Arbor, MI')
loc2 = gmaps.geocode('Lab Cafe, Ann Arbor, MI')

# get directions using map
now = datetime.now()
directions = gmaps.directions('1860 N Maple Rd, ann arbor, Mi', 'Lab Cafe, ANn ARbor, MI', mode='bicycling', departure_time=now)

spin = 1