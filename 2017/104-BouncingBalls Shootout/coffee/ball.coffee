class Ball
	constructor : (
		@type
		@radius
		@x = random @radius, width-@radius
		@y = @radius
		@vx = 1 + random 3
		@vy = 0) ->
		@age = 0

	draw : ->
		@age += 1
		if @type==0 then fc 0,0,0
		if @type==1 then fc 1,1,0
		if @type==2 then fc 1,0,0
		circle @x,@y,@radius
		if @x<@radius or @x > width-@radius then @vx=-@vx
		if @y > height-@radius then @vy = -@vy else @vy += 0.1
		@x += @vx
		@y += @vy

	distance : (o) -> dist @x, @y, o.x, o.y
