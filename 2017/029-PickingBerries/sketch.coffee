# Varje speed change har kostnaden 1.
# Varje move kostar 1.
# Hur ta alla tio bären till så låg kostnad som möjligt?
# Man rör sig i de fyra väderstrecken: ENWS

# Solution: (66 clicks)
#  100 100
#   1d0dd 
#  100 107
# 	3d2ab1a0cd 
#  131 188 	 
# 	3ad2a0aa 
#  189 175
#   3c2c1a 
#  124 138 
#   3cc2cb0a  
#  12 168
#   3bbb2a0dd  
#  32 20
#   2cd1b0add  
#  13 37
#   3aaa1ccb0b  
#  153 31
#   3ad2c1ab0cdd  
#  187 78
#   3dd1b0aadd 
#  196 188

#  1d0dd cd2ab1a3d ad0aa2a c1a3c cc2cb0a dd3bbb2a cd1b0add b1ccb3aaa ad2c1ab0cdd aadd3dd1b

setup = ->
	
	N = 200
	berries = [[100,107],[189,175],[124,138],[196,188],[13,37],[187,78],[12,168],[153,31],[32,20],[131,188]] 	 
	speeds = [1,5,20,50]

	#berries = [[67,0],[133,0],[200,0],[200,67],[200,133],[200,200],[133,200],[67,200],[0,200],[0,133]] 	 

	# start position
	x = N / 2
	y = N / 2

	path = (xb,yb,steps) ->
		res = ""
		x = [0,xb]
		y = [0,yb]
		for i in range steps.length-1,-1,-1
			step = steps[i]
			s = ''
			s += fixa 'ca',x,step
			s += fixa 'bd',y,step
			if s != "" then res += i + s
		res		

	fixa = (letters,pair,step) ->
		res = ""
		if pair[0] < pair[1] 
			while pair[1]-pair[0] > step/2
				pair[0] += step
				res += letters[1]
		else
			while pair[0]-pair[1] > step/2
				pair[0] -= step
				res += letters[0]
		res

	assert path(2,5,[1,2]), "1add0d"
	assert path(0,5,[1,2]), "1dd0d"
	assert path(2,1,[1,5]), "0aad"
	assert path(15,14,[1,5]), "1aaaddd0b"
	assert path(15,15,[1,5]), "1aaaddd"
	assert path(0,14,[1,5]), "1ddd0b"
	assert path(-14,0,[1,5]), "1ccc0a"
	assert path(-15,1,[1,5]), "1ccc0d"
	assert path(-16,-1,[1,5]), "1ccc0cb"

	all = [[N/2,N/2]].concat berries
	paths = {}
	for [x1,y1],i in all
		for [x2,y2],j in all
			paths[i+","+j] = path x2-x1, y2-y1, speeds
	#print paths

	generatePermutation = (perm, pre, post, n) ->
	  if n > 0
	    for i in [0...post.length]
	      rest = post.slice 0
	      elem = rest.splice i, 1
	      generatePermutation perm, pre.concat(elem), rest, n - 1
	  else
	    perm.push pre
	  return

	Array::permutation = (n = @.length) ->
	  perm = []
	  generatePermutation perm, [], @, n
	  perm

	permutations = [1,2,3,4,5,6,7,8,9,10].permutation 10

	best = 999
	for perm in permutations 
		permutation = [0].concat perm
		bigpath = []
		for i in range permutation.length-1
			i1 = permutation[i]
			i2 = permutation[i+1]
			bigpath.push paths[i1+","+i2]
		s = bigpath.join("").length 
		if s < best
			best = s
			print ""
			print s, permutation
			print bigpath
			print bigpath.join("")

	print "ready"

