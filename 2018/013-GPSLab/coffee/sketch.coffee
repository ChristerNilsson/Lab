setup = ->
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	textSize 20

	locationUpdate = (position) ->
		bg 0.5
		text position.coords.latitude,100,20
		text position.coords.longitude,100,40
		text position.timestamp,100,60

	locationUpdateFail = (error) ->
		bg 0.5
		text error.code + ' ' + error.message,width/2,height/2

	navigator.geolocation.watchPosition locationUpdate, locationUpdateFail, 
		enableHighAccuracy: false # true
		maximumAge: 30000
		timeout: 27000
