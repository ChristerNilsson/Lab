# https://codegolf.stackexchange.com/questions/190727/the-fastest-sudoku-solver

# 'use strict';

fs = require 'fs'

range = (n) -> [0...n]

BLOCK     = []
BLOCK_NDX = []
N_BIT     = []
ZERO      = []
BIT       = []

showGrid = (prompt,m) ->
	count = 0
	for digit in m
		if (digit != -1) then count+=1 
	#m.map((digit) => {if (digit != -1) count+=1 })
	console.log(prompt, m.map( (digit) => digit+1).join(''), count)

# initialization of lookup tables
init = ->
	#ptr=null
	#x=null
	#y=null
 
	for x in range 0x200
		# N_BIT[x] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
		# 	.reduce ((s, n) => s + (x >> n & 1), 0)

		res = 0
		for n in range 9
			res += x >> n & 1
		N_BIT[x] = res # [0, 1, 2, 3, 4, 5, 6, 7, 8].reduce ((s, n) => s + (x >> n & 1)), 0
		ZERO[x] = ~x & -~x
	for x in range 9
		BIT[1 << x] = x

	ptr = 0
	for y in range 9
		for x in range 9
			BLOCK[ptr] = (y / 3 | 0) * 3 + (x / 3 | 0)
			BLOCK_NDX[ptr] = (y % 3) * 3 + x % 3
			ptr++

	# console.log 'N_BIT',N_BIT
	# console.log 'ZERO',ZERO
	# console.log 'BIT',BIT
	# console.log 'BLOCK',BLOCK
	# console.log 'BLOCK_NDX',BLOCK_NDX

# solver
solve = (p) ->
	console.log 'solve',p
	#ptr = null
	#x = null
	#y = null
	#v = null
	count = 81
	m = Array(81).fill -1
	row = Array(9).fill 0
	col = Array(9).fill 0
	blk = Array(9).fill 0

	# convert the puzzle into our own format
	ptr = 0 
	for y in range 9
		for x in range 9
			if ~(v = p[ptr] - 1)
				col[x] |= 1 << v
				row[y] |= 1 << v
				blk[BLOCK[ptr]] |= 1 << v
				count--
				m[ptr] = v
			ptr++

		# main recursive search function
		# helper function to check and play a move
	play = (msg, stack, x, y, n) ->
		p = y * 9 + x

		if ~m[p]
			if m[p] == n then return true
			undo stack
			return false
		
		msk = 1 << n
		b = BLOCK[p]

		if (col[x] | row[y] | blk[b]) & msk
			undo stack
			return false
		
		count--
		col[x] ^= msk
		row[y] ^= msk
		blk[b] ^= msk
		m[p] = n
		stack.push x << 8 | y << 4 | n
		console.log 'play', msg, (item.toString(16) for item in stack), x, y, n
		showGrid('m    ',m)

		return true

	# helper function to undo all moves on the stack
	undo = (stack) ->
		console.log 'undo', (item.toString(16) for item in stack)
		for v in stack
		#stack.map (v) =>
			x = v >> 8
			y = v >> 4 & 15
			p = y * 9 + x
			b = BLOCK[p]

			vv = 1 << (v & 15)

			count++
			col[x] ^= vv
			row[y] ^= vv
			blk[b] ^= vv
			m[p] = -1
			showGrid('u    ',m)

	search = ->
		# success?
		if !count then return true

		#ptr = null
		# x = null
		# y = null 
		#v = null
		#n = null
		#max = null
		#best = null
		#k = null 
		#i = null
		stack = []
		dCol = Array(81).fill 0
		dRow = Array(81).fill 0
		dBlk = Array(81).fill 0
		#b = null
		#v0 = null

		# scan the grid:
		# - keeping track of where each digit can go on a given column, row or block
		# - looking for a cell with the fewest number of legal moves
		max = 0
		ptr = 0
		for y in range 9
			for x in range 9
				if m[ptr] == -1
					v = col[x] | row[y] | blk[BLOCK[ptr]]
					n = N_BIT[v]
					#abort if there's no legal move on this cell
					if n == 9 then return false
					
					# update dCol[], dRow[] and dBlk[]
					v0 = v ^ 0x1FF
					while true
						b = v0 & -v0
						dCol[x * 9 + BIT[b]] |= 1 << y
						dRow[y * 9 + BIT[b]] |= 1 << x
						dBlk[BLOCK[ptr] * 9 + BIT[b]] |= 1 << BLOCK_NDX[ptr]
						v0 ^= b
						if !v0 then break 
					#console.log 'v0', v0
					
					# update the cell with the fewest number of moves
					if n > max
						best = {x: x, y: y, ptr: ptr, msk: v}
						max = n
				ptr++
		console.log('best',best,max)

		# play all forced moves (unique candidates on a given column, row or block)
		# and make sure that it doesn't lead to any inconsistency
		for k in range 9
			for n in range 9
				if N_BIT[dCol[k * 9 + n]] == 1
					i = BIT[dCol[k * 9 + n]]
					if !play('col',stack, k, i, n) then return false

				if N_BIT[dRow[k * 9 + n]] == 1
					i = BIT[dRow[k * 9 + n]];
					if !play('row',stack, i, k, n) then return false

				if N_BIT[dBlk[k * 9 + n]] == 1
					i = BIT[dBlk[k * 9 + n]]
					if !play('blk',stack, (k % 3) * 3 + i % 3, (k / 3 | 0) * 3 + (i / 3 | 0), n) then return false

		# if we've played at least one forced move, do a recursive call right away
		if stack.length
			if search() then return true
			undo stack
			return false

		# otherwise, try all moves on the cell with the fewest number of moves
		while (v = ZERO[best.msk]) < 0x200
			console.log('v',v,BIT[v])
			col[best.x] ^= v
			row[best.y] ^= v
			blk[BLOCK[best.ptr]] ^= v
			m[best.ptr] = BIT[v]
			count--

			console.log('guess',best.x, best.y, BIT[v])
			showGrid('mm   ',m)
			console.log('stack',stack.map((item) => item.toString(16)))

			if search() then return true
			
			count++
			m[best.ptr] = -1
			col[best.x] ^= v
			row[best.y] ^= v
			blk[BLOCK[best.ptr]] ^= v

			best.msk ^= v
		
		return false


	xres = search()
	console.log 'res=',xres

	return if xres then m.map((n) => n + 1).join('') else false

# # debugging
# dump = (m) ->
# 	x = null
# 	y = null
# 	c = 81
# 	s = ''

# 	# for y in range 9 #(y = 0; y < 9; y++) {
# 	# 	for x in range 9 #(x = 0; x < 9; x++) {
# 	# 		s += (if ~m[y * 9 + x] 
# 	# 			c--
# 	# 			m[y * 9 + x] + 1 
# 	# 		else '-') + (if x % 3 < 2 || x == 8 then ' ' else ' | ');
# 	# 	s += if y % 3 < 2 || y == 8 then '\n' else '\n------+-------+------\n';
# 	console.log c
# 	console.log s

console.time 'Processing time'

init()

filename = process.argv[2]
puzzle = fs.readFileSync(filename).toString().split '\n'
len = puzzle.shift()
output = len + '\n'

console.log "File '" + filename + "': " + len + " puzzles"

# solve all puzzles
for p,i in puzzle
	sol = null
	res = null

	if i != 7 then continue

	[ p, sol ] = p.split ','
	#console.log p,i

	if p.length == 81
		if !(++i % 2000)
			console.log (i * 100 / len).toFixed(1) + '%'
		
		#console.log 'before solve'
		if !(res = solve p)
			throw "Failed on puzzle " + i
		
		if sol && res != sol
			throw "Invalid solution for puzzle " + i
		
		console.log p
		console.log res
		output += p + ',' + res + '\n'

# results
console.timeEnd 'Processing time'
fs.writeFileSync 'sudoku.log', output
console.log "MD5 = " + require('crypto').createHash('md5').update(output).digest "hex"
