bearing = 0
heading = 0

setup = ->
	createCanvas windowWidth,windowHeight
	window.addEventListener "deviceorientation", (event) -> 
		if event.alpha then	bearing = 360 - Math.round event.alpha
	textSize 100
	textAlign CENTER,CENTER

	# Obtain a new *world-oriented* Full Tilt JS DeviceOrientation Promise
	promise = FULLTILT.getDeviceOrientation { 'type': 'world' }

	# Wait for Promise result
	promise.then( (deviceOrientation) -> # Device Orientation Events are supported

		# Register a callback to run every time a new 
		# deviceorientation event is fired by the browser.
		deviceOrientation.listen ->

			# Get the current *screen-adjusted* device orientation angles
			currentOrientation = deviceOrientation.getScreenAdjustedEuler()

			# Calculate the current compass heading that the user is 'looking at' (in degrees)
			compassHeading = 360 - currentOrientation.alpha

			# Do something with `compassHeading` here...
			heading = compassHeading

	).catch (errorMessage) ->  # Device Orientation Events are not supported

		console.log errorMessage

		# Implement some fallback controls here...	

draw = ->
	bg 1
	text heading, width*0.5, height*0.2
	text bearing, width*0.5, height*0.50
	if window.orientation
		text window.orientation, width*0.5, height*0.75
	else
		text 'orient unknown', width*0.5, height*0.75
