isometric = null

class Isometric
	constructor : (@i=0.5, @j=0.75, @k=1, @alpha=1) ->
		@n=10
		@dx=10
		@dy=5
		@blocks = {}
		@w2 = 2*width/4
		@w3 = 3*width/4
		@w4 = 4*width/4
		@r=1
		@g=1
		@b=1

	setColor : (@r,@g,@b) ->
	add : (i,j,k) -> @blocks[@n*@n*i+@n*j+k] = [@r,@g,@b]
	draw : -> @drawBlock index for index in range @n*@n*@n

	drawBlock : (index) ->
		f = (i,j,k) =>
			i = 10-i
			j = 10-j
			[@w2+i*@dx-2*j*@dy, @w4-j*@dy-i*@dx/2 - k*@dy*2]

		q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]
		block = @blocks[index]
		if not block? then return
		[r,g,b] = block
		k = index % @n; index //= @n
		j = index % @n; index //= @n
		i = index
		p0 = f i,  j,  k # egentligen osynlig
		p1 = f i+1,j,  k
		p2 = f i,  j+1,k
		p3 = f i+1,j+1,k
		p4 = f i  ,j,  k+1
		p5 = f i+1,j,  k+1
		p6 = f i  ,j+1,k+1
		p7 = f i+1,j+1,k+1
		fc r*@k,g*@k,b*@k,@alpha
		q p4,p5,p7,p6 # roof
		fc r*@j,g*@j,b*@j,@alpha
		q p2,p6,p7,p3 # left
		fc r*@i,g*@i,b*@i,@alpha
		q p1,p3,p7,p5 # right

	grid : ->
		for i in range @n+1
			line @w2+@dx*i, @w4-@dy*i,     @dx*i, @w3-@dy*i
			line @w2-@dx*i, @w4-@dy*i, @w4-@dx*i, @w3-@dy*i

	box : ->
		@blocks = []
		for i in range @n
			for j in range @n
				for k in range @n
					tot = 0
					if i in [2,3,4,5,6,7] then tot++
					if j in [2,3,4,5,6,7] then tot++
					if k in [2,3,4,5,6,7] then tot++
					if tot <= 1
						@setColor i/9,j/9,k/9
						@add i,j,k

	sphere : ->
		@blocks = []
		for i in range @n
			for j in range @n
				for k in range @n
					@setColor i/(@n-1),j/(@n-1),k/(@n-1)
					if (i-4.5)*(i-4.5) + (j-4.5)*(j-4.5) + (k-4.5)*(k-4.5) < 23 then @add i,j,k

setup = ->
	createCanvas 200,200
	isometric = new Isometric
	xdraw()

xdraw = ->
	bg 0.5
	isometric.grid()
	sc()
	isometric.box()
	#isometric.sphere()
	isometric.draw()