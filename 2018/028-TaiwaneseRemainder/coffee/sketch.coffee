steps = 1

buttons = []
clocks = []
game = null

RED   = "#F00"
GREEN = "#0F0"
BLACK = "#000"
WHITE = "#FFF"

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
			if steps==game.totalSteps and game.totalPoints==game.total then newGame 1
			if steps==game.totalSteps then newGame 1
			else newGame -1
	buttons.push new Button 'All clocks green',400,380,24
	buttons.push new Button 'Use all steps',400,410,24
	buttons.push new Button 'Link',400,440,24,->
		if 50 > dist mouseX,mouseY,@x,@y
			window.location.href = game.url

	print window.location.href
	if '?' in window.location.href 
		params = getParameters()
		print params
		print _.size params
		if 3 == _.size params
			game =
				steps : parseInt params.steps
				ticks : (parseInt r for r in params.ticks.split ',')
				rests : (parseInt r for r in params.rests.split ',') 
				url : window.location.href
			print game 
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
	constructor : (@rests, @ticks, @x, @y) -> 
		@count = 0
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
	if game.totalSteps != steps then return false 
	for i in range game.ticks.length
		if game.totalPoints % game.ticks[i] != game.rests[i] then return false
	true

newGame = (delta) ->
	steps += delta
	if steps < 1 then steps = 1
	game = createProblem steps
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
	buttons[0].txt = 'steps: ' + (steps - game.totalSteps)
	buttons[1].enabled = game.totalSteps > 0
	buttons[2].enabled = okidoki()
	for button in buttons
		button.draw() 

xdraw = ->
	bg 0.5
	info()
	for c in clocks
		c.draw() 

mousePressed = ->
	for obj in buttons.concat clocks
		obj.f() 
	xdraw()