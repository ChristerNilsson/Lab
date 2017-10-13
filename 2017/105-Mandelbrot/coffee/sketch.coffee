# z = z * z + c  
# todo undo
hist = []

x0 = -0.5 # mittpunkten
y0 = 0.0
SIZE = 100
zoom = 1/SIZE 
BITS = 4 
N = 2**BITS
N1 = N-1
DEPTH = 2**(3*BITS)

setup = ->
	createCanvas 2*SIZE,2*SIZE
	xdraw()

calc = (cx,cy) ->
	[x,y] = [0,0]
	count = 0
	for k in range DEPTH
		if dist(x,y,0,0) < 2
			count += 1
		else
			return count
		[x,y] = [x*x-y*y+cx, 2*x*y+cy]
	count

xdraw = ->
	for i in range -SIZE,SIZE
		for j in range -SIZE,SIZE
			cx = x0 + zoom*i
			cy = y0 + zoom*j
			f = calc(cx,cy)
			r = f%N; f = int f/N
			g = f%N; f = int f/N
			b = f%N; f = int f/N
			sc r/N1,g/N1,b/N1
			point SIZE+i,SIZE+j

mousePressed = ->
	print [x0,y0,zoom]
	hist.push [x0,y0,zoom]
	x0 = map mouseX,0,2*SIZE,x0-zoom*SIZE,x0+zoom*SIZE
	y0 = map mouseY,0,2*SIZE,y0-zoom*SIZE,y0+zoom*SIZE
	zoom = zoom/2
	xdraw()