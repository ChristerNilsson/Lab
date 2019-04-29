class Button
	constructor : (@prompt,@x,@y,@click = ->) -> @radius = 100
	contains : (mx,my) -> @radius > dist mx,my,@x,@y
	draw : ->
		sw 1
		sc 0
		fc 1,1,1,0.8
		circle @x,@y,@radius
		textAlign CENTER,CENTER
		#textSize 100
		fc 0
		sc()
		n = str(@prompt).length
		if n>5 then n=5
		ts = [0,200,150,100,75,50][n]
		textSize ts
		text @prompt,@x,@y+ts*0.07