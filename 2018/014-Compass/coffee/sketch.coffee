if window.DeviceOrientationEvent 
	window.addEventListener 'deviceorientation', (eventData) ->
		if event.webkitCompassHeading then heading = 'A ' + event.webkitCompassHeading
		else heading = 'B ' + event.alpha
		element = document.getElementById 'heading'
		element.innerHTML = 'Heading: ' + heading

