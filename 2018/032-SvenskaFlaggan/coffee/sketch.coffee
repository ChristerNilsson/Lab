# 5 2 9 = 16
# 4 2 4 = 10

setup = -> createCanvas 200,200

draw = ->
	scale 12
	bg 0.5
	sc()
	fc 0,0,1
	rect 0,0,16,10
	fc 1,1,0
	rect 5,0,2,10
	rect 0,4,16,2
