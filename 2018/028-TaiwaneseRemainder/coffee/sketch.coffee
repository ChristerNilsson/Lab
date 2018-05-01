buttons = []
clocks = []
game = {steps : 1}

RED   = "#F00"
GREEN = "#0F0"
BLACK = "#000"
WHITE = "#FFF"

copyToClipboard = (s) -> 
	el = document.createElement 'textarea'
	el.value = s
	document.body.appendChild el
	el.select()
	document.execCommand 'copy'
	document.body.removeChild el

setup = -> 
	createCanvas 600,windowHeight
	textAlign CENTER,CENTER
	textSize 64
	buttons.push new Button 'Steps:',400,50,64 
	buttons.push new Button 'reset',400,150,64, ->
		if @enabled and 50 > dist mouseX,mouseY,@x,@y
			game.totalSteps = 0 
			game.totalPoints = 0
			clock.count = 0 for clock in clocks				 
	buttons.push new Button 'ok',400,250,64, -> 
		if @enabled and 50 > dist mouseX,mouseY,@x,@y
			if game.steps==game.totalSteps and game.totalPoints==game.total then newGame 1
			if game.steps==game.totalSteps then newGame 1
			else newGame -1
	buttons.push new Button 'All clocks green',400,380,24
	buttons.push new Button 'Use all steps',400,410,24
	buttons.push new Button 'Share via clipboard',400,440,24,->
		if 50 > dist mouseX,mouseY,@x,@y then copyToClipboard game.url

	buttons[5].enabled = true

	print window.location.href
	if '?' in window.location.href 
		params = getParameters()
		if 3 == _.size params
			game =
				steps : parseInt params.steps
				ticks : (parseInt r for r in params.ticks.split ',')
				rests : (parseInt r for r in params.rests.split ',') 
				url : window.location.href
			newGame1()
			return
	newGame 0

class Button
	constructor : (@txt,@x,@y,@size,@f=->) -> @enabled=false
	draw : ->
		if @enabled then fill WHITE else fill BLACK
		textSize @size
		text @txt,@x,@y

class Clock
	constructor : (@rests, @ticks, @x, @y) -> @count = 0
	draw : ->
		push()
		translate @x,@y
		sw 2
		twelve = game.totalPoints % @ticks == @rests 
		fill if twelve then GREEN else RED
		stroke WHITE
		circle 0,0,50
		fill if twelve then BLACK else WHITE
		sw 1
		textSize 40
		text @ticks,0,0

		# subtract
		fill if @count > 0 then WHITE else BLACK
		stroke if @count > 0 then WHITE else BLACK
		text @count, 100,0
		
		rotate radians -90 -@rests*360/@ticks
		stroke WHITE
		for j in range @ticks
			sw 7
			point 50,0
			sw 5
			if j == game.totalPoints % @ticks then	line 25,0,40,0
			rotate radians 360/@ticks
		pop()

okidoki = ->
	if game.totalSteps != game.steps then return false 
	for i in range game.ticks.length
		if game.totalPoints % game.ticks[i] != game.rests[i] then return false
	true

newGame = (delta) ->
	game.steps += delta
	if game.steps < 1 then game.steps = 1
	game = createProblem game.steps
	newGame1()

newGame1 = ->
	print game.steps
	print "["+game.ticks.toString()+"]"
	print "["+game.rests.toString()+"]"
	print ''
	game.totalSteps = 0
	game.totalPoints = 0

	clocks = []
	for i in range game.ticks.length
		clock = new Clock game.rests[i], game.ticks[i], 60, 60+110*i
		clock.f = -> 
			if 50 > dist mouseX,mouseY,@x,@y  
				game.totalPoints += @ticks
				game.totalSteps++
				@count++
			else if @count > 0 and 50 > dist mouseX,mouseY,@x+100,@y
				game.totalPoints -= @ticks
				game.totalSteps--
				@count--
		clocks.push clock
	xdraw()

info = ->
	buttons[0].txt = 'steps: ' + (game.steps - game.totalSteps)
	buttons[1].enabled = game.totalSteps > 0
	buttons[2].enabled = okidoki()
	button.draw() for button in buttons

xdraw = ->
	bg 0.5
	info()
	c.draw() for c in clocks

mousePressed = ->
	obj.f() for obj in buttons.concat clocks
	xdraw()