b1 = [
	'  .     '.split ''
	'. .     '.split ''
	' ..     '.split ''
	'        '.split ''
	'        '.split ''
	'        '.split ''
	'        '.split ''
	'        '.split ''
]

b2 = []

setup = ->
	createCanvas 200,200

count = (i,j) ->
	result = 0
	for di in [-1,0,1]
		for dj in [-1,0,1]
			if di==0 and dj==0 then continue
			if b1[(i+di) %% 8][(j+dj) %% 8] == '.' then result++
	result

draw = ->
	if frameCount % 30 == 0
		b2 = []
		for i in range 8
			b2.push '        '.split ''
		for i in range 8
			for j in range 8
				c = count i,j
				cell = b1[i][j]
				b2[i][j] = ' '
				if cell=='.' and 2 <= c <= 3 then b2[i][j] = '.'
				else if cell==' ' and c == 3 then b2[i][j] = '.'
				fc if b2[i][j] == '.' then 0 else 1
				rect 20*i,20*j,20,20
		b1 = b2
