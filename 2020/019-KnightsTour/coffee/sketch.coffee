ORDER = [0,3,6,55,28,51,48,53,5,56,1,44,7,54,29,50,2,63,4,27,42,49,52,47,57,14,43,8,45,26,41,30,62,9,58,13,40,11,46,25,15,20,17,10,59,36,31,34,18,61,22,39,12,33,24,37,21,16,19,60,23,38,35,32]
matrix = []
index = 0

setup = ->
	createCanvas 800,800
	matrix = (0 for i in range 64)
	frameRate 1

draw = ->
	bg 0.5
	for i in range 64
		x = 50 + 100 * (i % 8)
		y = 50 + 100 * floor i/8
		if ORDER[i] == index % 64 then fill 'red'
		else 
			if ORDER[i] == (index-1) % 64 then matrix[i] = 1 - matrix[i]
			fc matrix[i] 
		circle x,y,90
	index++
