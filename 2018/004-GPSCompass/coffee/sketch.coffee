positionTarget =
	lat: null
	lng: null

positionCurrent = 
	lat: null
	lng: null
	hng: null
	spd: null
	timestamp: null

positionLat = document.getElementById "position-lat"
positionLng = document.getElementById "position-lng"
positionHng = document.getElementById "position-hng"
positionSpd = document.getElementById "position-spd"
positionTimestamp = document.getElementById "timestamp"

# decimalToSexagesimal = (decimal, type) ->
# 	degrees = decimal | 0
# 	fraction = Math.abs decimal - degrees
# 	minutes = (fraction * 60) | 0;
# 	seconds = (fraction * 3600 - minutes * 60) | 0

# 	direction = ""
# 	positive = degrees > 0
# 	degrees = Math.abs degrees
# 	if type == "lat" then direction = if positive then "N" else "S"
# 	if type == "lng" then	direction = if positive then "E" else "W"
# 	degrees + "° " + minutes + "' " + seconds + "\" " + direction

locationUpdate = (position) ->
	positionCurrent.lat = position.coords.latitude
	positionCurrent.lng = position.coords.longitude
	positionCurrent.hng = position.coords.heading
	positionCurrent.spd = position.coords.speed
	positionCurrent.timestamp = position.timestamp

	positionLat.textContent = positionCurrent.lat
	positionLng.textContent = positionCurrent.lng
	positionHng.textContent = positionCurrent.hng
	positionSpd.textContent = positionCurrent.spd
	positionTimestamp.textContent = positionCurrent.timestamp
	#positionLat.textContent = decimalToSexagesimal positionCurrent.lat, "lat"
	#positionLng.textContent = decimalToSexagesimal positionCurrent.lng, "lng"

locationUpdateFail = (error) ->
	positionLat.textContent = "n/a"
	positionLng.textContent = "n/a"

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: false
		maximumAge: 30000
		timeout: 27000