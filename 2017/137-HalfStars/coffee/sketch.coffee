setup = ->
	createCanvas 800,160

draw = ->
	bg 0.5
	drawStars int((mouseX+40)/80) / 2

drawStars = (rate) ->
	gold = 2 * rate
	lst = range 10
	for i in range 5
		if gold <= 0 then lst = []
		if gold == 1 then lst = [5,6,7,8,9]
		gold -= 2
		drawStar  80+i*160,88,80,29,lst

drawStar = (x0,y0,r1,r2,fill) ->
	antal = 0
	for i in range 5
		v = i*72-54
		x1 = int x0+r1*cos radians v+36
		y1 = int y0+r1*sin radians v+36
		x2 = int x0+r2*cos radians v
		y2 = int y0+r2*sin radians v
		x3 = int x0+r1*cos radians v-36
		y3 = int y0+r1*sin radians v-36
		if antal in fill then fc 1,1,antal%2 else fc 0
		triangle x0,y0,x3,y3,x2,y2 
		antal++
		if antal in fill then fc 1,1,antal%2 else fc 0
		triangle x0,y0,x1,y1,x2,y2 
		antal++
