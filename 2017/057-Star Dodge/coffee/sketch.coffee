# https://github.com/paf31/star-dodge-clone 200 LOC
# https://runelm.io/c/u4y 400 LOC
stardodge = null
class StarDodge
	constructor : (@level=0, @delta=50) -> @startNewGame 1
	startNewGame : (dlevel) ->
		if dlevel==1
			@stars = []
			for x in range @delta,width,@delta
				for y in range @delta,height,@delta
					@stars.push [x + int(random(-@delta/4,@delta/4)), y + int(random(-@delta/4,@delta/4))]
		@level += dlevel
		[@x,@y] = [0,height/2]
		bg 0.5
		sc 0
		for [x,y] in @stars
			circle x,y,@level
		rect width-3,0.4*height,2,0.2*height
	draw : ->
		[@x,@y] = [@x+1, @y + if keyIsDown 32 then 1 else -1]
		sc 1
		point @x,@y
		if @x > width and 0.4*height < @y < 0.6*height then return @startNewGame 1
		if @y<0 or @y>height or @x>width then return @startNewGame 0
		for [x,y] in @stars
			if dist(@x,@y,x,y) < @level then return @startNewGame 0
setup = ->
	createCanvas windowWidth,windowHeight
	stardodge = new StarDodge
draw = -> stardodge.draw()