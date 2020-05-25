myRound = (x,dec=0) -> Math.round(x*10**dec)/10**dec

class Converter # bmp <=> wgs
	constructor : (inp,outp,@decimals) -> @arr = @solve inp,outp

	convert : (x,y) ->
		[a,b,c,d,e,f] = @arr
		[myRound(a*x+b*y+c,@decimals), myRound(d*x+e*y+f,@decimals)]

	solve : (inp,outp) ->
		[a,b,c,d,e,f] = inp
		eqns = []
		eqns.push [a, b, 1, 0, 0, 0]
		eqns.push [0, 0, 0, a, b, 1]
		eqns.push [c, d, 1, 0, 0, 0]
		eqns.push [0, 0, 0, c, d, 1]
		eqns.push [e, f, 1, 0, 0, 0]
		eqns.push [0, 0, 0, e, f, 1]
		@gauss eqns,outp

	# https://github.com/itsravenous/gaussian-elimination
	gauss : (A, x) ->
		n = A.length
		for i in range n
			A[i].push x[i]

		for i in range n
			index = i
			for k in range i+1, n
				# OBS: Math.abs A[index][i] < Math.abs A[k][i] funkar inte!
				if Math.abs(A[index][i]) < Math.abs(A[k][i]) then index = k

			for k in range i,n+1
				[A[index][k], A[i][k]] = [A[i][k], A[index][k]]

			for k in range i+1, n
				c = -A[k][i] / A[i][i]
				for j in range i,n+1
					A[k][j] = if i==j then 0 else A[k][j] + c * A[i][j]

		res = range(n).map -> 0
		for i in range n-1, -1, -1
			res[i] = A[i][n] / A[i][i]
			for k in range i-1, -1, -1
				A[k][n] -= A[k][i] * res[i]

		res

conv = new Converter [],[],6
assert [2], conv.gauss [[4]], [8]
assert [6,4], conv.gauss [[1, 1], [2, 1]], [10, 16]
assert [1,2,3], conv.gauss [[1, 1, 1], [2, 1, 2], [1, 2, 3]], [6, 10, 14]

bmp = [338,1491, 4299,1948, 2963,5596] # x1,y1, x2,y2, x3,y3
wgs = [18.150709,59.285624, 18.179902,59.283048, 18.168739,59.269496] # lng1,lat1, lng2,lat2, lng3,lat3

b2w = new Converter bmp,wgs,6
assert [wgs[0], wgs[1]], b2w.convert bmp[0],bmp[1]
assert [wgs[2], wgs[3]], b2w.convert bmp[2],bmp[3]
assert [wgs[4], wgs[5]], b2w.convert bmp[4],bmp[5]

w2b = new Converter wgs,bmp,0
assert [bmp[0], bmp[1]], w2b.convert wgs[0],wgs[1]
assert [bmp[2], bmp[3]], w2b.convert wgs[2],wgs[3]
assert [bmp[4], bmp[5]], w2b.convert wgs[4],wgs[5]

bmp = [185,1626, 927,1013, 1132,1667]
wgs = [18.147726, 59.270494, 18.164806, 59.277144, 18.168736, 59.269495]

b2w = new Converter bmp,wgs,6
assert [wgs[0], wgs[1]], b2w.convert bmp[0],bmp[1]
assert [wgs[2], wgs[3]], b2w.convert bmp[2],bmp[3]
assert [wgs[4], wgs[5]], b2w.convert bmp[4],bmp[5]

w2b = new Converter wgs,bmp,0
assert [bmp[0], bmp[1]], w2b.convert wgs[0],wgs[1]
assert [bmp[2], bmp[3]], w2b.convert wgs[2],wgs[3]
assert [bmp[4], bmp[5]], w2b.convert wgs[4],wgs[5]
