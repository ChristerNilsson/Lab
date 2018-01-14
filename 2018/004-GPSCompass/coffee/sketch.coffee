#hng: null # NESW = [0,90,180,270]
#spd: null # m/s

p2 = # Ulvsjön
	lat: 59.277103
	lng: 18.164897
	timestamp: 0

track = []

# devicets position och hastighet
positionLat = document.getElementById "position-lat"
positionLng = document.getElementById "position-lng"
positionTimestamp = document.getElementById "timestamp"
positionSpd = document.getElementById "position-spd"

# beräkningar baserade på de senaste tvåpunkterna
deltat = document.getElementById "deltat"
deltas = document.getElementById "deltas"
#speed = document.getElementById "speed"
heading = document.getElementById "heading"

# bäring enligt kompass
bearing = document.getElementById "bearing"
delta = document.getElementById "delta"

# bäring och avstånd till målet
positionHng = document.getElementById "position-hng"
distance = document.getElementById "distance"

points = document.getElementById "points"

locationUpdate = (position) ->
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp

	track.push p1

	positionLat.textContent = p1.lat
	positionLng.textContent = p1.lng
	positionHng.textContent = "#{Math.round calcHeading p1,p2}°" 
	positionSpd.textContent = p1.spd
	positionTimestamp.textContent = p1.timestamp

	distance.textContent = "#{Math.round distance_on_geoid p1,p2} m"

	if track.length >= 2 
		p0 = track[track.length-2]
		deltat.textContent = "#{p1.timestamp - p0.timestamp} ms"
		deltas.textContent = "#{Math.round distance_on_geoid p0,p1} m"
		#speed.textContent = "?"
		heading.textContent = "#{Math.round calcHeading p0,p1}°"

	points.textContent = "#{track.length} punkter"  

locationUpdateFail = (error) ->
	positionLat.textContent = "n/a"
	positionLng.textContent = "n/a"

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: false
		maximumAge: 30000
		timeout: 27000

window.addEventListener "deviceorientation", (event) ->
	heading = event.alpha

	if typeof event.webkitCompassHeading != "undefined"
		heading = event.webkitCompassHeading # iOS non-standard

	bearing.textContent = heading
	delta.textContent = heading - bearing


	# var orientation = getBrowserOrientation()

	# if (typeof heading !== "undefined" && heading !== null) { // && typeof orientation !== "undefined") {
	# 	// we have a browser that reports device heading and orientation


	# 	if (debug) {
	# 		debugOrientation.textContent = orientation;
	# 	}


	# 	// what adjustment we have to add to rotation to allow for current device orientation
	# 	var adjustment = 0;
	# 	if (defaultOrientation === "landscape") {
	# 		adjustment -= 90;
	# 	}

	# 	if (typeof orientation !== "undefined") {
	# 		var currentOrientation = orientation.split("-");

	# 		if (defaultOrientation !== currentOrientation[0]) {
	# 			if (defaultOrientation === "landscape") {
	# 				adjustment -= 270;
	# 			} else {
	# 				adjustment -= 90;
	# 			}
	# 		}

	# 		if (currentOrientation[1] === "secondary") {
	# 			adjustment -= 180;
	# 		}
	# 	}

	# 	positionCurrent.hng = heading + adjustment;

	# 	var phase = positionCurrent.hng < 0 ? 360 + positionCurrent.hng : positionCurrent.hng;
	# 	positionHng.textContent = (360 - phase | 0) + "°";


	# 	// apply rotation to compass rose
	# 	if (typeof rose.style.transform !== "undefined") {
	# 		rose.style.transform = "rotateZ(" + positionCurrent.hng + "deg)";
	# 	} else if (typeof rose.style.webkitTransform !== "undefined") {
	# 		rose.style.webkitTransform = "rotateZ(" + positionCurrent.hng + "deg)";
	# 	}
	# } else {
	# 	// device can't show heading

	# 	positionHng.textContent = "n/a";
	# 	showHeadingWarning();
	# }



