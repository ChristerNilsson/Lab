setup = ->
	createCanvas 6*220,4*220+60
	xdraw()
	save('biggrid.jpg')

one = (x,y) ->
	push()
	translate x,y
	scale 2
	for i in range 11
		line 0,20*i,200,20*i
	for i in range 11
		line 20*i,0,20*i,200
	pop()

xy = (x,y) ->
	push()
	translate x,y
	one 30,30
	for i in range 11
		textAlign CENTER,CENTER
		text 20*i,30+40*i,15
		textAlign RIGHT,CENTER
		text 20*i,25,30+40*i
	pop()

ij = (x,y) ->
	push()
	translate x,y
	one 30,30
	for i in range 10
		textAlign CENTER,CENTER
		text i,50+40*i,15
		textAlign RIGHT,CENTER
		text i,20,50+40*i
	pop()

xdraw = ->
	bg 1
	sc 0
	ij 0,0
	xy 0,440
	ij 440,0
	xy 440,440
	ij 880,0
	xy 880,440

	textSize 20
	textAlign CENTER,CENTER
	text 'p5Dojo.com',220+10,900
	text 'Textprogrammering med Coffeescript och Javascript',660+10,900
	text 'p5',660+440+10,900
