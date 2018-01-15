# https://cdn.rawgit.com/chrisveness/geodesy/v1.1.2/latlon-spherical.js
distance_on_geoid = (p1,p2) ->
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.distanceTo q2	

calcHeading = (p1,p2) ->
	q1 = LatLon p1.lat,p1.lng
	q2 = LatLon p2.lat,p2.lng
	q1.bearingTo q2

precisionRound = (number, precision) ->
  factor = Math.pow 10, precision
  Math.round(number * factor) / factor

prettyDate = (date) ->
	y = date.getFullYear()
	m = ("0"+(date.getMonth()+1)).slice(-2)
	d = ("0" + date.getDate()).slice(-2) 
	hh = ("0" + date.getHours()).slice(-2)
	mm = ("0" + date.getMinutes()).slice(-2)
	ss = ("0" + date.getSeconds()).slice(-2)
	"#{y}-#{m}-#{d} #{hh}:#{mm}:#{ss}"