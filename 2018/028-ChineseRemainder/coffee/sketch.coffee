total = 0
steps = 0

hist = []
buttons = []
circles = []
game = null

state = 0 # 0=game running 
					# 1=game finished

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

		sc 1-state
		circle 0,0,40
		fc 1-state
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

newGame = ->
	steps++

	game = createProblem steps
	while game.restSum == 0
		game = createProblem steps

	buttons[3].enabled = true
	state = 0

	total = 0
	hist = []
	circles = []
	for i in range game.ticks.length
		circles.push new Clock game.rests[i], game.ticks[i], 200, 100+100*i, -> 
			if state == 0
				hist.push total
				total += @ticks
	xdraw()

setup = -> 
	createCanvas 800,800
	textAlign CENTER,CENTER
	textSize 64
	buttons.push new Button '',500,100, ->
	buttons.push new Button '',500,200, ->
	buttons.push new Button 'undo',500,400, -> 
		if state==0 and hist.length > 0 then total = hist.pop()
	buttons.push new Button 'new',500,500, -> if state == 1 then newGame()
	newGame()

info = ->
	buttons[0].txt = 'steps: ' + (steps - hist.length)
	buttons[1].txt = 'total: ' + total
	buttons[2].enabled = state==0 and hist.length > 0
	buttons[3].enabled = state==1
	button.draw() for button in buttons

xdraw = ->
	bg 0.5
	info()
	c.draw() for c in circles

mousePressed = ->
	for obj in buttons.concat circles
		if 50 > dist mouseX,mouseY,obj.x,obj.y then obj.f()
	if game.total == total 
		if game.steps == hist.length then state = 1
	xdraw()

