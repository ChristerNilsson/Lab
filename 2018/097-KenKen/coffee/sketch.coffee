N = null
ALFABET = ' abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'	

# setup = ->
# 	createCanvas 200,200
# draw = ->
# 	bg 0.5

arrayExcept = (arr, idx) ->
	res = arr[0..]
	res.splice idx, 1
	res 
permute = (arr) ->
	arr = Array::slice.call arr, 0
	return [[]] if arr.length == 0
	permutations = (for value,idx in arr
		[value].concat perm for perm in permute arrayExcept arr, idx)
	[].concat permutations...	
assert [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]], permute [1,2,3]

f = (kenken) ->
	res = {}
	for letter in kenken
		res[letter] = []	
	for key,i in kenken
		res[key].push i
	res

#        0123456789012345  
# rf =  f("abbcddecffgghhii")
# assert rf,
# 	a:[0]
# 	b:[1,2]
# 	c:[3,7]
# 	d:[4,5]
# 	e:[6]
# 	f:[8,9]
# 	g:[10,11]
# 	h:[12,13]
# 	i:[14,15]

uniq = (lst) ->
	res = [lst[0]]
	for item,i in lst
		if i>0
			if not _.isEqual item, _.last res
				res.push item
	res 

match2 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			if total == operation a,b
				lst = [a,b].sort()
				res.push lst
	uniq res.sort()

match3 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			for c in range 1,N+1
				if total == operation a,b,c
					lst = [a,b,c].sort()
					res.push lst
	uniq res.sort()

match4 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			for c in range 1,N+1
				for d in range 1,N+1
					if total == operation a,b,c,d
						lst = [a,b,c,d].sort()
						res.push lst
	uniq res.sort()

g = (rf,ops) -> # gets possible operands
	res = {}
	for key of rf
		total = parseInt ops[key]
		switch rf[key].length
			when 1
				res[key] = [[total]]
			when 2
				switch _.last ops[key]
					when '/' then	res[key] = match2 total,(a,b) -> a // b
					when '+' then	res[key] = match2 total,(a,b) -> a + b
					when '*' then res[key] = match2 total,(a,b) -> a * b
					when '-' then res[key] = match2 total,(a,b) -> a - b
			when 3
				switch _.last ops[key]
					when '+' then	res[key] = match3 total,(a,b,c) -> a + b + c
					when '*' then res[key] = match3 total,(a,b,c) -> a * b * c
			when 4
				switch _.last ops[key]
					when '+' then	res[key] = match4 total,(a,b,c,d) -> a + b + c + d
					when '*' then res[key] = match4 total,(a,b,c,d) -> a * b * c * d
			else
				print 'Problem!'
	res

# rg = g rf,
# 	a: '4'
# 	b: '2/'
# 	c: '12*'
# 	d: '1-'
# 	e: '3'
# 	f: '7+'
# 	g: '2/'
# 	h: '1-'
# 	i: '3-'

# assert rg,
# 	a: [[4]]
# 	b: [[1,2],[2,4]]
# 	c: [[3,4]]
# 	d: [[1,2],[2,3],[3,4]]
# 	e: [[3]]
# 	f: [[3,4]]
# 	g: [[1,2],[2,4]]
# 	h: [[1,2],[2,3],[3,4]]
# 	i: [[1,4]]

makePerms = (rg) -> # adds permutations
	res = {}
	for key of rg
		lst = rg[key]
		a = []
		a = a.concat permute pair for pair in lst
		res[key] = uniq a.sort()
	res

# rp = makePerms rg
# assert rp,
# 	a: [[4]]
# 	b: [[1,2],[2,1],[2,4],[4,2]]
# 	c: [[3,4],[4,3]]
# 	d: [[1,2],[2,1],[2,3],[3,2],[3,4],[4,3]]
# 	e: [[3]]
# 	f: [[3,4],[4,3]]
# 	g: [[1,2],[2,1],[2,4],[4,2]]
# 	h: [[1,2],[2,1],[2,3],[3,2],[3,4],[4,3]]
# 	i: [[1,4],[4,1]]

ok = (lst) ->
	lst = _.without lst, 0
	lst.length == _.uniq(lst).length
assert [1,2,3,4], _.uniq [1,2,3,4] 
assert true, ok [1,2,3,4]
assert false,ok [1,2,2,4]
assert true, ok [0,0,0,0]
assert true, ok [4,0,0,1]
assert false,ok [4,0,0,4]

valid = (indexes,pointer,rf,rp) -> # 1..4 must be unique in each row and col. 0 is ok
	print indexes,pointer
	if pointer == ' ' then return true
	grid = (0 for i in range N*N)
	for p in ALFABET.slice 1,1+ALFABET.indexOf pointer
		for x,j in rf[p]
			print p,x,j,indexes[p]
			y = rp[p][indexes[p]][j]
			grid[x] = y
	for row in range N
		if not ok (grid[i] for i in range row*N,row*N+N) then return false 
	for col in range N
		if not ok (grid[i] for i in range col,N*N,N) then return false 
	true		 
#assert true, valid {a:-1,b:-1,c:-1,d:-1,e:-1,f:-1,g:-1,h:-1,i:-1}, ' ', rf, rp	
#assert true, valid {a:0, b:0,c:0,d:0,e:0,f:0,g:0,h:2,i:1}, 'i', rf, rp	
	
incr = (pointer) -> ALFABET[ALFABET.indexOf(pointer)+1]
decr = (pointer) -> ALFABET[ALFABET.indexOf(pointer)-1]
assert 'b',incr 'a'
assert 'a',decr 'b'

solve = (kenken,ops) ->
	print N = Math.sqrt kenken.length
	print rf = f kenken
	print rg = g rf, ops
	print rp = makePerms rg
	indexes = {}
	for key of ops
		indexes[key] = -1 
	pointer = 'a'
	indexes['a'] = 0
	stopper = ALFABET[1 + _.size ops]

	while pointer not in [' ',stopper]
		flag = indexes[pointer] < rp[pointer].length
		if flag and valid indexes,pointer,rf,rp
			pointer = incr pointer 
			if pointer < stopper 
				indexes[pointer]++
				#print 'A',pointer, indexes[pointer]
		else if indexes[pointer] < rp[pointer].length-1
			indexes[pointer]++
			if pointer < indexes.length then indexes[incr pointer] = -1
			#print 'B',pointer,indexes[pointer]
		else
			indexes[pointer] = -1
			pointer = decr pointer
			indexes[pointer]++
			#print 'C',pointer,indexes[pointer]

	indexes

start = Date.now()

# assert {a: 0, b: 0, c: 0, d: 0, e: 0}, solve "abbacdeed", {a:'5+',b:'3/',c:'2',d:'1-',e:'2-'}
# assert {a:0,b:0,c:0,d:0,e:0,f:0,g:0,h:2,i:1}, solve "abbcddecffgghhii", {a:'4',b:'2/',c:'12*',d:'1-',e:'3',f:'7+',g:'2/',h:'1-',i:'3-'}
# assert {a:0,b:5,c:3,d:2,e:2,f:0,g:5,h:0}, solve "aabbcdefcdeghhgg", {a:'2/',b:'1-',c:'2/',d:'4+',e:'1-',f:'1',g:'8*',h:'7+'}

sol6x6 = 
	a: 1
	b: 13
	c: 2
	d: 7
	e: 4
	f: 3
	g: 2
	h: 4
	i: 0
	j: 4
	k: 0
	l: 1
	m: 3
	n: 4
	o: 10
	p: 3
	q: 0
#assert sol6x6, solve "aabccdeebbddffgghijflmhnjklmonppqqoo", {a:'11+',b:'11+',c:'3/',d:'12*',e:'1-',f:'6*',g:'5+',h:'3-',i:'4',j:'7+',k:'3',l:'11+',m:'5+',n:'2/',o:'12+',p:'6+',q:'5-'}

sol7x7 =
	a: 1
	b: 16
	c: 2
	d: 6
	e: 0
	f: 7
	g: 2
	h: 4
	i: 0
	j: 8
	k: 1
	l: 0
	m: 0
	n: 2
	o: 5
	p: 5
	q: 5
	r: 3
	s: 4
	t: 1
	u: 10
	v: 2	# 200 ms
#assert sol7x7, solve "aabbcddefbbcghefijjghklimjnokppmnnoqrssstuqrvvvtu", {a:'6-',b:'360*',c:'5-',d:'2/',e:'15*',f:'3-',g:'1-',h:'6+',i:'13+',j:'12+',k:'3+',l:'6',m:'8+',n:'120*',o:'1-',p:'3-',q:'2-',r:'1-',s:'8+',t:'6-',u:'1-',v:'60*'}

# 9x9
print solve "abcccddeeabfgghdeeiifjjhkkklmfnoopqqlmrnsppttumrvspwwxuuyyzAAwxBByCzzDDEFFFCGGHHE", {a:'3-',b:'8+',c:'16+',d:'9+',e:'33+',f:'10+',g:'3+',h:'7+',i:'7+',j:'1-',k:'16+',l:'8-',m:'18+',n:'16+',o:'9+',p:'21+',q:'4-',r:'8-',s:'2-',t:'3-',u:'16+',v:'5',w:'17+',x:'7+',y:'16+',z:'22+',A:'3+',B:'7-',C:'7+',D:'4+',E:'9+',F:'13+',G:'17+',H:'12+'}

print 'Ready!',Date.now()-start
