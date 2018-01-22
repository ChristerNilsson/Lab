oldBearing = 0

setup = ->
	window.addEventListener "deviceorientation", (event) ->
		bearing = event.alpha
		if typeof event.webkitCompassHeading != "undefined"
			bearing = event.webkitCompassHeading # iOS non-standard

		delta = Math.round (oldBearing-bearing)/10
		delta *= 10
		if delta != 0
			oldBearing = bearing
			utterance = new SpeechSynthesisUtterance delta
			window.speechSynthesis.speak utterance
