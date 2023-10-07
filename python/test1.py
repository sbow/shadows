# slightly more Pythonic, cleaner version
from csv import DictReader
import requests
import webbrowser
USGS_URL = 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.csv'
GMAPS_URL = 'https://maps.googleapis.com/maps/api/staticmap'
# get the USGS data, create a list of lines
lines = requests.get(USGS_URL).text.splitlines()

# get the latitude/longitude pairs
# note: "latitude" and "longitude" are column headers in CSV :D
coordinate_pairs = ["%s,%s" % (q['latitude'], q['longitude']) for q in DictReader(lines)]

# this is another way of serializing the URL
preq = requests.PreparedRequest()
preq.prepare_url(GMAPS_URL, {'size':'800x500', 'markers': coordinate_pairs, 'key': 'AIzaSyAoJwbpcHvfDG7XlNYxh2JOmTl1lQBDwcU'})
webbrowser.open(preq.url)

spin = 1