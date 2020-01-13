class Button
	constructor : (@title,@x,@y,@click) -> @r=35
	draw : ->
		fc 1
		if @title == curr then fc 0
		circle @x,@y,35
		fc 0
		if @title == curr then fc 1
		text @title,@x,@y
	inside : (mx,my)-> @x-@r < mx < @x+@r and @y-@r < my < @y+@r

maze = """
	 C !     | 
	-#-#=###D# 
	 ! | E !   
	B# #-#=###=
	 |  F    |G
	=#####-####
	A#####H####
"""

curr = 'A'
currColor = 1
buttons = []

moves = []
moves.push {A:"B", B:"AF", C:"D", D:"CEG", E:"DF", F:"BE", G:"D", H:""}
moves.push {A:"", B:"CF", C:"BF", D:"D", E:"F", F:"BCEGH", G:"F", H:"F"}

setup = ->
	createCanvas 1100,700
	maze = maze.split '\n'
	rectMode CENTER,CENTER
	textAlign CENTER,CENTER
	textSize 50
	sc()
	for line,j in maze
		for ch,i in line
			x = 50 + 100*i
			y = 50 + 100*j
			if ch in "ABCDEFGH"
				do (ch) ->
					buttons.push new Button ch,x,y, () ->
						console.log ch
						if ch in moves[1-currColor][curr]
							curr = ch
							currColor = 1 - currColor

draw = ->
	bg 0.5
	for line,j in maze
		for ch,i in line
			x = 50 + 100*i
			y = 50 + 100*j
			if ch in '|-' then fc 0,0,1 # Blue
			if ch=='|' then rect x,y,20,100
			if ch=='-' then rect x,y,100,20

			if ch in '!=' then fc 1,0,0 # Red
			if ch=='!' then rect x,y,20,100
			if ch=='=' then rect x,y,100,20

			if ch=='#' then fc 1,1,0 # Yellow
			if ch=='#' then rect x,y,100,100

	for button in buttons
		button.draw()

	fc 0
	text 'Go from A to H',350,550
	text 'Jump in order:',350,600
	text 'red, blue, red, blue...',350,650
	text 'Tekniska Muséet',900,550

	if curr=='H' then text 'Excellent!',900,650

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.click()