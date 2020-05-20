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
s = []

setup = ->
	createCanvas 200,200
	frameRate 1
	#xdraw()

count = (i,j) ->
	result = 0
	for di in [-1,0,1]
		for dj in [-1,0,1]
			if di==0 and dj==0 then continue
			if b1[(i+di) %% 8][(j+dj) %% 8] == '.' then result++
	result

draw = ->
	# s.push "# https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"
	# s.push "# https://github.com/ChristerNilsson/Lab/blob/master/2019/117-GameOfLife/coffee/sketch.coffee"
	# s.push 'a = Animation()'
	b2 = []
	for i in range 8
		b2.push '        '.split ''
	output b2,b1
	for frame in range 1 # 30
		b2 = []
		for i in range 8
			b2.push '        '.split ''
		for i in range 8
			for j in range 8
				c = count i,j
				cell = b1[i][j]
				b2[i][j] = ' '
				if cell == '.' and 2 <= c <= 3 then b2[i][j] = '.' # continue
				if cell == ' ' and c == 3 then b2[i][j] = '.' # born
				fc if b2[i][j] == '.' then 0 else 1
				rect 20*i,20*j,20,20
		# output b1,b2
		b1 = b2
	#console.log s.join '\n'

output = (b1,b2) ->
	for i in range 8
		for j in range 8
			ab = b1[i][j] + b2[i][j]
			if ab == ' .' then s.push "m[#{i}][#{j}] = on"
			if ab == '. ' then s.push "m[#{i}][#{j}] = off"
	s.push 'a.add_frame(m)'

