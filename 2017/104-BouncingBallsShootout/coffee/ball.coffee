class Ball
	constructor : (@g,@radius) ->
		@x = random @radius, width-@radius
		@y = @radius + random -10,10
		@vx = 1 + random 3
		@vy = 0
		@ay = 0.1
		@age = 0

	draw : ->
		fc 1,@g,0
		circle @x,@y,@radius

	update : ->
		@age += 1
		if @x<@radius or @x > width-@radius then @vx=-@vx
		if @y > height-@radius then @vy = -@vy else @vy += @ay
		@x += @vx
		@y += @vy

	distance : (o) -> dist @x, @y, o.x, o.y