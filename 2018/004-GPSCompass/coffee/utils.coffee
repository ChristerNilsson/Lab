# http://www.ridgesolutions.ie/index.php/2013/11/14/algorithm-to-calculate-speed-from-two-gps-latitude-and-longitude-points-and-time-difference/
distance_on_geoid = (lat1, lon1, lat2, lon2) ->
 
	# Convert degrees to radians
	lat1 = lat1 * Math.PI / 180.0
	lon1 = lon1 * Math.PI / 180.0
 
	lat2 = lat2 * Math.PI / 180.0
	lon2 = lon2 * Math.PI / 180.0
 
	# radius of earth in metres
	r = 6378100
 
	# P
	rho1 = r * Math.cos lat1
	z1 = r * Math.sin lat1
	x1 = rho1 * Math.cos lon1
	y1 = rho1 * Math.sin lon1
 
	# Q
	rho2 = r * Math.cos lat2 
	z2 = r * Math.sin lat2
	x2 = rho2 * Math.cos lon2
	y2 = rho2 * Math.sin lon2
 
	# Dot product
	dot = x1 * x2 + y1 * y2 + z1 * z2
	cos_theta = dot / (r * r)
 
	theta = Math.acos cos_theta
 
	# Distance in Metres
	r * theta

# https://www.movable-type.co.uk/scripts/latlong.html
# calcHeading = (φ1,λ1,φ2,λ2) ->
# 	console.log φ1,λ1
# 	console.log φ2,λ2 
# 	y = Math.sin(λ2-λ1) * Math.cos(φ2)
# 	x = Math.cos(φ1)*Math.sin(φ2) - Math.sin(φ1)*Math.cos(φ2)*Math.cos(λ2-λ1)
# 	res = Math.atan2(y, x) * 180 / Math.PI
# 	console.log res
# 	res = 90-res
# 	if res < 0 then res += 360
# 	console.log res 
# 	res

calcHeading = (φ1,λ1,φ2,λ2) ->
	p1 = LatLon φ1,λ1
	p2 = LatLon φ2,λ2
	p1.bearingTo p2