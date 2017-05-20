isometric = null

class Isometric
	constructor : (@alpha=1) ->
		@n=10
		@dx=10
		@dy=5
		@blocks = []
		@w = width
		@w2 = @w/2
		@w1 = (@w+@w2)/2
		@r=1
		@g=1
		@b=1

	setColor : (@r,@g,@b) ->
	add : (i,j,k) -> @blocks.push [i,j,k,@r,@g,@b]
	sort : -> @blocks = _.sortBy @blocks, ([i,j,k,r,g,b]) => -(i*i+j*j+(@n-k)*(@n-k))
	draw : -> @drawBlock block for block in @blocks

	drawBlock : (block) ->
		f = (i,j,k) => [@w2+i*@dx-2*j*@dy, @w-j*@dy-i*@dx/2 - k*@dy*2]
		q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]
		[i,j,k,r,g,b] = block
		p0 = f i,  j,  k
		p1 = f i+1,j,  k
		p2 = f i,  j+1,k
		p3 = f i+1,j+1,k
		p4 = f i  ,j,  k+1
		p5 = f i+1,j,  k+1
		p6 = f i  ,j+1,k+1
		p7 = f i+1,j+1,k+1
		fc r,g,b,@alpha
		q p4,p6,p7,p5
		fc r*0.5,g*0.5,b*0.5,@alpha
		q p0,p2,p6,p4
		fc r*0.75,g*0.75,b*0.75,@alpha
		q p0,p4,p5,p1

	grid : ->
		for i in range width/20+1
			x1 = lerp @w2,@w2+@dx,i
			x2 = lerp   0, @dx,i
			y1 = lerp @w,@w-@dy,i
			y2 = lerp @w1,@w1-@dy,i
			line x1,y1,x2,y2
			x1 = lerp @w2,@w2-@dx,i
			x2 = lerp @w,@w-@dx,i
			y1 = lerp @w,@w-@dy,i
			y2 = lerp @w1,@w1-@dy,i
			line x1,y1,x2,y2

	box : ->
		@blocks = []
		for i in range 10
			for a in [0,9]
				for b in [0,9]
					@setColor 1,0,0
					@add i,a,b
					@setColor 1,1,0
					@add a,i,b
					@setColor 0,1,0
					@add a,b,i
		@sort()

setup = ->
	createCanvas 200,200
	isometric = new Isometric
	xdraw()

xdraw = ->
	bg 1
	#isometric.grid()
	sc()
	isometric.box()
	isometric.draw()

