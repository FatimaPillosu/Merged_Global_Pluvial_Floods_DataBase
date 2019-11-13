import googlemaps
import sys

KEY_API = sys.argv[1]
print(KEY_API)

gmaps_key = googlemaps.Client(key=KEY_API)

# Geocoding an address
geocode_result = gmaps_key.geocode('RG67PG')

# Extract Lat/lon
lat = geocode_result[0]['geometry']['location']['lat']
lon = geocode_result[0]['geometry']['location']['lng']

print(lat)
print(lon)
