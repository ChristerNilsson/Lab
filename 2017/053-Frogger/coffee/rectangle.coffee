class Rectangle
	constructor : (@x, @y, @w, @h) ->
	intersects : (o) -> ! (@x+@w <= o.x || @x >= o.x+o.w || @y+@h <= o.y || @y >= o.y+o.h)
	move : (x, y) -> [@x,@y] = [@x+x,@y+y]
	show : -> rect @x, @y, @w, @h