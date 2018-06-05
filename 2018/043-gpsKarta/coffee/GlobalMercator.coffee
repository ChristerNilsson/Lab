# http://www.maptiler.org/google-maps-coordinates-tile-bounds-projection/

# class GlobalMercator
# 	constructor : (@tileSize=256) ->
# 		@initialResolution = 2 * Math.PI * 6378137 / @tileSize
# 		# 156543.03392804062 for tileSize 256 pixels
# 		@originShift = 2 * Math.PI * 6378137 / 2.0
# 		# 20037508.342789244

# 	LatLonToMeters : (lat, lon) ->
# 		# "Converts given lat/lon in WGS84 Datum to XY in Spherical Mercator EPSG:900913"

# 		mx = lon * @originShift / 180.0
# 		my = Math.log(Math.tan((90 + lat) * Math.PI / 360.0)) / (Math.PI / 180.0)
# 		my = my * @originShift / 180.0
# 		[mx, my]

# 	MetersToLatLon : (mx, my) ->
# 		# "Converts XY point from Spherical Mercator EPSG:900913 to lat/lon in WGS84 Datum"
# 		lon = (mx / @originShift) * 180.0
# 		lat = (my / @originShift) * 180.0
# 		lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180.0)) - Math.PI / 2.0)
# 		[lat, lon] 
