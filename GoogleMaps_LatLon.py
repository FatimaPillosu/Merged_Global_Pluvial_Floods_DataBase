import googlemaps

KEY_API='' # Set here your google key api from "Google Cloud Platform".

gmaps_key = googlemaps.Client(key=KEY_API)

# Geocoding an address
geocode_result = gmaps_key.geocode('RG67PG')

# Extract Lat/lon
lat = geocode_result[0]['geometry']['location']['lat']
lon = geocode_result[0]['geometry']['location']['lng']

print(lat)
print(lon)
