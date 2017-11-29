RADIUS = null
WIDTH = null
released = true 

class Button
	constructor : (@i,@j,@text) ->
		@x = WIDTH/2 + WIDTH*@i
		@y = RADIUS + 2*RADIUS*@j
	draw : ->
		fc 1
		circle @x,@y,RADIUS
		fc 0
		text @text,@x,@y
	mousePressed : (mx,my) ->
		if 25 > dist mx,my,@x,@y 
			state.digits[@i] = int @text / [10,1,10,1,10,1][@i]
			state.memory[@i] = int @text / [10,1,10,1,10,1][@i]

class Action
	constructor : (@x,@y,@w,@h,@text,@f) ->
		@bg = [1,1,1]
		@disabled = false 
	draw : ->
		fc @bg[0],@bg[1],@bg[2]
		rect @x,@y,@w,@h
		if @disabled then fc 0.5 else fc 0
		text @text,@x,@y
	mousePressed : (mx,my) ->
		if not @disabled and @x-@w/2 < mx < @x+@w/2 and @y-@h/2 < my < @y+@h/2 then @f()

class State
	constructor : ->
		@digits = [0,0,0,0,0,0] # hh mm ss
		@memory = [0,0,0,0,0,0]
		@runState = 0 # 0=start 1=pause 2=resume		

	done : -> 
		if not _.isEqual @digits,@memory
			for i in range 6 
				@digits[i] = @memory[i]
		else
			@digits = [0,0,0,0,0,0] # hh mm ss
			@memory = [0,0,0,0,0,0]
		@runState=0
		@fix {}

	run : -> 
		@runState = [1,2,1][@runState]
		if @runState == 1
			@start = int millis()/1000
			@secs = 0
			for i in range 6
				@secs += [36000,3600,600,60,10,1][i] * @digits[i]

	draw : ->
		if @runState==1
			s = @secs - (int(millis()/1000) - @start)
			if s==0 then @runState=2
			for i in range 6
				n = [36000,3600,600,60,10,1][i]
				@digits[i] = int s / n
				s %= n
		@fix()

		for i in range 3
			t = 10 * @digits[2*i] + @digits[2*i+1]
			t = t.toString()
			if t.length==1 then t = "0" + t
			x = WIDTH/2 + 2*WIDTH*i
			y = height-5*RADIUS
			text t,x,y

	fix : -> 
		if @runState==2 and _.isEqual @digits, [0,0,0,0,0,0]
			@runState=0
		buttonLeft.disabled = @runState==1
		buttonRight.disabled = _.isEqual @digits, [0,0,0,0,0,0]
		buttonRight.text = ['Start','Pause','Resume'][@runState]
		buttonRight.bg = [[0,1,0],[1,0,0],[0,1,0]][@runState]

buttons = []
state = new State
buttonLeft  = null
buttonRight = null

setup = ->
	createCanvas windowWidth,windowHeight
	RADIUS = height/20
	WIDTH = width/6

	buttonLeft  = new Action WIDTH*2.5,height-RADIUS,100,40,'Done', -> state.done()
	buttonRight = new Action WIDTH*4.5,height-RADIUS,100,40,'Start', -> state.run()
	buttons.push buttonLeft
	buttons.push buttonRight

	textAlign CENTER,CENTER
	rectMode CENTER

	buttons.push new Button 0,i,i*10 for i in range 3 # hh
	buttons.push new Button 1,i,i    for i in range 10
	buttons.push new Button 2,i,i*10 for i in range 6 # mm
	buttons.push new Button 3,i,i    for i in range 10
	buttons.push new Button 4,i,i*10 for i in range 6 # ss
	buttons.push new Button 5,i,i    for i in range 10

draw = ->
	bg 0.5
	textSize 24
	for button in buttons
		button.draw()
	textSize 100
	state.draw()	

mouseReleased = ->
	released = true
	false

mousePressed = ->
	if not released then return
	released = false 
	for button in buttons
		button.mousePressed mouseX,mouseY
	print state.digits
	false
