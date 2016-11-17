class Button
	constructor: (@parent,@x,@y,@w,@h,@txt) -> # sixties

	draw : ->
		g.push()
		g.translate width*@x/60,height*@y/60
		g.dump(@txt)

		@x0 = g.x
		@y0 = g.y
		#@w0 = @parent.width * @w/60


		fill 255,255,0
		rect 0, 0, width*(@w)/60-2, height*(@h)/60-2
		fill 0
		textSize 30
		text @txt, 0,0 
		g.pop()

	mousePressed : ->
		if @x0-50 <= mouseX <= @x0+50 and @y0-30 <= mouseY <= @y0+30 
			console.log @txt

