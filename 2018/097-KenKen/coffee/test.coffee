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

#assert true, valid {a:-1,b:-1,c:-1,d:-1,e:-1,f:-1,g:-1,h:-1,i:-1}, ' ', rf, rp	
#assert true, valid {a:0, b:0,c:0,d:0,e:0,f:0,g:0,h:2,i:1}, 'i', rf, rp	

assert [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]], permute [1,2,3]
assert [1,2,3,4], _.uniq [1,2,3,4] 
assert true, ok [1,2,3,4]
assert false,ok [1,2,2,4]
assert true, ok [0,0,0,0]
assert true, ok [4,0,0,1]
assert false,ok [4,0,0,4]

assert 'b',incr 'a'
assert 'a',decr 'b'
