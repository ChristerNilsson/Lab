range = _.range

N = 9
SIZE = 34
COLOR = '#ccc #f00'.split ' '

MAYBE = 0
NO = 1 # RED
YES = 1 # GREEN

UNKNOWN = -1

#SUPPORT = 0 # no support
SUPPORT = 1 # show green digit

digits = [] # 0..8 or UNKNOWN length=81
tabu = []   # [0,0,0,0,0,0,0,0,0] 0..1 length=81
single = (UNKNOWN for i in range 81) # 0..8 or UNKNOWN length=81
stack = [] # contains 0..80

calcCell = ->
	for i in range N
		for j in range N
			if digits[i+N*j] == UNKNOWN
				count = 0
				index = -1
				for k in range N
					if tabu[i + N*j][k] == MAYBE
						count++
						index = k
				if count == 1
					if tabu[i + N*j][index] == MAYBE then single[i + N*j] = index

calcRow = ->
	for j in range N
		for k in range N
			count = 0
			index = -1
			for i in range N 
				if digits[i+N*j] == UNKNOWN and tabu[i+N*j][k] == MAYBE
					count++
					index = i
			if count == 1
				if tabu[index + N*j][k] == MAYBE then single[index + N*j] = k

calcCol = ->
	for i in range N
		for k in range N
			count = 0
			index = -1
			for j in range N
				if digits[i+N*j] == UNKNOWN and tabu[i + N*j][k] == MAYBE
					count++
					index = j
			if count == 1
				if tabu[i + N*index][k] == MAYBE then single[i + N*index] = k

calc3x3 = ->
	for i in range N
		for j in range N
			if digits[i+N*j] == UNKNOWN
				ioff = i - i % 3
				joff = j - j % 3
				for k in range N
					count = 0
					index = -1
					for i0 in range 3
						for j0 in range 3
							ix = (ioff+i0) + N*(joff+j0)
							if digits[ix] == UNKNOWN
								if tabu[ix][k] == MAYBE
									count++
									index = ix 
					if count == 1
						if tabu[index][k] == MAYBE then single[index] = k

calcTabu = ->
	tabu = ([0,0,0,0,0,0,0,0,0] for i in range N*N)
	for i in range N
		for j in range N
			digit = digits[i+N*j]
			if digit == UNKNOWN then continue
			for index in range N
				tabu[i + N*j][index] = NO # cell
				tabu[i + N*index][digit] = NO # col
				tabu[index + N*j][digit] = NO # row
			
			ioff = i - i % 3
			joff = j - j % 3
			for i0 in range 3
				for j0 in range 3
					tabu[(ioff+i0) + N*(joff+j0)][digit] = NO

			tabu[i + N*j][digit] = YES

calcSingle = ->
	if SUPPORT == 0 then return
	single = (UNKNOWN for i in range 81)
	calcCell()
	calcRow()
	calcCol()
	calc3x3()

click = (index,digit) -> 
	stack.push index # 0..80
	digits[index] = digit # 0..8
	calcTabu()
	calcSingle()

# dump = ->
# 	calcTabu()
# 	calcSingle()
# 	console.log single
# 	for i in range N*N
# 		console.log i,digits[i],tabu[i]
# 	for i in range N
# 		console.log i,single.slice N*i,N*i+N

undo = ->
	if stack.length == 0 then return
	digits[stack.pop()] = UNKNOWN
	calcTabu()
	calcSingle()

setup = ->
	createCanvas SIZE*28+2+2,SIZE*28+2+2
	textAlign CENTER,CENTER
	strokeWeight 0
	digits = (UNKNOWN for digit in range N*N)
	tabu = ([0,0,0,0,0,0,0,0,0] for i in range N*N)

	postnord()
	#expert()

drawBackground = (i,j,color)->
	fill color
	rect 3*SIZE*i+1, 3*SIZE*j+1, 3*SIZE-2, 3*SIZE-2

drawLittera = ->
	fill 0
	textSize 32
	for letter,i in 'ABCDEFGHI'
		text letter, 3*SIZE*(i+0.5),SIZE*27.7
		text N-i, SIZE*27.6, 3*SIZE*(i+0.5)

drawTabu = (i,j) ->
	drawBackground i,j, if single[i+N*j] == UNKNOWN then '#fff' else '#ff0'
	textSize 20
	for k in range 9
		x = 3*i+k % 3
		y = 3*j+int(k / 3)
		t = tabu[i + N*j][k]
		fill if single[i + N*j] == k then '#0f0' else COLOR[t]
		text k+1,SIZE*(x+0.5),SIZE*(y+0.5)+2

drawDigit = (i,j) ->
	drawBackground i,j,'#fff'
	textSize 50
	digit = digits[i+N*j]+1
	fill 0
	text digit,SIZE*(3*i+1.5),SIZE*(3*j+1.5)+2

drawDividers = ->
	fill 128
	for i in range 4
		rect SIZE*N*i,0,5,height-SIZE
		rect 0,SIZE*N*i,width-SIZE,5

drawUndo = ->
	fill 0
	textSize 32
	text stack.length, SIZE*27.5, SIZE*27.6

draw = ->
	background 128
	drawLittera()

	for i in range N
		for j in range N
			if digits[i+N*j] == UNKNOWN
				drawTabu i,j
			else
				drawDigit i,j

	drawDividers()
	drawUndo()

mousePressed = ->
	i = int mouseX / (SIZE*3)
	j = int mouseY / (SIZE*3)
	index = i + N * j
	kx = (int mouseX / SIZE) % 3
	ky = (int mouseY / SIZE) % 3
	k = kx + 3 * ky
	if index < N*N then click index,k else undo()

postnord = ->
	click 0,8-1
	click 4,1-1
	click 6,3-1
	click 10,1-1
	click 12,5-1
	click 15,9-1
	click 16,8-1
	click 18,3-1
	click 20,9-1
	click 23,4-1
	click 25,1-1
	click 27,2-1
	click 32,6-1
	click 34,7-1
	click 37,7-1
	click 41,3-1
	click 42,1-1
	click 44,9-1
	click 45,1-1
	click 49,8-1
	click 54,7-1
	click 56,6-1
	click 62,8-1
	click 63,4-1
	click 69,5-1
	click 75,3-1
	click 76,2-1
	click 78,7-1
	click 79,4-1
	click 80,6-1

expert = ->
	click 2,7-1
	click 5,4-1
	click 7,2-1
	click 8,6-1
	click 10,9-1
	click 15,8-1
	click 17,1-1
	click 19,6-1
	click 25,7-1
	click 31,9-1
	click 39,5-1
	click 45,5-1
	click 46,8-1
	click 48,1-1
	click 50,6-1
	click 53,4-1
	click 54,4-1
	click 57,9-1
	click 59,1-1
	click 62,8-1
	click 65,1-1
	click 67,7-1
	click 71,2-1
