dx = 10
dy = 5
w  = 0
w2 = 0
w1 = 0

setup = ->
	createCanvas 200,200
	w = width
	w2 = w/2
	w1 = (w+w2)/2
	xdraw()

grid = ->
	w = width
	w2 = w/2
	w1 = (w+w2)/2
	for i in range width/20+1
		x1 = lerp w2,w2+dx,i
		x2 = lerp   0, dx,i
		y1 = lerp w,w-dy,i
		y2 = lerp w1,w1-dy,i
		line x1,y1,x2,y2
		x1 = lerp w2,w2-dx,i
		x2 = lerp w,w-dx,i
		y1 = lerp w,w-dy,i
		y2 = lerp w1,w1-dy,i
		line x1,y1,x2,y2

f = (i,j,k) -> [w2+i*dx-2*j*dy, w-j*dy-i*dx/2 - k*dy*2]

q = (a,b,c,d) -> quad a[0],a[1], b[0],b[1], c[0],c[1], d[0],d[1]

block = (i,j,k, w=1,h=1,l=1) ->
	p0 = f i,  j,  k
	p1 = f i+w,j,  k
	p2 = f i,  j+h,k
	p3 = f i+w,j+h,k
	p4 = f i  ,j,  k+l
	p5 = f i+w,j,  k+l
	p6 = f i  ,j+h,k+l
	p7 = f i+w,j+h,k+l
	#sc()
	fc 1,0,0
	q p0,p4,p5,p1
	fc 0,1,0
	q p0,p2,p6,p4
	fc 0,0,1
	q p4,p6,p7,p5

xdraw = ->
	bg 0.5
	grid()
	blocks = []
	n = 10
	for i in range n
		for j in range n
			for k in range n
				blocks.push [i,j,k] # if not (i in [1,4,7] or j in [1,4,7] or k in [1,4,7])
	blocks = _.sortBy blocks, ([i,j,k]) -> -(i*i+j*j+(n-k)*(n-k))
	for [i,j,k] in blocks
		block i,j,k