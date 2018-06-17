times = 1

n = 400

setup = -> 
	createCanvas 900, 900
	fc 0
	sc 0
	sw 1

draw = ->
	bg 1
	text times, 5, 25
	translate width/2, height/2
	
	for i in range 200
		angle1 = map i, 0, 200, 0, TWO_PI
		x1 = n * cos angle1
		y1 = n * sin angle1
		t = times/2000
		angle2 = t * angle1 #map t*i, 0, t*200, 0, t*TWO_PI
		x2 = n * cos angle2
		y2 = n * sin angle2
		line x1, y1, x2, y2
	
	times = min times+1, 20000
	