class Bullet
	constructor : (@x,@y,@vx,@vy,@ay) ->
		@radius = 2
		@age = 0

	draw : ->
		fc 0,0,0
		circle @x,@y,@radius

	update : ->
		@age += 1
		if @x < @radius or @x > width-@radius then @vx=-@vx
		if @y > height-@radius then @vy = -@vy else @vy += @ay
		@x += @vx
		@y += @vy

	distance : (o) -> dist @x, @y, o.x, o.y