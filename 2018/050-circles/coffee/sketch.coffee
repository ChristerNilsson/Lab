R = 30
circles = []

class Circle
	constructor : (@x=random(R,width-R),@y=random(R,height-R),@r=R) ->
	draw : -> circle @x,@y,@r
	overlap : (o) -> o.r + @r > dist o.x,o.y,@x,@y

overlap = (d) ->
	for c in circles
		if d.overlap c then return true
	false 

setup = ->
	createCanvas 400,400
	fc 1,0,0
	while circles.length < 25
		d = new Circle()
		if not overlap d then circles.push d

draw = ->
	bg 0.5
	for c in circles
		c.draw()