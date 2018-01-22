oldBearing = 0
delta = 0

mousePressed = ->
	utterance = new SpeechSynthesisUtterance delta
	window.speechSynthesis.speak utterance

setup = ->
	createCanvas 200,200
	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha
		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

		delta = Math.round((oldBearing-bearing)/10)
		delta *= 10
		if delta != 0
			oldBearing = bearing
			utterance = new SpeechSynthesisUtterance delta
			window.speechSynthesis.speak utterance

draw = ->
	bg 1
	fc 0
	textSize 50
	text delta,100,100
