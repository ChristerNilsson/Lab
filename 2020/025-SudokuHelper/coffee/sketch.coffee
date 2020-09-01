range = _.range

N = 9
SIZE = 20
COLOR = '#ccc #f00'.split ' '
digits = [] # 0..8 eller -1 length=81
tabu = []   # [0,0,0,0,0,0,0,0,0] 0..1          length=81
single = (-1 for i in range 81) # 0..8 eller -1 length=81
stack = [] # contains 0..80

calcSingle = ->
	return
	single = (-1 for i in range 81)

	for i in range N # cell
		for j in range N
			if digits[i+N*j] == -1
				count = 0
				index = -1
				for k in range N
					if tabu[i + N*j][k] == 0 # gray
						count++
						index = k
				if count == 1
					if tabu[i + N*j][index] == 0 then single[i + N*j] = index

	for j in range N # row
		for k in range N
			count = 0
			index = -1
			for i in range N 
				if digits[i+N*j] == -1 and tabu[i+N*j][k] == 0 # gray
					count++
					index = i
			if count == 1
				if tabu[index + N*j][k] == 0 then single[index + N*j] = k

	for i in range N # col
		for k in range N
			count = 0
			index = -1
			for j in range N
				if digits[i+N*j] == -1 and tabu[i + N*j][k] == 0 # gray
					count++
					index = j
			if count == 1
				if tabu[i + N*index][k] == 0 then single[i + N*index] = k

	for i in range N # 3 by 3
		for j in range N
			if digits[i+N*j] == -1
				ioff = i - i % 3
				joff = j - j % 3
				for k in range N
					count = 0
					for i0 in range 3
						for j0 in range 3
							if digits[(ioff+i0) + N*(joff+j0)] == -1 
								if tabu[(ioff+i0) + N*(joff+j0)][k] == 0 # gray
									count++
					if count == 1
						if tabu[(ioff+i0) + N*(joff+j0)][k] == 0 then single[(ioff+i0) + N*(joff+j0)] = k

calcTabu = ->
	tabu = ([0,0,0,0,0,0,0,0,0] for i in range N*N)
	for i in range N
		for j in range N
			k = digits[i+N*j]
			if k == -1 then continue
			for index in range N
				tabu[i + N*j][index] = 1 # same cell
				tabu[i + N*index][k] = 1 # col
				tabu[index + N*j][k] = 1 # row
			
			ioff = i - i % 3
			joff = j - j % 3
			for i0 in range 3
				for j0 in range 3
					tabu[(ioff+i0) + N*(joff+j0)][k] = 1

			tabu[i + N*j][k] = 2

click = (index,k) -> # 0..8 0..8 0..8
	stack.push index
	digits[index] = k
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
	digits[stack.pop()] = -1
	calcTabu()
	calcSingle()

setup = ->
	createCanvas SIZE*28+2+2,SIZE*28+2+2
	textAlign CENTER,CENTER
	strokeWeight 0
	digits = (-1 for digit in range N*N)
	tabu = ([0,0,0,0,0,0,0,0,0] for i in range N*N)

	#postnord()
	#expert()

draw = ->
	background 128

	fill 255
	for i in range N
		for j in range N
			x = SIZE*(3*i)
			y = SIZE*(3*j)
			rect x+1,y+1,3*SIZE-2,3*SIZE-2

	fill 0
	textSize 20
	for letter,i in 'ABCDEFGHI'
		text letter, 3*SIZE*(i+0.5),SIZE*27.7
		text N-i, SIZE*27.6, 3*SIZE*(i+0.5)

	for i in range N
		for j in range N
			if digits[i+N*j] == -1
				textSize 12
				if single[i+N*j] == -1 then fill '#fff' else fill '#ff0'
				x = SIZE*(3*i)
				y = SIZE*(3*j)
				rect x+1,y+1,3*SIZE-2,3*SIZE-2
				for k in range 9
					x = 3*i+k % 3
					y = 3*j+int(k / 3)
					t = tabu[i + N*j][k]
					if single[i + N*j] == k then fill '#0f0' else fill COLOR[t]
					text k+1,SIZE*(x+0.5),SIZE*(y+0.5)+2
			else
				textSize 30
				k = digits[i+N*j]
				x = 3*i
				y = 3*j
				fill 0
				text k+1,SIZE*(x+1.5),SIZE*(y+1.5)+2

	fill 128
	for i in range 4
		rect SIZE*N*i,0,5,height-SIZE
		rect 0,SIZE*N*i,width-SIZE,5

mousePressed = ->
	i = int mouseX / (SIZE*3)
	j = int mouseY / (SIZE*3)
	index = i + N * j
	kx = (int mouseX / SIZE) % 3
	ky = (int mouseY / SIZE) % 3
	k = kx + 3 * ky
	if index < N*N then click index,k else undo()

postnord = ->
	# 8.. .1. 3..
	# .1. 5.. 98.
	# 3.9 ..4 .1.

	# 2.. ..6 .7.
	# .7. ..3 1.9
	# 1.. .8. ...

	# 7.6 ... ..8
	# 4.. ... 5..
	# ... 32. 746

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
