class Button
	constructor : (@prompt,@x,@y,@click = ->) -> @radius = 100
	contains : (mx,my) -> @radius > dist mx,my,@x,@y
	draw : ->
		circle @x,@y,@radius
		textAlign CENTER,CENTER
		textSize 72
		text @prompt,@x,@y