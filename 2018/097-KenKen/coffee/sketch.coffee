N = null
ALFABET = ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'	

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

f = (kenken) ->
	res = {}
	for letter in kenken
		res[letter] = []	
	for key,i in kenken
		res[key].push i
	res

uniq = (lst) ->
	res = [lst[0]]
	for item,i in lst
		if i>0 and not _.isEqual item, _.last res then res.push item
	res 

match2 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			if total == operation a,b then res.push [a,b].sort()
	uniq res.sort()

match3 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			for c in range 1,N+1
				if total == operation a,b,c then res.push [a,b,c].sort()
	uniq res.sort()

match4 = (total,operation) ->
	res = []
	for a in range 1,N+1
		for b in range 1,N+1
			for c in range 1,N+1
				for d in range 1,N+1
					if total == operation a,b,c,d then res.push [a,b,c,d].sort()
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

makePerms = (rg) -> # adds permutations
	res = {}
	for key of rg
		lst = rg[key]
		a = []
		a = a.concat permute pair for pair in lst
		res[key] = uniq a.sort()
	res

ok = (lst) ->
	lst = _.without lst, 0
	lst.length == _.uniq(lst).length

# can be made faster by making incremental changes to grid.
# and also just checking the latest group.
valid = (indexes,pointer,rf,rp) -> 
	if pointer == ' ' then return true
	grid = (0 for i in range N*N)
	for p in ALFABET.slice 1,1+ALFABET.indexOf pointer
		rppip = rp[p][indexes[p]]
		for x,j in rf[p]
			grid[x] = rppip[j]
	for row in range N
		if not ok (grid[i] for i in range row*N,row*N+N) then return false 
	for col in range N
		if not ok (grid[i] for i in range col,N*N,N) then return false 
	true		 
	
incr = (pointer) -> ALFABET[ 1 + ALFABET.indexOf pointer]
decr = (pointer) -> ALFABET[-1 + ALFABET.indexOf pointer]

solve = (kenken,ops) ->
	N = Math.sqrt kenken.length
	rf = f kenken
	rg = g rf, ops
	
	rp = makePerms rg
	
	indexes = {}
	for key of ops
		indexes[key] = -1 
	pointer = 'A'
	indexes[pointer] = 0
	stopper = ALFABET[1 + _.size ops]

	while pointer not in [' ',stopper]
		flag = indexes[pointer] < rp[pointer].length
		if flag and valid indexes,pointer,rf,rp
			pointer = incr pointer 
			if pointer < stopper then indexes[pointer]++
		else if indexes[pointer] < rp[pointer].length-1
			indexes[pointer]++
			if pointer < indexes.length then indexes[incr pointer] = -1
		else
			indexes[pointer] = -1
			pointer = decr pointer
			indexes[pointer]++

	indexes

start = Date.now()

assert {A:0, B:0, C:0, D:0, E:0}, solve "ABBACDEED", {A:'5+',B:'3/',C:'2',D:'1-',E:'2-'}
assert {A:0,B:0,C:0,D:0,E:0,F:0,G:0,H:2,I:1}, solve "ABBCDDECFFGGHHII", {A:'4',B:'2/',C:'12*',D:'1-',E:'3',F:'7+',G:'2/',H:'1-',I:'3-'}
assert {A:0,B:5,C:3,D:2,E:2,F:0,G:5,H:0}, solve "AABBCDEFCDEGHHGG", {A:'2/',B:'1-',C:'2/',D:'4+',E:'1-',F:'1',G:'8*',H:'7+'}

sol6x6={A:1,B:13,C:2,D:7,E:4,F:3,G:2,H:4,I:0,J:4,K:0,L:1,M:3,N:4,O:10,P:3,Q:0}
assert sol6x6, solve "AABCCDEEBBDDFFGGHIJFLMHNJKLMONPPQQOO", {A:'11+',B:'11+',C:'3/',D:'12*',E:'1-',F:'6*',G:'5+',H:'3-',I:'4',J:'7+',K:'3',L:'11+',M:'5+',N:'2/',O:'12+',P:'6+',Q:'5-'}

sol7x7={A:1,B:16,C:2,D:6,E:0,F:7,G:2,H:4,I:0,J:8,K:1,L:0,M:0,N:2,O:5,P:5,Q:5,R:3,S:4,T:1,U:10,V:2}
assert sol7x7, solve "AABBCDDEFBBCGHEFIJJGHKLIMJNOKPPMNNOQRSSSTUQRVVVTU", {A:'6-',B:'360*',C:'5-',D:'2/',E:'15*',F:'3-',G:'1-',H:'6+',I:'13+',J:'12+',K:'3+',L:'6',M:'8+',N:'120*',O:'1-',P:'3-',Q:'2-',R:'1-',S:'8+',T:'6-',U:'1-',V:'60*'}

sol9x9={A:6,B:1,C:41,D:18,E:13,F:19,G:1,H:4,I:5,J:13,K:57,L:0,M:33,N:2,O:2,P:201,Q:8,R:0,S:4,T:1,U:19,V:0,W:47,X:0,Y:50,Z:16,a:0,b:1,c:5,d:2,e:6,f:18,g:0,h:4} #4563ms
assert sol9x9, solve "ABCCCDDEEABFGGHDEEIIFJJHKKKLMFNOOPQQLMRNSPPTTUMRVSPWWXUUYYZaaWXbbYcZZddefffcgghhe",  {A:'3-',B:'8+',C:'16+',D:'9+',E:'33+',F:'10+',G:'3+',H:'7+',I:'7+',J:'1-',K:'16+',L:'8-',M:'18+',N:'16+',O:'9+',P:'21+',Q:'4-',R:'8-',S:'2-',T:'3-',U:'16+',V:'5',W:'17+',X:'7+',Y:'16+',Z:'22+',a:'3+',b:'7-',c:'7+',d:'4+',e:'9+',f:'13+',g:'17+',h:'12+'}

print 'Ready!', Date.now()-start
