# https://en.wikipedia.org/wiki/Union_Jack#/media/File:United_Kingdom_Flag_Specifications.svg

# 25:2:6:2:25 = 60
# 10:2:6:2:10 = 30

setup = -> 
	createCanvas 1200,600
	angleMode DEGREES
	vinkel = atan2 30, 60
	translate width/2,height/2
	scale 20
	sc()
	bg 0,0,1

	diagonal2 vinkel
	diagonal2 -vinkel

	for i in range 2 # white
		arm 1,1,1,10,60
		rotate 90

	for i in range 2 # red
		arm 1,0,0,6,60
		rotate 90

diagonal2 = (vinkel) ->
	rotate vinkel
	diagonal() 
	rotate 180
	diagonal() 
	rotate -vinkel

diagonal = ->
	rectMode CORNER
	fc 1
	rect 0,-3,40,6
	fc 1,0,0
	rect 0,-2,40,2

arm = (r,g,b,w,h) ->
	rectMode CENTER
	fc r,g,b
	rect 0,0,w,h
