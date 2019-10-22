#FILE = [1,480,640,'../game001.mp4',[[140,176],[323,173],[146,548],[332,546]]
#FILE = [2,640,480,'../game005.mp4',[[106,149],[452,152],[107,320],[452,323]]]
#FILE = [2,640,480,'../game006.mp4',[[134,168],[502,171],[136,350],[499,353]]]
FILE = [2,640,480,'../game007.mp4',[[144,160],[513,171],[140,341],[506,356]]]
#FILE = [2,640,480,'../game008.mp4',[[184,171],[470,173],[183,312],[466,316]]]

candidates = {}
candidates.g8f6 = 'a2a3 a2a4 b2b3 b2b4 c2b3 c2a4 c2c3 c2d2 c2d1 c2e2 c1d2 c4c5 e3d4 e3e4 g2g3 g2g4 h2h3 h2h4 f1e2 f3d4 f3e5 f3g5 f3h4 f3g1 f3d2 h1g1 e1d1 e1d2 e1e2'

[TYPE,W,H,NAME,PUNKTER] = FILE
		# p4 = createVector 136,177
		# p5 = createVector 414,176
		# p6 = createVector 136,315
		# p7 = createVector 414,314
		# p4 = createVector 107,148
		# p5 = createVector 453,152
		# p6 = createVector 108,321
		# p7 = createVector 451,323

LITTERA = 'pnbrqk KQRBNP' # (black WHITE)

playing = true
video = null
button = null
index = 0
canvas = null
values = []
current = []

# 36 each of these
edgePoints = [] # [x,y] in pixels
edges = [] # 9 points of [r,g,b] each

# 64 each of these
squarePoints = [] # [x,y] in pixels
content = [] # -6..6 piece and color
pretty = [] # a8 b8 ... g1 h1
sqColor = '1010101001010101101010100101010110101010010101011010101001010101'
square0 = [] # 9 points of [r,g,b] each
# square1 = [] # 9 points of [r,g,b] each

p0 = p1 = p2 = p3 = null
p4 = p5 = p6 = p7 = null

for row in "87654321"
	for col in "abcdefgh"
		pretty.push col+row

fillContent = () ->
	for ch in "rnbqkbnrpppppppp                                PPPPPPPPRNBQKBNR"
		content.push -6 + LITTERA.indexOf ch

lerp2 = (p, q, amt) => createVector(lerp(p.x,q.x,amt), lerp(p.y,q.y,amt))

preload = -> video = createVideo NAME 

setup = () =>
	canvas = createCanvas W,H+100

	pixelDensity(1)

	textAlign CENTER,CENTER
	textSize 20

	button = createButton 'play'
	video.hide()
	button.mousePressed toggleVid 

	video.loop()

	fillContent()
	console.log content

	p4 = createVector PUNKTER[0][0],PUNKTER[0][1]
	p5 = createVector PUNKTER[1][0],PUNKTER[1][1]
	p6 = createVector PUNKTER[2][0],PUNKTER[2][1]
	p7 = createVector PUNKTER[3][0],PUNKTER[3][1]
	
	if TYPE == 1
		p8 = lerp2(p4,p5,-0.8)
		p9 = lerp2(p4,p5, 1.8)
		p10 = lerp2(p6,p7,-0.8)
		p11 = lerp2(p6,p7, 1.8)

	if TYPE == 2
		p8 = lerp2(p4,p6,-0.8)
		p9 = lerp2(p4,p6, 1.8)
		p10 = lerp2(p5,p7,-0.8)
		p11 = lerp2(p5,p7, 1.8)

	p0 = lerp2(p8,p10,-0.15)
	p1 = lerp2(p9,p11,-0.15)
	p2 = lerp2(p8,p10,1.15)
	p3 = lerp2(p9,p11,1.15)

	for i in range 10
		q0 = lerp2 p0,p1,1/20+i/10
		q1 = lerp2 p2,p3,1/20+i/10
		for j in range 10
			w0 = lerp2 q0,q1,1/20+j/10
			w0.x = round w0.x
			w0.y = round w0.y
			if i in [0,9] or j in [0,9]
				edgePoints.push [w0.x,w0.y]
			else
				squarePoints.push [w0.x,w0.y]

toggleVid = () ->	
	if playing 
		video.pause()
	else
		video.play()
	playing = not playing

linje = (p,q) -> line p.x,p.y,q.x,q.y
		
colDist = ([r1,g1,b1],[r2,g2,b2]) -> Math.abs(r1-r2) + Math.abs(g1-g2) + Math.abs(b1-b2)

# Maximum color difference of 3x3 points
colDist3x3 = (lst0,lst1) -> 
	res = 0
	for i in range 9	
		[r0,g0,b0] = lst0[i]
		[r1,g1,b1] = lst1[i]
		res += Math.abs(r0-r1) + Math.abs(g0-g1) + Math.abs(b0-b1)
	res

myget = (x,y) ->
	d = pixelDensity() # laptop=2
	index = (x + y * width) * 4
	[pixels[index+0],pixels[index+1],pixels[index+2],pixels[index+3]] # rgba

get3x3 = (x,y) ->
	result = []
	for i in [-1,0,1]
		for j in [-1,0,1]
			result.push myget x+3*i,y+3*j
	result

# return list of 0..63
compare3x3 = (sq0,sq1) ->
	result = []
	values = []
	for i in range 64
		limit = 400
		value = colDist3x3 sq0[i],sq1[i]
		# if -1 != 'c2 c4 d5 d7'.indexOf pretty[i] 
		# 	console.log pretty[i], value
		values.push value
		#console.log pretty[i],value
		if limit <= value
			fill 255,0,0
			result.push i
			[x,y] = squarePoints[i]
			circle x,y,10
	result

draw = ->
	bg 1
	image video,0,0,W,H
	noStroke()
	fill 0
	text Math.round(frameRate()),W/2,H+50

	# linje p4,p5
	# linje p5,p7
	# linje p6,p7
	# linje p4,p6
	# return

	loadPixels()

	if frameCount == 20
		for [x,y] in edgePoints
			edges.push get3x3 x,y
		console.log edges

	edges1 = []
	stroke 255,255,0
	for [x,y] in edgePoints
		edges1.push get3x3 x,y

	if edges.length > 0
		edgeCount = 0
		fill 255,255,0
		for i in range edges.length
			value =  colDist3x3 edges[i],edges1[i]
			if 1200 < value
				edgeCount++
				[x,y] = edgePoints[i]
				circle x,y,10

		if edgeCount == 0
			square1 = []
			for [x,y] in squarePoints
				square1.push get3x3 x,y
			if square0.length == 64
				result = compare3x3 square0,square1
				s = ''
				if result.length > 0 then current = result
				for res in result
					s += pretty[res] + ' ' + values[res] + '|'
					#s += pretty[res] + ' '
				if s != '' then console.log s
			square0 = square1

	sw 1
	stroke 255,0,0
	for i in current
		[x,y] = squarePoints[i]
		circle x,y,10

#mousePressed = () -> console.log mouseX,mouseY