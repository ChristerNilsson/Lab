class Obstacle extends Rectangle
	constructor : (x, y, w, h, @speed) -> super
	update : ->
		@move @speed, 0
		if @x > width + grid_size then @x = - @w - grid_size
		if @x < - @w - grid_size then @x = width + grid_size
	show : ->
		fill 200
		super