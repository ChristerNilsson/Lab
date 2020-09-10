# https://codegolf.stackexchange.com/questions/190727/the-fastest-sudoku-solver
# This code works, but I had to introduce a class to handle variable scopes
# This adds about 25% to the exec time.

# 'use strict';

BLOCK     = []
BLOCK_NDX = []
N_BIT     = []
ZERO      = []
BIT       = []

count = null
m = null
col = null
row = null
blk = null

range = (n) -> [0...n]

showGrid = (prompt,m) ->
	counter = 0
	for digit in m
		if digit != -1 then counter++
	console.log prompt, m.map( (digit) => digit+1).join(''), counter

class Sudoku
	constructor : -> # initialization of lookup tables 

		for x in range 0x200
			N_BIT[x] = range(9).reduce ((s,n) -> s + (x >> n & 1)), 0
			ZERO[x] = ~x & -~x
		for x in range 9
			BIT[1 << x] = x

		for y in range 9
			for x in range 9
				ptr = 9 * y + x
				BLOCK[ptr] = (y / 3 | 0) * 3 + (x / 3 | 0)
				BLOCK_NDX[ptr] = (y % 3) * 3 + x % 3

	# helper function to check and play a move
	play : (msg, stack, x, y, n) ->
		p = y * 9 + x

		if ~m[p]
			if m[p] == n then return true
			@undo stack
			return false
		
		msk = 1 << n
		b = BLOCK[p]

		if (col[x] | row[y] | blk[b]) & msk
			@undo stack
			return false
		
		count--
		col[x] ^= msk
		row[y] ^= msk
		blk[b] ^= msk
		m[p] = n
		stack.push x << 8 | y << 4 | n
		# console.log 'play', msg, (item.toString(16) for item in stack), x, y, n
		#showGrid 'm    ', m
		return true

	undo : (stack) -> # helper function to undo all moves on the stack
		# console.log 'undo', (item.toString(16) for item in stack)
		for v in stack
			x = v >> 8
			y = v >> 4 & 15
			index = y * 9 + x
			b = BLOCK[index]

			msk = 1 << (v & 15)

			count++
			col[x] ^= msk
			row[y] ^= msk
			blk[b] ^= msk
			m[index] = -1
			# showGrid 'u    ',m

	solve : (p) ->
		count = 81
		row = Array(9).fill 0
		col = Array(9).fill 0
		blk = Array(9).fill 0
		m = Array(81).fill -1

		# convert the puzzle into our own format
		for y in range 9
			for x in range 9
				index = 9 * y + x
				if ~(v = p[index] - 1)
					msk = 1 << v
					col[x] |= msk
					row[y] |= msk
					blk[BLOCK[index]] |= msk
					count--
					m[index] = v

		xres = @search()
		return if xres then m.map((n) => n + 1).join('') else false

	search : -> # main recursive search function
		if !count then return true

		# Local variables
		max = 0
		best = null
		stack = []
		dCol = Array(81).fill 0
		dRow = Array(81).fill 0
		dBlk = Array(81).fill 0

		# scan the grid:
		# - keeping track of where each digit can go on a given column, row or block
		# - looking for a cell with the fewest number of legal moves
		for y in range 9
			for x in range 9
				ptr = 9 * y + x
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
				#ptr++
		#console.log('best',best,max)

		# play all forced moves (unique candidates on a given column, row or block)
		# and make sure that it doesn't lead to any inconsistency
		for k in range 9
			for n in range 9
				ptr = k * 9 + n
				if N_BIT[dCol[ptr]] == 1
					i = BIT[dCol[ptr]]
					if !@play('col',stack, k, i, n) then return false

				if N_BIT[dRow[ptr]] == 1
					i = BIT[dRow[ptr]];
					if !@play('row',stack, i, k, n) then return false

				if N_BIT[dBlk[ptr]] == 1
					i = BIT[dBlk[ptr]]
					if !@play('blk',stack, (k % 3) * 3 + i % 3, (k / 3 | 0) * 3 + (i / 3 | 0), n) then return false

		# if we've played at least one forced move, do a recursive call right away
		if stack.length
			if @search() then return true
			@undo stack
			return false

		# otherwise, try all moves on the cell with the fewest number of moves
		while (msk = ZERO[best.msk]) < 0x200
			#console.log('v',v,BIT[v])
			col[best.x] ^= msk
			row[best.y] ^= msk
			blk[BLOCK[best.ptr]] ^= msk
			m[best.ptr] = BIT[msk]
			count--

			#console.log('guess',best.x, best.y, BIT[v])
			#showGrid('mm   ',m)
			#console.log('stack',stack.map((item) => item.toString(16)))

			if @search() then return true
			
			count++
			m[best.ptr] = -1
			col[best.x] ^= msk
			row[best.y] ^= msk
			blk[BLOCK[best.ptr]] ^= msk

			best.msk ^= msk
		
		return false

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

fs = require 'fs'

console.time 'Processing time'

sudoku = new Sudoku()

filename = process.argv[2]
puzzles = fs.readFileSync(filename).toString().split '\n'
len = puzzles.shift()
output = len + '\n'

console.log "File '" + filename + "': " + len + " puzzles"

# solve all puzzles
for p,i in puzzles
	#if i>100 then break

	#if i != 7 then continue

	[p, sol] = p.split ','

	if p.length == 81
		if !(++i % 2000)
			console.log (i * 100 / len).toFixed(1) + '%'
		
		if !(res = sudoku.solve p)
			throw "Failed on puzzle " + i
		
		if sol && res != sol
			throw "Invalid solution for puzzle " + i
		
		#console.log p
		#console.log res
		output += p + ',' + res + '\n'

# results
console.timeEnd 'Processing time'
fs.writeFileSync 'sudoku.log', output
console.log "MD5 = " + require('crypto').createHash('md5').update(output).digest "hex"
