class Frog extends Rectangle
	constructor : (x, y, w, h, @sitting_on = null) -> super
	attach : (other) -> @sitting_on = other
	update : ->
		if @sitting_on != null then @move @sitting_on.speed,0
		@x = constrain @x, 0, width - @w
	show : ->
		fill 0, 255, 0, 200
		super