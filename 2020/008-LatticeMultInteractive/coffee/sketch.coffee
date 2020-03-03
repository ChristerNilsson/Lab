F1 = '19'
F2 = '8'

S = 36 * 1.055
S2 = S/2
S4 = S/4
DIAG = true
W = null
H = null
x0 = null
factors = []
checkbox = null 

carries = null
results = null
canvas = null

ripple = ->
	for i in range W+H
		results[i] += carries[i]
		carries[i+1] = floor results[i]/10
		results[i] %= 10

drawRect = ->
	push()
	rectMode CORNER
	fc()
	sc 0
	sw 3
	rect (x0-1)*S, S, S*W, S*H
	pop()

recalculate = ->
	carries = []
	results = []
	F1 = factors[0].value()
	F2 = factors[1].value()
	W = F1.length
	H = F2.length
	x0 = H+1+1
	canvas = createCanvas (x0+W)*S+1,(H+2)*S+1

	for i in range W+H
		carries.push 0
		results.push 0

	bg 1
	sc 0

	fc 0
	sc()
	textAlign CENTER,CENTER
	textSize 32
	rectMode CENTER

	for j in range H+2
		for i in range x0+W+1-1
			block "",i,j

	for digit,i in F1
		block digit, i+x0-1,0
	for digit,j in F2
		block digit, x0+W-1, j+1

	textSize 16
	for j in range H
		int1 = parseInt F2[j]
		for i in range W
			int0 = parseInt F1[i]
			prod = int0 * int1
			tiotal = floor prod / 10
			ental  = prod % 10
			results[W+H-i-j-1] += tiotal
			results[W+H-i-j-2] += ental
			prod = str int0 * int1
			if prod.length==1 then prod='0'+prod
			block prod,x0+i-1,j+1
	ripple()

	for i in range W+H
		v = str 10*carries[i+1] + results[i]
		if v.length == 1 then v = '0'+v
		block v, W+H-i-1, H+1

	drawRect()

setup = ->
	factors.push createInput F1
	factors.push createInput F2
	factors[0].input recalculate
	factors[1].input recalculate
	button = createButton 'Save bitmap'
	button.mousePressed () ->
		saveCanvas canvas, "#{F1}x#{F2}", 'bmp'
	checkbox = createCheckbox 'Diagonals', true
	checkbox.changed () -> 
		DIAG = not DIAG
		recalculate()

	recalculate()

block = (s,i,j) ->
	push()
	translate S2,S2

	fc 0.9
	sc()
	rect i*S-S4,j*S+S4,S2,S2
	rect i*S+S4,j*S-S4,S2,S2

	fc()
	sc 0
	rect i*S,j*S,S,S

	fc 0
	if DIAG and s.length==0
		if 0 < j <= H+1 and i+j+1 >= x0 and i < x0+W-1
			line i*S-S2,j*S+S2, i*S+S2,j*S-S2

	sc()
	if s.length==1
		text s[0], i*S, j*S+2
	if s.length==2
		if s[0] != '0' then text s[0], i*S-S4, j*S-S4+2
		text s[1], i*S+S4, j*S+S4+2
		sc 0
		if DIAG then line i*S-S2, j*S+S2, i*S+S2, j*S-S2
	if s.length==3
		text s.substring(0,2), i*S-S4, j*S-S4+2
		text s[2], i*S+S4, j*S+S4+2
		sc 0
		if DIAG then line i*S-S2, j*S+S2, i*S+S2, j*S-S2
	pop()
