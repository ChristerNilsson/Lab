say = (m) ->
	speechSynthesis.cancel()
	msg = new SpeechSynthesisUtterance()
	voices = speechSynthesis.getVoices()
	msg.voice = voices[5]
	msg.voiceURI = "native"
	msg.volume = 1
	msg.rate = 1
	msg.pitch = 0.8
	msg.text = m
	msg.lang = 'en-US'
	speechSynthesis.speak msg

class GUI
	constructor : ->

		@current = ['Fan']

		@menu =
			Fan: range 4
			Temp: range 6
			Blink: 'Off Left Right'.split ' '
			Music: 'Beatles Jazz Rock Stones'.split ' '
			Radio: 'P1 P2 P3 P4 P5'.split ' '
			Volume: range 10
			Wipers: range 4
			Bearing: ['0 0','0 1','0 2','0 3','0 4','0 5','0 6','0 7','0 8','0 9','1 0','1 1','1 2','1 3','1 4','1 5','1 6','1 7','1 8','1 9','2 0','2 1','2 2','2 3','2 4','2 5','2 6','2 7','2 8','2 9','3 0','3 1','3 2','3 3','3 4','3 5']
			Distance: '10 20 50 100 200 500 1000 2000 5000'.split ' '

		@values =
			Fan: 0
			Temp: 0
			Blink: 'Off'
			Music: 'Rock'
			Radio: 'P1'
			Volume: 5
			Wipers: 0
			Distance: '500'
			Bearing: '1 8'

	draw : ->
		bg 0.5
		sc()
		textSize 20
		text @current[0],50,50
		if @current.length==2
			text @current[1],70,70

	scroll : (delta) ->
		if @current.length==1
			keys0 = _.keys @menu
			index = keys0.indexOf @current[@current.length-1]
			index = (index+delta) %% keys0.length
			@current[@current.length-1] = keys0[index]
			say keys0[index]
		if @current.length==2
			keys0 = _.keys @menu
			arr = @menu[@current[0]] 
			index = arr.indexOf @current[1]
			index = (index+delta) %% arr.length
			@current[1] = arr[index]
			@values[@current[0]] = @current[1]
			say @current[1]

	up : -> @scroll 1
	down : -> @scroll -1
	ok : ->
		if @current.length == 1
			@current.push @values[@current[0]]
			say @current[@current.length-1]
	back : ->
		if @current.length > 1
			@current.pop()
			say @current[@current.length-1]

app = new GUI

setup = ->createCanvas 200,200

draw = -> app.draw()

keyPressed = ->
	if keyCode == 37 then app.back()
	if keyCode == 38 then app.up()
	if keyCode == 39 then app.ok()
	if keyCode == 40 then app.down()
