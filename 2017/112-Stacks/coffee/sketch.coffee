# bit.ly/stacksrules
# https://www.youtube.com/watch?v=DFg9A3TC1EM&feature=youtu.be
# bit.ly/stacksboard

XOFF = 220
YOFF = 380
SIZE = 600
RADIE = 130
HEIGHT = 15
BRICKS = 12
ALPHABET = 'abc Ydefg hijklnmnopR qrs'

buttons = []
player = 0
moves = 1
selectedButton = -1
source = [BRICKS,BRICKS]
target = [0,0]
message = ''
hist = []

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
		circle @x, @y, 0.45 * RADIE
		sw 2

		if @nr == 'Pass' 
			text @nr,@x,@y
		else
			text ALPHABET[@nr],@x,@y

		sc 0
		n = @bricks.length
		for brick,i in @bricks
			if @selected >= n-i then fc 0,1,0,0.5	else fc 1,brick,0,0.5
			circle @x, @y-i*HEIGHT, 0.25 * RADIE 

	printHistory : ->
		lastp = 0
		count = 1
		s = count + ' '
		for [p,move] in hist
			if p!=lastp 
				if p==0
					print s
					count += 1 
					s = count + ' '
				if p==1
					s = s + '| '
				lastp=p
				s = s + move + ' '
			else
				s = s + move + ' ' 
		print s


	moveBricks : -> # from selectedButton to @nr
		if @nr not in [4,20] and buttons[@nr].bricks.length > 0 
			if moves == 1 then return  
			if moves == 2 then moves = 1

		count = buttons[selectedButton].selected
		if count == 1 then count = '' 
		hist.push [player,ALPHABET[selectedButton]+ALPHABET[@nr]+count]

		for i in range buttons[selectedButton].selected
			brick = buttons[selectedButton].bricks.pop()
			if @nr in [4,20]
				target[player] += 1
				if target[player] == BRICKS
					message = ['Red','Yellow'][player] + ' won!'
					@printHistory()
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
		#@printHistory()

	inside : (mx,my) -> dist(@x + XOFF, (@y + YOFF)/2, mx, my) < 0.5 * RADIE
			
	topBlock : (bricks) ->
		count = 0
		while bricks[bricks.length-1-count]==player
			count += 1
		count

	mousePressed : (mx,my) ->
		if not @inside mx,my then return 

		if selectedButton>=0 and selectedButton != @nr # Markering av tillruta
			if @nr in legalMoves selectedButton then @moveBricks()
			return

		if selectedButton>=0 and selectedButton != @nr
			buttons[selectedButton].selected = 0

		n = @topBlock @bricks
		if n == 0 then return  
		@selected = (@selected-1) %% (n+1)
		selectedButton = if @selected > 0 then @nr else -1

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

showBricks = (data,p,x,y) ->
	for i in range data[p]
		fc 1,p,0,0.5
		circle x, y-i*HEIGHT, 0.25 * RADIE 

xdraw = ->
	bg 0.5
	push()
	scale 1,0.5
	translate XOFF,YOFF
	for button in buttons
		button.draw()

	showBricks source,1,350,-150
	showBricks target,0,430,-150
	showBricks source,0,350,730
	showBricks target,1,430,730

	pop()
	textSize 50
	text message,width/2,height/2

mousePressed = ->
	for button in buttons
		button.mousePressed mouseX,mouseY