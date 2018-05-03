buttons = []
clocks = []
game = {steps : 1}
N = 60

RED   = "#F00"
GREEN = "#0F0"
BLACK = "#000"
WHITE = "#FFF"

reset = ->
	game.totalSteps = 0 
	game.totalPoints = 0
	for clock in clocks
		clock.reset()

ok = ->
	if @enabled 
		if game.steps==game.totalSteps and game.totalPoints==game.total then newGame 1
		if game.steps==game.totalSteps then newGame 1
		else newGame -1

setup = -> 
	createCanvas 600,windowHeight
	textAlign CENTER,CENTER
	textSize 64
	angleMode DEGREES
	buttons.push new Button 'Steps:',400,60,64 
	buttons.push new Button 'reset',400,170,64, reset
	buttons.push new Button 'ok',400,280,64, ok
	buttons.push new Button 'All clocks green',400,380,24
	buttons.push new Button 'Use all steps',400,410,24
	buttons.push new Button 'Share via clipboard',400,440,24, -> 
		copyToClipboard game.url
		@enabled = false 

	buttons[5].enabled = true

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
		fill if @enabled then WHITE else BLACK
		textSize @size
		text @txt,@x,@y

class Clock
	constructor : (@rest, @tick, @x, @y) -> @reset()

	reset : ->
		@count = 0 
		@value = -@rest %% @tick
		@oldValue = @value 
		@delta = 0
		@n = N

	draw : ->
		push()
		translate @x,@y
		sw 2
		twelve = game.totalPoints % @tick == @rest
		fill if twelve then GREEN else RED
		stroke WHITE
		circle 0,0,50
		fill if twelve then BLACK else WHITE
		sw 1
		textSize 40
		text @tick,0,0

		# subtract
		fill   if @count > 0 then WHITE else BLACK
		stroke if @count > 0 then WHITE else BLACK
		text @count,100,0
		
		if @n < N then @n++		
		rotate -90 + (@n / N * @delta) * 360 / @tick

		stroke WHITE
		for j in range @tick
			sw 7
			point 50,0
			sw 5
			if j == @oldValue then line 25,0,40,0
			rotate 360/@tick
		pop()

	add : (delta) ->
		@delta = delta 
		@oldValue = @value
		@value = (@value + delta) %% @tick
		@n = 0

	move : (step) ->
		if @count+step < 0 then return 
		buttons[5].enabled = true 
		tick = step * @tick
		game.totalPoints += tick
		game.totalSteps += step
		@count += step
		for clock in clocks
			clock.add tick		

okidoki = ->
	if game.totalSteps != game.steps then return false 
	for clock in clocks
		if game.totalPoints % clock.tick != clock.rest then return false
	true

newGame = (delta) ->
	game.steps += delta
	if game.steps < 1 then game.steps = 1
	game = createProblem game.steps
	newGame1()

newGame1 = ->
	print "#{game.steps}, [#{game.ticks}], [#{game.rests}]"
	reset()
	clocks = []
	for i in range game.ticks.length
		clock = new Clock game.rests[i], game.ticks[i], 60, 60+110*i
		clocks.push clock
		clock.forward  = -> @move  1
		clock.backward = -> @move -1

info = ->
	buttons[0].txt = 'steps: ' + (game.steps - game.totalSteps)
	buttons[1].enabled = game.totalSteps > 0
	buttons[2].enabled = okidoki()
	button.draw() for button in buttons

draw = ->
	bg 0.5
	info()
	clock.draw() for clock in clocks

mousePressed = ->
	for b in buttons
		if 50 > dist mouseX,mouseY,b.x,b.y then b.f() 
	for c in clocks
		if 50 > dist mouseX,mouseY,c.x,    c.y then c.forward()
		if 50 > dist mouseX,mouseY,c.x+100,c.y then c.backward()
