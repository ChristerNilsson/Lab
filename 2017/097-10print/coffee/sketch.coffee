# https://10print.org

counter = 0
m1 = []
m2 = []
vinkel = 0

setup = ->
	createCanvas 600,600
	m1 = createMatrix()

createMatrix = ->
	m = []
	d = 25
	for x in range 0,width,d
		row = []
		for y in range 0,height,d
			row.push if random(1) < 0.5 then 1 else 0
		m.push row
	m

draw = ->
	d = 10
	if counter == 0
		m2 = m1
		m1 = createMatrix()
		vinkel = -45
	if counter < 90
		bg 1
		for i in range m1.length
			for j in range m1[i].length
				push()
				translate 50+i*20,50+j*20
				fall = m1[i][j] + 2 * m2[i][j]
				print fall
				if fall == 0 then v = 45
				if fall == 1 then v = -vinkel
				if fall == 2 then v = vinkel
				if fall == 3 then v = -45
				rd v
				line -13.5,0,13.5,0
				pop()
		vinkel += 1
	counter++
	if counter == 360
		counter = 0