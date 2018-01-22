oldBearing = 0
delta = 0
delay = 1000 # ms
start = null

mousePressed = ->
	responsiveVoice.speak "Hello World"

setup = ->
	createCanvas 200,200
	start = millis()
	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha
		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

		delta = Math.round((oldBearing-bearing)/10)
		delta *= 10
		if delta != 0 and millis()-start > 1000
			start = millis()
			oldBearing = bearing
			responsiveVoice.speak delta

draw = ->
	bg 1
	fc 0
	textSize 50
	text delta,100,100
