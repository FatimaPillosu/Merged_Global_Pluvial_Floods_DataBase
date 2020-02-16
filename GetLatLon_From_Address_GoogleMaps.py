import googlemaps
import sys

KEY_API = sys.argv[1]
ADDRESS = sys.argv[2]

gmaps_key = googlemaps.Client(key=KEY_API)

# Geocoding an address
geocode_result = gmaps_key.geocode(ADDRESS)

# Extract Lat/lon
lat = geocode_result[0]['geometry']['location']['lat']
lon = geocode_result[0]['geometry']['location']['lng']

print("Address: " + ADDRESS)
print("Latitude: " + str(lat))
print("Longitude: " + str(lon))

