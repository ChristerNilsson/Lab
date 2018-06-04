class Button
	constructor : (@prompt,@x,@y,@click = ->) ->
		@radius = 100
	draw : ->
		sw 2
		circle @x,@y,@radius
		textAlign CENTER,CENTER
		textSize 72
		text @prompt,@x,@y