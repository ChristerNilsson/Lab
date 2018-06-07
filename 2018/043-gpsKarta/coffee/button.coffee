class Button
	constructor : (@prompt,@x,@y,@click = ->) -> @radius = 100
	contains : (mx,my) -> @radius > dist mx,my,@x,@y
	draw : ->
		sw 3
		sc 1,1,0,0.5
		fc()
		circle @x,@y,@radius
		textAlign CENTER,CENTER
		textSize 100
		fc 1,1,0,0.5
		sc 0
		text @prompt,@x,@y