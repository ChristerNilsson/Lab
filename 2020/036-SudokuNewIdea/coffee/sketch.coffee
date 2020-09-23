BLOCK     = Array(81).fill 0
BLOCK_NDX = Array(81).fill 0
N_BIT     = Array(81).fill 0
ZERO      = Array(512).fill 0
BIT       = Array(512).fill 0

range = (n) -> [0...n]

construct = -> # initialization of lookup tables 

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

	# console.log "N_BIT #{N_BIT} #{N_BIT.length}"
	# console.log "ZERO #{ZERO} #{ZERO.length}"
	# console.log "BIT #{BIT} #{BIT.length}"
	#console.log "BLOCK #{BLOCK} #{BLOCK.length}"
	#console.log "BLOCK_NDX #{BLOCK_NDX} #{BLOCK_NDX.length}"

transform = (p) -> (parseInt(ch) for ch in p).reverse()

calc = (m) ->
	row = Array(9).fill 0
	col = Array(9).fill 0
	blk = Array(9).fill 0
	for y in range 9
		for x in range 9
			index = 9 * y + x
			v = m[index]-1
			if v >= 0
				msk = 1 << v
				col[x] |= msk
				row[y] |= msk
				blk[BLOCK[index]] |= msk
	[row,col,blk]

fetchCandidates = (lst) ->
	candidates = []
	makeCandidates = (lst, selected=[]) ->
		if selected.length == 9
			candidates.push selected.slice()
			return
		for digit in lst[selected.length]
			if digit not in selected
				selected.push digit
				makeCandidates lst, selected, candidates
				selected.pop()
	makeCandidates lst
	candidates

makeList = (row, col, blk, m, y) ->
	result = []
	for x in range 9
		index = 9 * y + x
		pattern = row[y] | col[x] | blk[BLOCK[index]]
		#console.log pattern
		res = []
		if m[index] == 0
			for k in range 9
				msk = 1 << k
				if (msk & pattern) == 0 then res.push k+1
		else
			res.push m[index]
		if res.length == 0 then return []
		result.push res
	result

construct()

solve = (m, y=0) ->
	#console.log m + ' ' + ' '.repeat(y) + y
	if y==9
		console.log m.join ''
		return true
	[row, col, blk] = calc m
	result = makeList row,col,blk,m,y # [[1,3,6,9],[2],[1,3,6,9],[4,8,9],[5],[4,6,9],[7],[3,4,8,9],[1,4,8,9]]
	if result.length == 0 then return false 
	#console.log result
	cands = fetchCandidates result # lista med möjliga rader, t ex 38 kandidater
	#console.log cands.length
	#if cands.length<100 
	#	for c in cands
	#		console.log c
	if cands.length > 0 
		for c in cands #  t ex [ 9, 2, 6, 8, 5, 4, 7, 3, 1 ] 
			m1 = m.slice()
			m1.splice 9*y,9,c[0],c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8]
			if solve m1,y+1 then return true
	false

#mm = transform '020050700400100006800003000200008003040020500000600010002090000090000005704000900'
#console.log mm.join ''

filename = 'all_17'
fs = require 'fs'
puzzles = fs.readFileSync(filename).toString().split '\n'
len = puzzles.shift()

#for puzzle in puzzles
#puzzle = '000000010400000000020000000000050407008000300001090000300400200050100000000806000'
#puzzle = '002000700010000060500000018000037000000049000004102300003020900080000050600000002'
puzzle = '002000700010000060500000018003020900080000050600000002000037000000049000004102300'
#console.log puzzle
console.time 'CPU'
for i in range 1
	pz = transform puzzle
	#console.log pz.join ''
	solve pz
console.timeEnd 'CPU'

# 020050700
# 400100006
# 800003000
# 200008003
# 040020500
# 000600010
# 002090000
# 090000005
# 704000900
