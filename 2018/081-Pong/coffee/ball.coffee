class Ball 
	constructor : (@x,@y, @w,@h) ->
		@dx = 0
		@dy = 0

	collides : (p) ->
		if abs(@x - p.x) > (p.w + @w)/2 then return false
		if abs(@y - p.y) > (p.h + @h)/2 then return false
		true

	reset : ->
		@x = WIDTH/2
		@y = HEIGHT/2
		@dx = 0
		@dy = 0

	update : (dt) ->
		@x += @dx * dt
		@y += @dy * dt

	render : -> rect @x, @y, @w, @h

	bounce : (y) ->
		@y = y
		@dy = -@dy
