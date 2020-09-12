# Implementation of Knuth's Dancing Links technique for Algorithm X (exact cover).

fs = require 'fs'
range = (n) -> [0...n]

iter = (dir, c, body) -> # replacing while with iter seems to slow down by 100%
	i = c[dir]
	while i != c
		body i
		i = i[dir]

dlx_cover = (c) ->
	c.right.left = c.left
	c.left.right = c.right
	iter 'down', c, (i) ->
		iter 'right', i, (j) ->
			j.down.up = j.up
			j.up.down = j.down
			j.column.size--

dlx_uncover = (c) ->
	iter 'up', c, (i) ->
		iter 'left', i, (j) ->
			j.column.size++
			j.down.up = j
			j.up.down = j
	c.right.left = c
	c.left.right = c

dlx_search = (head, solution, k, solutions, maxsolutions) ->
	if head.right == head
		solutions.push solution.slice 0
		if solutions.length >= maxsolutions then return solutions
		return null
	c = null
	s = 99999

	j = head.right
	while j != head
		if j.size == 0 then return null
		if j.size < s
			s = j.size
			c = j
		j = j.right

	dlx_cover c
	r = c.down
	while r != c
		solution[k] = r.row
		iter 'right', r, (j) -> dlx_cover j.column
		s = dlx_search head, solution, k+1, solutions, maxsolutions
		if s != null then return s
		iter 'left', r, (j) -> dlx_uncover j.column
		r = r.down

	dlx_uncover c
	return null

dlx_solve = (matrix, skip, maxsolutions) ->
	columns = new Array matrix[0].length
	for i in range columns.length
		columns[i] = {}
	for i in range columns.length
		columns[i].index = i
		columns[i].up = columns[i]
		columns[i].down = columns[i]
		if i >= skip
			if i-1 >= skip
				columns[i].left = columns[i-1]
			
			if i+1 < columns.length
				columns[i].right = columns[i+1]
		else
			columns[i].left = columns[i]
			columns[i].right = columns[i]
		
		columns[i].size = 0
	
	for i in range matrix.length
		last = null
		for j in range matrix[i].length
			if matrix[i][j]
				node = {}
				node.row = i
				node.column = columns[j]
				node.up = columns[j].up
				node.down = columns[j]
				if last
					node.left = last
					node.right = last.right
					last.right.left = node
					last.right = node
				else
					node.left = node
					node.right = node
				columns[j].up.down = node
				columns[j].up = node
				columns[j].size++
				last = node

	head = {}
	head.right = columns[skip]
	head.left = columns[columns.length-1]
	columns[skip].left = head
	columns[columns.length-1].right = head
	solutions = []
	dlx_search head, [], 0, solutions, maxsolutions
	return solutions

solve_sudoku = (grid) ->
	mat = []
	rinfo = []
	for i in range 9
		for j in range 9
			g = grid[i][j] - 1
			if g >= 0
				row = new Array 324
				row[i*9+j] = 1
				row[9*9+i*9+g] = 1
				row[9*9*2+j*9+g] = 1
				row[9*9*3+(Math.floor(i/3)*3+Math.floor(j/3))*9+g] = 1
				mat.push row
				rinfo.push {'row': i, 'col': j, 'n': g+1}
			else
				for n in range 9
					row = new Array 324
					row[i*9+j] = 1
					row[9*9+i*9+n] = 1
					row[9*9*2+j*9+n] = 1
					row[9*9*3+(Math.floor(i/3)*3+Math.floor(j/3))*9+n] = 1
					mat.push row
					rinfo.push {'row': i, 'col': j, 'n': n+1}

	solutions = dlx_solve mat, 0, 2
	if solutions.length > 0
		r = solutions[0]
		for i in range r.length
			grid[rinfo[r[i]]['row']][rinfo[r[i]]['col']] = rinfo[r[i]]['n']
		return solutions.length
	return 0
	
filename = process.argv[2]
puzzles = fs.readFileSync(filename).toString().split('\n')
len = puzzles.shift()
console.time 'puzzle'
for puzzle in puzzles
	if puzzle.length >= 81
		g = ((parseInt puzzle[i * 9 + j] for j in range 9) for i in range 9)
		r = solve_sudoku g # this is the number of solutions
		if r > 0
			s = ''
			for i in range 81
				s += g[Math.floor(i/9)][i%9]
			#console.log puzzle
			#console.log s
console.timeEnd 'puzzle'