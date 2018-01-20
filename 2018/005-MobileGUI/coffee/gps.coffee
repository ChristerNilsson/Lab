locationUpdate = (position) ->
	#print 'locationUpdate', position
	p1 = 
		lat : position.coords.latitude
		lng : position.coords.longitude
		timestamp : position.timestamp # milliseconds since 1970

	track.push p1

	heading_12 = calcHeading p1,place
	lastObservation = millis()

	texts[0] = "#{Math.round distance_on_geoid p1,place} m"
	texts[1] = "#{Math.round heading_12}°"
	texts[6] = "#{track.length}" 
	if track.length > 1
		speed = calcSpeed start, millis(), track[0], _.last(track), place
		eta   = calcETA   start, millis(), track[0], _.last(track), place
		texts[3] = "#{precisionRound speed,1} m/s"  
		texts[2] = "#{precisionRound eta,  0} s"

locationUpdateFail = (error) ->

navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
	enableHighAccuracy: true
	maximumAge: 30000
	timeout: 27000

