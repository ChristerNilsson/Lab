class Ball
	constructor : ->
		@x = width / 2
		@y = height / 2

		@r = 30
		@vx = 6
		@vy = 6

	update : ->
		@x += @vx
		@y += @vy

	display : -> ellipse @x, @y, @r * 2

	checkEdges : ->
		if @x < @r or @x > width - @r then @vx = -@vx
		if @y < @r and ball.vy < 0 then @vy = -@vy

	meets : (p) -> p.y - @r < @y < p.y and p.x - @r < @x < p.x + p.w + @r
	hits : (brick) -> dist(@x, @y, brick.x, brick.y) < brick.r + @r