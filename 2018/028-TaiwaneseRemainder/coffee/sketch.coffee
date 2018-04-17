steps = 1
total = 0

hist = []
buttons = []
circles = []
game = null

class Button
	constructor : (@txt,@x,@y,@size,@f=null) -> @enabled=false
	draw : ->
		if @enabled then fc 1 else fc 0
		textSize @size
		text @txt,@x,@y

class Clock
	constructor : (@rests, @ticks, @x,@y, @f=null) ->
	draw : ->
		push()
		translate @x,@y
		sw 2
		twelve = total % @ticks == @rests 
		if twelve then fc 0,1,0 else fc 1,0,0
		if twelve then sc 0 else sc 1
		circle 0,0,50
		if twelve then fc 0 else fc 1
		sw 1
		textSize 40
		text @ticks,0,0	
		rotate radians -90 -@rests*360/@ticks
		for j in range @ticks
			sw 7
			point 50,0
			sw 5
			if j == total % @ticks then	line 25,0,40,0
			rotate radians 360/@ticks
		pop()

okidoki = ->
	if hist.length != game.steps then return false 
	for i in range game.ticks.length
		if total % game.ticks[i] != game.rests[i] then return false
	true

newGame = (delta) ->
	steps += delta
	if steps < 1 then steps = 1
	game = createProblem steps
	print game.steps
	print "["+game.ticks.toString()+"]"
	print "["+game.rests.toString()+"]"
	print ''
	buttons[3].enabled = okidoki()
	state = 0

	total = 0
	hist = []
	circles = []
	for i in range game.ticks.length
		circles.push new Clock game.rests[i], game.ticks[i], 60, 60+110*i, -> 
			hist.push total
			total += @ticks
	xdraw()

setup = -> 
	createCanvas windowWidth,windowHeight
	textAlign CENTER,CENTER
	textSize 64
	buttons.push new Button '',300,60,64, ->
	buttons.push new Button '',300,210,64, ->
	buttons.push new Button 'undo',300,360,64, -> 
		if hist.length > 0 then total = hist.pop()
	buttons.push new Button 'ok',300,510,64, -> 
		if @enabled
			if steps==hist.length and total==game.total then newGame 1
			else newGame -1
	buttons.push new Button 'Taiwanese Remainder:',300,650,24, ->
	buttons.push new Button 'All clocks green',300,680,24, ->
	buttons.push new Button 'Minimize total',300,710,24, ->
	buttons.push new Button 'Use all steps',300,740,24, ->

	newGame 0

info = ->
	buttons[0].txt = 'steps: ' + (steps - hist.length)
	buttons[1].txt = 'total: ' + total
	buttons[2].enabled = hist.length > 0
	buttons[3].enabled = okidoki()
	button.draw() for button in buttons

xdraw = ->
	bg 0.5
	info()
	c.draw() for c in circles

mousePressed = ->
	for obj in buttons.concat circles
		if 70 > dist mouseX,mouseY,obj.x,obj.y then obj.f()
	xdraw()