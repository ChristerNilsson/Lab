buttons = []
vars = []

class Button
	constructor : (@title,@x,@y,@r,@event) ->
	inside : (x,y) -> @r > dist x,y,@x,@y
	execute : -> @event()
	draw : ->
		fc 1
		circle @x,@y,@r
		fc 0
		text @title,@x,@y

setup = ->
	createCanvas 200,200
	buttons.push new Button 'Back',135,135,17, -> back()
	buttons.push new Button 'Forw',175,135,17, -> forw()
	buttons.push new Button 'Clr',155,170,17, -> clr()
	for i in range 10 
		do (i) ->
			buttons.push new Button '+',80,190-20*i,8, -> vars[i]++
			buttons.push new Button '-',100,190-20*i,8, -> vars[i]--
	clr()

draw = ->
	bg 0.5
	fc 0
	sc()

	textAlign CENTER,CENTER
	button.draw() for button in buttons

	fc 1,1,0
	text t,155,30+20*i for t,i in 'Scheutz Difference Engine 1843'.split ' '
	textAlign RIGHT,CENTER
	text v,60,190-20*i for v,i in vars
		
clr = -> vars = [0,0,0,0,0,0,0,0,0,0] # 0th to 9th differnce
forw = -> vars[i] += vars[i+1] for i in range 9
back = -> vars[i] -= vars[i+1] for i in range 8,-1,-1

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.execute()
