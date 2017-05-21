isometric = null

class Isometric
	constructor : (@alpha=1) ->
		@n=10
		@dx=10
		@dy=5
		@blocks = {}
		@w = width
		@w2 = @w/2
		@w1 = (@w+@w2)/2
		@r=1
		@g=1
		@b=1
		@index = @createIndex()

	setColor : (@r,@g,@b) ->
	add : (i,j,k) -> @blocks[@n*@n*i+@n*j+k] = [@r,@g,@b]
	draw : -> @drawBlock index for index in @index

	createIndex : ->
		arr = []
		for i in range @n
			for j in range @n
				for k in range @n
					arr.push [i,j,k]
		arr = _.sortBy arr, ([i,j,k]) => -(i*i+j*j+(@n-k)*(@n-k)) # rita längst bort först
		(@n*@n*i+@n*j+k for [i,j,k] in arr)

	drawBlock : (index) ->
		f = (i,j,k) => [@w2+i*@dx-2*j*@dy, @w-j*@dy-i*@dx/2 - k*@dy*2]
		q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]
		block = @blocks[index]
		if not block? then return
		[r,g,b] = block
		k = index % @n; index //= @n
		j = index % @n; index //= @n
		i = index
		p0 = f i,  j,  k
		p1 = f i+1,j,  k
		p2 = f i,  j+1,k
		p3 = f i+1,j+1,k  # egentligen osynlig
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
		for i in range @n+1
			line @w2+@dx*i, @w-@dy*i, @dx*i, @w1-@dy*i
			line @w2-@dx*i,@w-@dy*i,@w-@dx*i,@w1-@dy*i

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
		@setColor 1,0,0
		for i in range @n
			for j in range @n
				for k in range @n
					if (i-4.5)*(i-4.5) + (j-4.5)*(j-4.5) + (k-4.5)*(k-4.5) < 23 then @add i,j,k

setup = ->
	createCanvas 200,200
	isometric = new Isometric
	xdraw()

xdraw = ->
	bg 0.25
	isometric.grid()
	sc()
	isometric.box()
	isometric.draw()