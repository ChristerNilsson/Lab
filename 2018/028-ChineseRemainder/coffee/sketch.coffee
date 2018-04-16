steps = 1
total = 0

hist = []
buttons = []
circles = []
game = null

class Button
	constructor : (@txt,@x,@y,@f=null) -> @enabled=false
	draw : ->
		if @enabled then fc 1 else fc 0
		text @txt,@x,@y

class Clock
	constructor : (@rests, @ticks, @x,@y, @f=null) ->
	draw : ->
		push()
		translate @x,@y
		sw 1
		if total % @ticks == @rests then fc 0,1,0 else fc 1,0,0
		sc 1 
		circle 0,0,40
		fc 1 
		textSize 40

		text @ticks,0,0	
		rotate radians -90 -@rests*360/@ticks
		for j in range @ticks
			sw 5
			point 40,0
			sw 2
			if j == total % @ticks then	line 0,0,40,0
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
	buttons[3].enabled = okidoki()
	state = 0

	total = 0
	hist = []
	circles = []
	for i in range game.ticks.length
		circles.push new Clock game.rests[i], game.ticks[i], 200, 100+100*i, -> 
			hist.push total
			total += @ticks
	xdraw()

setup = -> 
	createCanvas 700,900
	textAlign CENTER,CENTER
	textSize 64
	buttons.push new Button '',500,100, ->
	buttons.push new Button '',500,200, ->
	buttons.push new Button 'undo',500,400, -> 
		if hist.length > 0 then total = hist.pop()
	buttons.push new Button 'ok',500,500, -> 
		if @enabled
			if steps==hist.length and total==game.total then newGame 1
			else newGame -1
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
		if 50 > dist mouseX,mouseY,obj.x,obj.y then obj.f()
	xdraw()