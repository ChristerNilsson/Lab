
verWalls = [0,2+8,2+4+8,1,0] # yttre väggar lagras ej.
horWalls = [2,1+8,1+2+8,4+8,1+8]

N = 5 

mouse = null

dirs = [[-1,0],[0,1],[1,0],[0,-1]] # WSEN

wall = (x1,y1,x2,y2) -> # finns en vägg mellan de två rutorna?
	if y1==y2
		(verWalls[y1] & [1,2,4,8][_.min([x1,x2])]) != 0
	else
		(horWalls[x1] & [1,2,4,8][_.min([y1,y2])]) != 0
assert 2 ** 3, 8
assert _.min([3,4]), 3
assert wall(0,0,1,0), false
assert wall(0,1,1,1), false
assert wall(1,1,2,1), true
assert wall(0,0,0,1), false
assert wall(0,1,0,2), true

setup = ->
	createCanvas windowWidth,windowHeight
	mouse = new Mouse 4, 24
	mouse.solve()
	print "ready"
	mouse.pos = 4
	mouse.solve()

class Mouse 
	constructor : (@pos,@stopp) -> @ai = [9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9]

	free : (d) ->
		[dx,dy] = dirs[d]
		x = @pos % N
		y = int @pos / N
		x1 = x + dx
		y1 = y + dy
		if 0 <= x1 < N and 0 <= y1 < N 
			return not wall x,y,x1,y1 
		false 

	move : (d) ->
		[dx,dy] = dirs[d]
		x = @pos % N
		y = int @pos / N
		x += dx
		y += dy
		@ai[@pos] = d
		@pos = x + N * y

	solve : ->	
		d = 0
		while @pos != @stopp
			print "POS", @pos
			lastd = d
			if @ai[@pos] != 9
				d = @ai[@pos] # the direction to the target is available
			else
				d = [1,2,3,0][d] # try left relative current direction first
			for i in range 4
				if @free(d) and abs(lastd-d) != 2 
					lastd = d 
					@move d
					break
				d = [3,0,1,2][d] # try right next
		print @ai 