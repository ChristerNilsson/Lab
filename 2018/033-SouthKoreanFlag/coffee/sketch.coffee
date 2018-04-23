# https://en.wikipedia.org/wiki/Flag_of_South_Korea#/media/File:Flag_of_South_Korea_(construction_sheet).svg

vinkel = null

setup = -> 
	createCanvas 1200,800
	angleMode DEGREES
	rectMode CENTER
	vinkel = atan2 2, 3
	xdraw()

ram = ->
	fc 1
	sw 1/300
	sc 0
	rect 0,0,3,2

yinyang = ->
	sc()

	fc 1,0,0
	arc 0,0,1,1,180,0

	fc 0,0,1
	arc 0,0,1,1,0,180

	fc 1,0,0
	circle -1/4,0,1/4

	fc 0,0,1
	circle 1/4,0,1/4

streck = (pattern,offset,black,white) ->
	push()
	translate offset,0
	for p in pattern
		translate black/2,0
		fc 0
		sc 1
		rect 0,0,1/12,1/2
		if p == 0 
			fc 1
			sc 1
			rect 0,0,1/12,1/24
		translate black/2,0
		translate white,0

	pop()

xdraw = ->
	bg 0.5
	translate width/2,height/2
	scale 300

	ram()

	rotate vinkel

	yinyang()

	streck [1,1,1],-1/2-1/4,-1/12,-1/24 
	streck [0,0,0],1/2+1/4,1/12,1/24 

	rotate -2 * vinkel

	streck [1,0,1],-1/2-1/4,-1/12,-1/24 
	streck [0,1,0],1/2+1/4,1/12,1/24 
