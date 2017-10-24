# bit.ly/stacksrules
# https://www.youtube.com/watch?v=DFg9A3TC1EM&feature=youtu.be
# bit.ly/stacksboard

XOFF = 220
YOFF = 380
SIZE = 600
RADIE = 130
HEIGHT = 15
BRICKS = 12

buttons = []
player = 0
moves = 1
selectedButton = -1
source = [BRICKS,BRICKS]
target = [0,0]
message = ''

legalMoves = (btn) ->
	if player == 0
		if btn in [0,1,2] then return [4] 
		if btn == 20 then return [22,23,24] 
		return [btn-5,btn-6] 
	else
		if btn in [22,23,24] then return [20] 
		if btn == 4 then return [0,1,2] 
		return [btn+5,btn+6] 

possibleMoves = ->
	res = false 
	for button in buttons
		if _.last(button.bricks) == player 
			if moves==2 then res = true
			for move in legalMoves button.nr 
				if buttons[move].bricks.length==0 then res = true
	res

class Button 
	constructor : (@nr) ->
		i = @nr % 5
		j = int @nr / 5
		@x = RADIE * (i - 0.5*j) 
		@y = RADIE * 0.88*j
		@bricks = []
		@selected = 0

	draw : ->
		if @nr in [3,9,15,21] then return 
		fc 0.25

		sc 0
		sw 1
		if player==0 and @nr==20 or player==1 and @nr==4 
			sw 2
			sc 1
		circle @x, @y, 0.5 * RADIE
		sw 2

		n = @bricks.length
		#text @nr,@x,@y
		sc 0
		for brick,i in @bricks
			if @selected >= n-i then fc 0,1,0,0.5	else fc 1,brick,0,0.5
			circle @x, @y-i*HEIGHT, 0.25 * RADIE 

	moveBricks : -> # from selectedButton to @nr
		if buttons[@nr].bricks.length > 0 and moves == 1 then	return # must attack in first move 
		if buttons[@nr].bricks.length > 0 and moves == 2 then	moves = 1

		for i in range buttons[selectedButton].selected
			brick = buttons[selectedButton].bricks.pop()
			if @nr in [4,20]
				target[player] += 1
				if target[player] == BRICKS
					message = ['Red','Yellow'][player] + ' won!'
			else
				@bricks.push brick 

		if source[player] > 0 and selectedButton in [4,20]
			buttons[selectedButton].bricks.push player
			source[player] -= 1

		buttons[selectedButton].selected = 0
		selectedButton = -1

		moves -= 1 
		if moves == 0
			player = 1 - player
			moves = 2
		xdraw()

	inside : (mx,my) -> dist(@x + XOFF, (@y + YOFF)/2, mx, my) < 0.5 * RADIE
			
	mousePressed : (mx,my) ->
		if not @inside mx,my then return 

		if selectedButton>=0 and selectedButton != @nr # Markering av tillruta
			if @nr in legalMoves selectedButton then @moveBricks()
			return

		if selectedButton>=0 and selectedButton != @nr
			buttons[selectedButton].selected = 0
		n = @bricks.length-1
		brick = @bricks[n-@selected]
		if brick == player 
			@selected += 1
			selectedButton = @nr
		else
			@selected = 0
			selectedButton = -1
		xdraw()

class PassButton extends Button
	mousePressed : (mx,my) ->
		if not @inside mx,my then return
		if possibleMoves() then return 
		if selectedButton != -1 
			buttons[selectedButton].selected = 0
			selectedButton = -1 
		player = 1 - player
		xdraw()

	draw : ->
		super
		fc 0.5
		textSize 32
		text @nr,@x,@y

setup = ->
	createCanvas SIZE+100,SIZE
	for nr in range 25
		buttons.push new Button nr

	buttons[4].x = buttons[1].x
	buttons[4].y = buttons[1].y - 2*RADIE
	buttons[4].bricks = [1]
	source[1] -= 1

	buttons[20].x = buttons[23].x
	buttons[20].y = buttons[23].y + 2*RADIE
	buttons[20].bricks = [0]
	source[0] -= 1

	button = new PassButton 'Pass'
	buttons.push button
	button.x = buttons[10].x
	button.y = buttons[4].y 

	textSize 32
	textAlign CENTER,CENTER
	rectMode CENTER
	xdraw()

xdraw = ->
	bg 0.5
	push()
	scale 1,0.5
	translate XOFF,YOFF
	for button in buttons
		button.draw()
	pop()
	textSize 50
	text message,width/2,height/2

mousePressed = ->
	for button in buttons
		button.mousePressed mouseX,mouseY