class Ball
	constructor : (@g,@radius) ->
		@x = random @radius, width-@radius
		@y = @radius + random -10,10
		@vx = random 1,4
		if 0.5 < random 1 then @vx = -@vx
		@vy = 0
		@ay = 0.1
		@age = 0

	draw : ->
		fc 1,@g,0
		circle @x,@y,@radius

	update : ->
		@age += 1
		if @x<@radius or @x > width-@radius then @vx=-@vx
		if @y > height-@radius
			@vy = -@vy
			@x = @x + random -0.1,0.1
		else 
			@vy += @ay
		@x += @vx
		@y += @vy

	distance : (o) -> dist @x, @y, o.x, o.y