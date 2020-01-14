SZ = 100
OFF = SZ/2
TH = 20

class Button
	constructor : (@title,@x,@y,@click) -> @r=35
	draw : ->
		fc if @title == curr then 0 else 1
		circle @x,@y,@r
		fc if @title == curr then 1 else 0
		text @title,@x,@y
	inside : (mx,my)-> @r > dist @x, @y, mx, my

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
moves.push {A:"", B:"CF", C:"BF", D:"D", E:"F", F:"BCEGH", G:"F", H:"F"}
moves.push {A:"B", B:"AF", C:"D", D:"CEG", E:"DF", F:"BE", G:"D", H:""}

setup = ->
	createCanvas 1100,700
	maze = maze.split '\n'
	rectMode CENTER,CENTER
	textAlign CENTER,CENTER
	textSize 50
	sc()
	for line,j in maze
		for ch,i in line
			if ch in "ABCDEFGH"
				x = OFF + SZ*i
				y = OFF + SZ*j
				do (ch) ->
					buttons.push new Button ch,x,y, () ->
						if ch in moves[currColor][curr]
							curr = ch
							currColor = 1 - currColor

draw = ->
	bg 0.5
	for line,j in maze
		for ch,i in line
			x = OFF + SZ*i
			y = OFF + SZ*j
			if ch in '|-' then fc 0,0,1 # Blue
			if ch=='|' then rect x,y,TH,SZ
			if ch=='-' then rect x,y,SZ,TH

			if ch in '!=' then fc 1,0,0 # Red
			if ch=='!' then rect x,y,TH,SZ
			if ch=='=' then rect x,y,SZ,TH

			if ch=='#' then fc 1,1,0 # Yellow
			if ch=='#' then rect x,y,SZ,SZ

	for button in buttons
		button.draw()

	fc 0
	text 'Go from A to H',350,550
	text 'Jump in order:',350,600
	text 'red, blue, red, blue...',350,650
	text 'Tekniska Museet',900,550

	if curr=='H' then text 'Excellent!',900,650

mousePressed = ->
	for button in buttons
		if button.inside mouseX,mouseY then button.click()