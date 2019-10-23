#FILE = [1,480,640,'../game001.mp4',[[140,176],[323,173],[146,548],[332,546]]
#FILE = [2,640,480,'../game005.mp4',[[106,149],[452,152],[107,320],[452,323]]]
#FILE = [2,640,480,'../game006.mp4',[[134,168],[502,171],[136,350],[499,353]]]
#FILE = [2,640,480,'../game007.mp4',[[144,160],[513,171],[140,341],[506,356]]]
#FILE = [2,640,480,'../game008.mp4',[[184,171],[470,173],[183,312],[466,316]]]
FILE = [2,640,480,'../game009.mp4',[[113,176],[402,180],[114,319],[398,322]]]
#FILE = [2,640,480,'../game010.mp4',[[137,179],[419,179],[137,317],[416,320]]]

candidates = [] # Dessa drag ska skapas av StockFish. On the fly.
candidates.push ['',    'a2a3 a2a4 b2b3 b2b4 c2c3 c2c4 d2d3 d2d4 e2e3 e2e4 f2f3 f2f4 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 g1f3 g1h3'.split ' ']
candidates.push ['g1f3','a7a6 a7a5 b7b6 b7b5 c7c6 c7c5 d7d6 d7d5 e7e6 e7e5 f7f6 f7f5 g7g6 g7g5 h7h6 h7h5 b8a6 b8c6 g8f6 g8h6'.split ' ']
candidates.push ['d7d5','a2a3 a2a4 b2b3 b2b4 c2c3 c2c4 d2d3 d2d4 e2e3 e2e4 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 f3g1 f3d4 f3e5 f3g5 f3h4'.split ' ']
candidates.push ['c2c4','a7a6 a7a5 b7b6 b7b5 c7c6 c7c5 d5d4 d5c4 e7e6 e7e5 f7f6 f7f5 g7g6 g7g5 h7h6 h7h5 b8a6 b8c6 b8d7 g8f6 g8h6'.split ' ']
candidates.push ['d5d4','a2a3 a2a4 b1a3 b1c3 b2b3 b2b4 c4c5 d1c2 d1b3 d1a4 d2d3 e2e3 e2e4 f3g1 f3d4 f3e5 f3g5 f3h4 g2g3 g2g4 h2h3 h2h4 h1g1'.split ' ']
candidates.push ['d1c2','a7a6 a7a5 b7b6 b7b5 c7c6 c7c5 d4d3 d8d7 d8d6 d8d5 e7e6 e7e5 f7f6 f7f5 g7g6 g7g5 h7h6 h7h5 b8a6 b8c6 b8d7 g8f6 g8h6'.split ' ']
candidates.push ['b8c6','a2a3 a2a4 b2b3 b2b4 c4c5 d2d3 e2e3 e2e4 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 f1e2 f1d3 f3g1 f3d4 f3e5 f3g5 f3h4'.split ' ']
candidates.push ['e2e3','a7a6 a7a5 b7b6 b7b5 c6b8 c6a5 c6b4 c6e5 d4d3 d4e3 d8d7 d8d6 d8d5 e7e6 e7e5 f7f6 f7f5 g7g6 g7g5 h7h6 h7h5 b8a6 b8c6 b8d7 g8f6 g8h6'.split ' ']
candidates.push ['e7e5','a2a3 a2a4 b2b3 b2b4 c4c5 d2d3 e2e3 e3d4 e3e4 g2g3 g2g4 h2h3 h2h4 b1a3 b1c3 f1e2 f1d3 f3g1 f3d4 f3e5 f3g5 f3h4'.split ' ']
candidates.push ['d2d3','a7a6 a7a5 b7b6 b7b5 b8a6 b8c6 b8d7 c6b8 c6a5 c6b4 c6e7 d4e3 d8d7 d8d6 d8d5 d8e7 d8f6 d8g5 d8h4 f7f6 f7f5 f8e7 f8d6 f8c5 f8b4 f8a3 g7g6 g7g5 g8f6 g8h6 h7h6 h7h5'.split ' ']
candidates.push ['g8f6','a2a3 a2a4 b1a3 b1c3 b2b3 b2b4 c1d2 c2a4 c2b3 c2d1 c2d2 c2e2 c4c5 e3d4 e3e4 f1e2 f3d2 f3d4 f3e5 f3g1 f3g5 f3h4 g2g3 g2g4 h1g1 h2h3 h2h4'.split ' ']
candidates.push ['g2g3','a7a6 a7a5 a8b8 b7b6 b7b5 c6b8 c6a5 c6b4 c6e7 c8d7 c8e6 c8f5 c8g4 c8h3 d4e3 d8d7 d8d6 d8d5 d8e7 e5e4 e8d7 e8e7 f6d5 f6d7 f6e4 f6g4 f6g8 f8e7 f8d6 f8c5 f8b4 f8a3 g7g6 g7g5 h7h5 h7h6 h8g8'.split ' ']
candidates.push ['c8g4','a2a3 a2a4 b1a3 b1c3 b1d2 b2b3 b2b4 c1d2 c2a4 c2b3 c2d1 c2d2 c2e2 c4c5 e1d1 e1d2 e1e2 e3d4 e3e4 f1e2 f1g2 f3d2 f3d4 f3e5 f3g1 f3g5 f3h4 g2g3 h1g1 h2h3 h2h4 h1g1'.split ' ']
candidates.push ['f1g2','a7a6 a7a5 a8b8 a8c8 b7b6 b7b5 c6a5 c6b4 c6b8 c6e7 d4e3 d8b8 d8c8 d8d7 d8d6 d8d5 d8e7 e5e4 e8d7 e8e7 f6d5 f6d7 f6e4 f6g8 f8e7 f8d6 f8c5 f8b4 f8a3 g4c8 g4d7 g4e6 g4f3 g4f5 g4h3 g4h5 g7g5 g7g6 h7h5 h7h6 h8g8'.split ' ']
candidates.push ['c6b4','a2a3 a2a4 b1a3 b1c3 b1d2 b2b3 c1d2 c2a4 c2b3 c2d1 c2d2 c2e2 c4c5 e1d1 e1d2 e1e2 e1f1 e3d4 e3e4 f3d2 f3d4 f3e5 f3g1 f3g5 f3h4 g2f1 g2h3 h1g1 h1f1 h2h3 h2h4'.split ' ']
candidates.push ['c2a4','b7b5 c7c6 d8d7 e8e7 f6d7 g4d7'.split ' ']
candidates.push ['d8d7','a2a3 a4a3 a4a5 a4a6 a4a7 a4b3 a4b4 a4b5 a4c2 a4c6 a4d1 a4d7 b1a3 b1c3 b1d2 b2b3 c1d2 c4c5 e1d1 e1d2 e1e2 e1f1 e3d4 e3e4 f3d2 f3d4 f3e5 f3g1 f3g5 f3h4 g2f1 g2h3 h1g1 h1f1 h2h3 h2h4'.split ' ']
candidates.push ['a4d1','a7a5 a7a6 a8b8 a8c8 a8d8 b4a2 b4a6 b4c2 b4c6 b4d3 b4d5 b7b5 b7b6 c7c5 c7c6 d4e3 d7a4 d7b5 d7c6 d7c8 d7d5 d7d6 d7d8 d7e6 d7e7 d7f5 d8c8 e5e4 e8d8 e8e7 f6d5 f6e4 f6g8 f6h5 f8e7 f8d6 f8c5 g4e6 g4f3 g4f5 g4h3 g4h5 g7g5 g7g6 h7h5 h7h6 h8g8'.split ' ']
candidates.push ['d4e3','a2a3 a2a4 b1a3 b1c3 b1d2 b2b3 c1d2 c1e3 c4c5 d1a4 d1b3 d1c2 d1d2 d1e2 e1d2 e1e2 e1f1 f2e3 f3d2 f3d4 f3e5 f3g1 f3g5 f3h4 g2f1 g2h3 h1g1 h1f1 h2h3 h2h4'.split ' ']
candidates.push ['c1e3','a7a5 a7a6 a8b8 a8c8 a8d8 b4a2 b4a6 b4c2 b4c6 b4d3 b4d5 b7b5 b7b6 c7c5 c7c6 d7a4 d7b5 d7c6 d7c8 d7d3 d7d4 d7d5 d7d6 d7d8 d7e6 d7e7 d7f5 e5e4 e8d8 e8e7 f6d5 f6e4 f6g8 f6h5 f8e7 f8d6 f8c5 g4e6 g4f3 g4f5 g4h3 g4h5 g7g5 g7g6 h7h5 h7h6 h8g8'.split ' ']
candidates.push ['b4d3','d1d3 e1d2 e1e2 e1f1'.split ' ']
candidates.push ['e1f1','a7a5 a7a6 a8b8 a8c8 a8d8 b7b5 b7b6 c7c5 c7c6 d7a4 d7b5 d7c6 d7c8 d7d4 d7d5 d7d6 d7d8 d7e6 d7e7 d7f5 e5e4 e8d8 e8e7 f6d5 f6e4 f6g8 f6h5 f8e7 f8d6 f8c5 f8b4 f8a3 g4e6 g4f3 g4f5 g4h3 g4h5 g7g5 g7g6 h7h5 h7h6 h8g8'.split ' ']
candidates.push ['e5e4','a2a3 a2a4 b1a3 b1c3 b1d2 b2b3 b2b4 c4c5 d1a4 d1b3 d1c1 d1c2 d1d2 d1d3 d1e2 d1e1 d1e2 e3a7 e3b6 e3c1 e3c5 e3d2 e3d4 e3f4 e3g5 e3h6 f1e2 f1g2 f3d2 f3d4 f3e1 f3e5 f3g1 f3g5 f3h4 g2h3 h1g1 h2h3 h2h4'.split ' ']

hist = [] # Innehåller de drag spelarna utfört. Format [0..63,0..63]

[TYPE,W,H,NAME,PUNKTER] = FILE

playing = true
video = null
button = null
index = 0
# canvas = null
values = []
current = [] # Aktuellt drag. visas med två gula cirklar. [0..63,0..63]

# 36 each of these
edgePoints = [] # [x,y] in pixels. Används för att detektera om någon hand stör.
edges = [] # 9 points of [r,g,b] each

# 64 each of these
squarePoints = [] # [x,y] in pixels
pretty = [] # a8 b8 ... g1 h1
square0 = [] # 9 points of [r,g,b] each

p0 = p1 = p2 = p3 = null
p4 = p5 = p6 = p7 = null

for row in "87654321"
	for col in "abcdefgh"
		pretty.push col+row

lerp2 = (p, q, amt) => createVector(lerp(p.x,q.x,amt), lerp(p.y,q.y,amt))

preload = -> video = createVideo NAME 

setup = () =>
	createCanvas W,H+100

	pixelDensity 1

	textAlign CENTER,CENTER
	textSize 20

	button = createButton 'play'
	video.hide()
	button.mousePressed toggleVid 

	video.loop()

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

	p0 = lerp2(p8,p10,-0.15) # Yttre hörn. Typ 10x10 rutor.
	p1 = lerp2(p9,p11,-0.15)
	p2 = lerp2(p8,p10,1.15)
	p3 = lerp2(p9,p11,1.15)

	# Beräkna koordinater för 36 + 64 rutor.
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
	if playing then video.pause()	else video.play()
	playing = not playing

linje = (p,q) -> line p.x,p.y,q.x,q.y
		
# Beräkna Manhattanavstånd för nio rgb-punkter.
colDist3x3 = (lst0,lst1) ->
	res = 0
	for i in range 9
		[r0,g0,b0] = lst0[i]
		[r1,g1,b1] = lst1[i]       # GREEN
		res += 0*Math.abs(r0-r1) + 3*Math.abs(g0-g1) + 0*Math.abs(b0-b1)
	res

# Hämtar en pixel. 10x snabbare än get.
myget = (x,y) ->
	d = pixelDensity() # laptop=2
	index = (x + y * width) * 4
	[pixels[index+0],pixels[index+1],pixels[index+2],pixels[index+3]] # rgba

# Hämtar färgen för en schackruta bestående av nio pixlar.
get3x3 = (x,y) ->
	result = []
	for i in [-1,0,1]
		for j in [-1,0,1]
			result.push myget x+5*i,y+5*j # MAGIC!
	result

# Visa de spelade dragen på formatet e2e4
showHist = (hist) ->
	result = hist.map ([i,j]) -> pretty[i] + pretty[j]
	result.join ' '

draw = ->
	bg 1
	image video,0,0,W,H
	noStroke() 
	fill 0
	text Math.round(frameRate()),W/2,H+50

	# stroke 255,255,0
	# linje p4,p5
	# linje p5,p7
	# linje p6,p7
	# linje p4,p6
	# return

	loadPixels()

	accumulate = (rgb, rgb9) ->
		for i in range 9
			rgb[0] += rgb9[i][0]
			rgb[1] += rgb9[i][1]
			rgb[2] += rgb9[i][2]

	diff = (piece,square) ->
		[rp,gp,bp] = piece
		[rs,gs,bs] = square
		[Math.abs(rp-rs), Math.abs(gp-gs), Math.abs(bp-bs)]

	calibrate = ->
		sqColor = '1010101001010101101010100101010110101010010101011010101001010101'
		blackPieces = range 16
		whitePieces = range 48,64
		blackSquares = [17,19,21,23, 24,26,28,30, 33,35,37,39, 40,42,44,46]
		whiteSquares = [16,18,20,22, 25,27,29,31, 32,34,36,38, 41,43,45,47]

		bp = [0,0,0]
		wp = [0,0,0]
		bs = [0,0,0]
		ws = [0,0,0]

		for i in range 64
			[x,y] = squarePoints[i]
			rgb9 = get3x3 x,y
			#console.log rgb9
			if i in blackPieces then accumulate bp, rgb9
			if i in whitePieces then accumulate wp, rgb9
			if i in blackSquares then accumulate bs, rgb9
			if i in whiteSquares then accumulate ws, rgb9

		console.log bp
		console.log wp
		console.log bs
		console.log ws

		console.log 'bb',diff bp,bs
		console.log 'bw',diff bp,ws
		console.log 'wb',diff wp,bs
		console.log 'ww',diff wp,ws

	# Hämta pixlar för ramen, att jämföra med.
	if frameCount == 20 # MAGIC!
		#calibrate()
		for [x,y] in edgePoints
			edges.push get3x3 x,y
		#console.log edges

	#return

	edges1 = []
	stroke 255,255,0
	for [x,y] in edgePoints
		edges1.push get3x3 x,y

	# Beräkna hur många yttre rutor som innehåller händer.
	if edges.length > 0
		edgeCount = 0
		fill 255,255,0
		for i in range edges.length
			value =  colDist3x3 edges[i],edges1[i]
			if 1200 < value # MAGIC!
				edgeCount++
				[x,y] = edgePoints[i]
				circle x,y,10

		# Beräkna ingas drag om störning finns.
		if edgeCount == 0

			# Hämta 64 x 9 pixlar
			square1 = []
			for [x,y] in squarePoints
				square1.push get3x3 x,y

			# Ta reda på det troligaste draget mha candidates
			if square0.length == 64
				resultat = []
				cand = candidates[hist.length]
				for candidate in cand[1]
					i = pretty.indexOf candidate.slice 0,2
					j = pretty.indexOf candidate.slice 2,4
					total = 0
					total += colDist3x3 square0[i],square1[i] 
					total += colDist3x3 square0[j],square1[j] 
					resultat.push [total,i,j]
				resultat.sort (a,b) -> b[0]-a[0]
				if resultat[0][0] > 500  # MAGIC!
					console.log visaDrag(resultat[0]), visaDrag(resultat[1])
					[total,i,j] = resultat[0]
					current = [i,j]
					hist.push current
					#console.log showHist hist

			square0 = square1

	sw 1
	stroke 255,0,0
	for i in current
		[x,y] = squarePoints[i]
		circle x,y,10

visaDrag = ([score, index0, index1]) -> "#{score} #{pretty[index0]}#{pretty[index1]}"

mousePressed = () -> console.log mouseX,mouseY

######## Graveyard #######

# content = [] # -6..6 piece and color
#LITTERA = 'pnbrqk KQRBNP' # (black WHITE)
# sqColor = '1010101001010101101010100101010110101010010101011010101001010101'
# square1 = [] # 9 points of [r,g,b] each
# fillContent = () ->
# 	for ch in "rnbqkbnrpppppppp                                PPPPPPPPRNBQKBNR"
# 		content.push -6 + LITTERA.indexOf ch
	# fillContent()
# colDist = ([r1,g1,b1],[r2,g2,b2]) -> Math.abs(r1-r2) + Math.abs(g1-g2) + Math.abs(b1-b2)
