# https://10print.org

setup = ->
	createCanvas windowWidth,windowHeight
	d = 20
	for x in range 0,width,d
		for y in range 0,height,d
			e = if random(1) < 0.5 then d else 0
			line x+d-e,y, x+e,y+d