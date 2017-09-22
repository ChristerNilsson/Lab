class Ball
	constructor : ->
		@x = width / 2
		@y = height / 2

		@r = 30
		@vx = 4
		@vy = 4

	update : ->
		@x += @vx
		@y += @vy

	display : -> ellipse @x, @y, @r * 2

	checkEdges : ->
		if @x > width - @r then @vx *= -1
		if @x < @r then @vx *= -1
		if @y < @r and ball.vy < 0 then @vy *= -1

	meets : (p) -> p.y - @r < @y < p.y and p.x - @r < @x < p.x + p.w + @r
	hits : (brick) -> dist(@x, @y, brick.x, brick.y) < brick.r + @r
