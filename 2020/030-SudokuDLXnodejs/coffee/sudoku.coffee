# https://codegolf.stackexchange.com/questions/190727/the-fastest-sudoku-solver
# This code works, but I had to introduce a class to handle variable scopes in coffeescript
# This adds about 25% to the exec time.
# node js/sudoku tests/data/collections/all_17

TRACE = false

BLOCK     = [] # 81 digits
BLOCK_NDX = [] # 81 digits
N_BIT     = [] # 512 integers
ZERO      = [] # 512 integers
BIT       = [] # 512 integers

count = 0
m = [] # 81 digits
col = [] # 9 bit patterns
row = [] # 9 bit patterns
blk = [] # 9 bit patternsnull

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
	play : (level, stack, x, y, n) ->
		p = y * 9 + x

		if ~m[p]
			if m[p] == n then return true
			@undo level,stack
			return false
		
		msk = 1 << n
		b = BLOCK[p]

		if (col[x] | row[y] | blk[b]) & msk
			@undo level,stack
			return false
		
		count--
		col[x] ^= msk
		row[y] ^= msk
		blk[b] ^= msk
		m[p] = n
		stack.push x << 8 | y << 4 | n
		if TRACE then console.log 'play ' + ' '.repeat(level), 81-count, x, y, n
		#showGrid 'm    ', m
		return true

	undo : (level,stack) -> # helper function to undo all moves on the stack
		# console.log 'undo', (item.toString(16) for item in stack)
		for v in stack.reverse()
			x = v >> 8
			y = v >> 4 & 15
			index = y * 9 + x
			b = BLOCK[index]
			if TRACE then console.log 'undo '+' '.repeat(level), 81-count, x, y, v & 15

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
				if ~(digit = p[index] - 1)
					msk = 1 << digit
					col[x] |= msk
					row[y] |= msk
					blk[BLOCK[index]] |= msk
					count--
					m[index] = digit

		xres = @search()
		return if xres then m.map((n) => n + 1).join('') else false

	search : (level=0) -> # main recursive search function
		if !count then return true

		#console.log('search',level)

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
					if !@play(level,stack, k, i, n) then return false

				if N_BIT[dRow[ptr]] == 1
					i = BIT[dRow[ptr]];
					if !@play(level,stack, i, k, n) then return false

				if N_BIT[dBlk[ptr]] == 1
					i = BIT[dBlk[ptr]]
					if !@play(level,stack, (k % 3) * 3 + i % 3, (k / 3 | 0) * 3 + (i / 3 | 0), n) then return false

		# if we've played at least one forced move, do a recursive call right away
		if stack.length
			if @search level+1 then return true
			@undo level,stack
			return false

		#console.log 'best', best.msk.toString(16), N_BIT[best.msk]

		# otherwise, try all moves on the cell with the fewest number of moves
		while (msk = ZERO[best.msk]) < 0x200
			#console.log('v',v,BIT[v])
			col[best.x] ^= msk
			row[best.y] ^= msk
			blk[BLOCK[best.ptr]] ^= msk
			m[best.ptr] = BIT[msk]
			count--

			#showGrid('mm   ',m)
			#console.log('stack',stack.map((item) => item.toString(16)))

			if TRACE then console.log('guess'+' '.repeat(level),81-count,best.x, best.y, BIT[msk])
			if @search level+1 then return true
			if TRACE then console.log('ungue'+' '.repeat(level),81-count,best.x, best.y, BIT[msk])
			
			count++
			m[best.ptr] = -1
			col[best.x] ^= msk
			row[best.y] ^= msk
			blk[BLOCK[best.ptr]] ^= msk

			best.msk ^= msk
		
		return false

fs = require 'fs'

sudoku = new Sudoku()

filename = process.argv[2]
puzzles = fs.readFileSync(filename).toString().split '\n'
len = puzzles.shift()
output = len + '\n'

console.log "File '" + filename + "': " + len + " puzzles"

console.time 'Processing time'

# solve all puzzles
for puzzle,i in puzzles
	if puzzle.length != 81 then continue
	if !(++i % 2000) then console.log (i * 100 / len).toFixed(1) + '%'
	#console.time 'start'
	if !(res = sudoku.solve puzzle) then throw "Failed on puzzle " + i
	#console.timeEnd 'start'
	output += puzzle + ',' + res + '\n'

# results
console.timeEnd 'Processing time'
fs.writeFileSync 'sudoku.log', output
console.log "MD5 = " + require('crypto').createHash('md5').update(output).digest "hex"
