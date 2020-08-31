range = _.range

SIZE = 20
COLOR = '#ccc #f00 #000'.split ' '
digits = [] # 0..8 
tabu = [] # 0 .. 27*27-1

calcTabu = ->
	tabu = []
	for i in range 27*27
		tabu.push 0

	for i in range 9
		for j in range 9
			k = digits[i+9*j]
			if k == -1 then continue
			for index in range 9
				tabu[9*i + 81*j + index] = 1 # same cell
				tabu[9*i + 81*index + k] = 1 # col
				tabu[9*index + 81*j + k] = 1 # row
			
			ioff = i-i%3 #3 * int i / 3
			joff = j-j%3 #3 * int j / 3
			for i0 in range 3
				for j0 in range 3
					tabu[9*(ioff+i0) + 81*(joff+j0) + k] = 1

			tabu[9*i + 81*j + k] = 2

click = (index,k) -> # 0..8 0..8 0..8
	if digits[index] == -1
		digits[index] = k
	else
		digits[index] = -1
	calcTabu()

setup = ->
	createCanvas SIZE*28+2+2,SIZE*28+2+2
	textAlign CENTER,CENTER
	strokeWeight 0
	for digit in range 81
		digits.push -1
	for i in range 27*27
		tabu.push 0

	# Problem:

	# 8.. .1. 3..
	# .1. 5.. 98.
	# 3.9 ..4 .1.

	# 2.. ..6 .7.
	# .7. ..3 1.9
	# 1.. .8. ...

	# 7.6 ... ..8
	# 4.. ... 5..
	# ... 32. 746

	# click 0,8-1
	# click 4,1-1
	# click 6,3-1
	# click 10,1-1
	# click 12,5-1
	# click 15,9-1
	# click 16,8-1
	# click 18,3-1
	# click 20,9-1
	# click 23,4-1
	# click 25,1-1
	# click 27,2-1
	# click 32,6-1
	# click 34,7-1
	# click 37,7-1
	# click 41,3-1
	# click 42,1-1
	# click 44,9-1
	# click 45,1-1
	# click 49,8-1
	# click 54,7-1
	# click 56,6-1
	# click 62,8-1
	# click 63,4-1
	# click 69,5-1
	# click 75,3-1
	# click 76,2-1
	# click 78,7-1
	# click 79,4-1
	# click 80,6-1

draw = ->
	background 128

	fill 255
	for i in range 9
		for j in range 9
			x = SIZE*(3*i)
			y = SIZE*(3*j)
			rect x+1,y+1,3*SIZE-2,3*SIZE-2

	fill 128
	for i in range 4
		rect SIZE*9*i,0,5,height-SIZE
		rect 0,SIZE*9*i,width-SIZE,5

	fill 0
	textSize 20
	for letter,i in 'ABCDEFGHI'
		text letter, 3*SIZE*(i+0.5),SIZE*27.7
		text 9-i, SIZE*27.6, 3*SIZE*(i+0.5)

	for i in range 9
		for j in range 9
			if digits[i+9*j] == -1
				textSize 12
				for k in range 9
					x = 3*i+k % 3
					y = 3*j+int(k / 3)
					t = tabu[9*i + 81*j + k] 
					fill COLOR[t] 
					text k+1,SIZE*(x+0.5),SIZE*(y+0.5)+2
			else
				textSize 30
				k = digits[i+9*j]
				x = 3*i
				y = 3*j
				fill 0
				text k+1,SIZE*(x+1.5),SIZE*(y+1.5)+2

mousePressed = ->
	i = int mouseX / (SIZE*3)
	j = int mouseY / (SIZE*3)
	index = i + 9 * j
	kx = (int mouseX / SIZE) % 3
	ky = (int mouseY / SIZE) % 3
	k = kx + 3 * ky
	click index,k
