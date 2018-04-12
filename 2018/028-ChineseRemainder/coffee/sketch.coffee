n = 0
levels = []
levels.push [[4], [5], 4, 4]
levels.push [[0,1], [2,3], 4, 2]
levels.push [[1,1,1], [2,3,5], 1, 1]
levels.push [[0,2,2], [2,3,5], 2, 2]
levels.push [[2,3,2], [3,5,7], 23, 5]
level = -1
hist = []
buttons = []
circles = []
a = null
b = null

state = 0 # 0=game running 
					# 1=game finished

class Button
	constructor : (@txt,@x,@y,@f=null) -> @enabled=false
	draw : ->
		if @enabled then fc 1 else fc 0
		text @txt,@x,@y

class Clock
	constructor : (@a,@b,@x,@y,@f=null) ->
	draw : ->
		push()
		translate @x,@y
		sw 1

		if n % @b == @a then fc 0,1,0 else fc 1,0,0

		sc 1-state
		circle 0,0,40
		rotate radians -90 -@a*360/@b
		for j in range @b
			sw 5
			point 40,0
			sw 2
			if j == n % @b then	line 0,0,40,0
			rotate radians 360/@b
		pop()

newGame = ->
	level++
	level %= levels.length 

	buttons[4].enabled = true
	state = 0

	n = 0
	a = levels[level][0]
	b = levels[level][1]	
	hist = []
	circles = []
	for i in range a.length
		circles.push new Clock a[i], b[i], 200, 200+100*i, -> 
			if state == 0
				hist.push n
				n += @b
	xdraw()

setup = -> 
	createCanvas 800,800
	textAlign CENTER,CENTER
	textSize 64
	buttons.push new Button '',500,100, ->
	buttons.push new Button '',500,200, ->
	buttons.push new Button '',500,300, ->
	buttons.push new Button 'undo',500,500, -> 
		if state==0 and hist.length > 0 then n = hist.pop()
	buttons.push new Button '+1',200,100, ->
		if state==0  
			hist.push n
			n++
	buttons.push new Button 'new game',500,600, -> if state == 1 then newGame()
	newGame()

info = ->
	buttons[0].txt = 'level: ' + level
	buttons[1].txt = 'steps: ' + (levels[level][3] - hist.length)
	buttons[2].txt = 'n: ' + n
	buttons[3].enabled = state==0 and hist.length > 0
	buttons[4].enabled = state==0
	buttons[5].enabled = state==1

	button.draw() for button in buttons

xdraw = ->
	bg 0.5
	info()
	c.draw() for c in circles

mousePressed = ->
	for obj in buttons.concat circles
		if 40 > dist mouseX,mouseY,obj.x,obj.y then obj.f()
	if levels[level][2] == n 
		if levels[level][3] == hist.length then state = 1
	xdraw()