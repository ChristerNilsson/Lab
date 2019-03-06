# Coffeescript är cirka 10 ggr långsammare än Python3.
_ = require '..\\libraries\\underscore'
require '..\\libraries\\nilsson'
require '..\\e'

print = console.log

PHOTOS  = {} 

N = 80000

class Photo
	constructor : (@id, @orientation, @tags) ->
		#@set = @tags

class Solver
	constructor : (@letter) ->
		@n = 0 # number of photos
		@result = [] # contains output strings
		@read @letter
		@route = @init()
		@totalScore = @calc()
		#print(@totalScore)
		@start = Date.now()
		#print Date.now()-@start
		@swaps = 0
		@two_opt()
		@save @letter

	read : ->
		lines = efile.split '\n'
		for line,id in lines.slice 0,N
			arr = line.split ' '
			orientation = arr[0]
			tags = arr.slice 2
			PHOTOS[id] = new Photo id, orientation, tags
			#print PHOTOS[id]

	save : ->
		print @route.length
		for line in @route
			print line

	set : (i,j) -> # in:index out:set
		#assert true, i>=0, 'aa'
		#assert true, j>=0, 'bb'
		#assert true, i<@route.length, 'cc'
		#assert true, j<@route.length, 'dd'
		id0 = @route[i]
		id1 = @route[j]
		#assert true, id0 >= 0, 'ee'
		#assert true, id1 >= 0, 'ff'
		s0 = PHOTOS[id0].tags
		s1 = PHOTOS[id1].tags
		_.union s0,s1

	score1 : (s,t) -> # in:set out:integer
		a = _.intersection s,t
		b = _.difference s,t
		c = _.difference t,s
		_.min [a.length, b.length, c.length]

	score4 : (a,b,c,d) -> # in:index out:integer
		s0 = @set a,b # slides
		s1 = @set c,d
		@score1 s0,s1

	score6 : (a,b,c,d,e,f) -> # in:index out:integer
		s0 = @set a,b # slides
		s1 = @set c,d
		s2 = @set e,f
		@score1(s0,s1) + @score1(s1,s2)

	swapscore : (i,j) -> # in:index out:integer improvement
		#assert i%2==j%2
		if i%2==0 # even
			# slides: a0b0 c0d0
			a0 = i - 2  # index to route to photo
			b0 = i - 1
			c0 = i
			d0 = i + 1

			# slides: a1b1 c1d1
			a1 = j - 2  # index to route to photo
			b1 = j - 1
			c1 = j
			d1 = j + 1

			xold = @score4(a0,b0,c0,d0) + @score4(a1,b1,c1,d1)
			xnew = @score4(a0,b0,b1,a1) + @score4(d0,c0,c1,d1) # even
			return xnew - xold
		else # odd
			# slides: a0b0 c0d0 e0f0
			a0 = i - 3  # index to route to photo
			b0 = i - 2
			c0 = i - 1
			d0 = i + 0
			e0 = i + 1
			f0 = i + 2

			# slides: a1b1 c1d1 e1f1
			a1 = j - 3  # index to route to photo
			b1 = j - 2
			c1 = j - 1
			d1 = j + 0
			e1 = j + 1
			f1 = j + 2

			xold = @score6(a0,b0,c0,d0,e0,f0) + @score6(a1,b1,c1,d1,e1,f1)
			xnew = @score6(a0,b0,c0,c1,b1,a1) + @score6(f0,e0,d0,d1,e1,f1)
			return xnew - xold

	calc1 : (i) -> # i is always even
		#assert i%2 == 0
		photo0 = PHOTOS[@route[i+0]]
		photo1 = PHOTOS[@route[i+1]]
		s0 = _.union photo0.tags, photo1.tags
		photo2 = PHOTOS[@route[i+2]]
		photo3 = PHOTOS[@route[i+3]]
		s1 = _.union photo2.tags, photo3.tags
		@score1 s0,s1

	calc : -> 
		result = 0
		for i in [0...N-2] by 2
			result += @calc1 i
		result

	swap : (i,j) -> # reverses the nodes between the indices.
		#@route[i...j] = @route[i...j].reverse()
		while i<j
			[@route[i],@route[j-1]] = [@route[j-1],@route[i]]
			i+=1
			j-=1
			#print @route

	opt : (i,j) ->
		score = @swapscore i, j
		if score > 0
			@swaps += 1
			# print('before',self.totalScore, self.calc())
			# assert self.totalScore == self.calc()
			@totalScore += score
			@swap i, j
			# print('after',self.totalScore, self.calc())
			# assert self.totalScore == self.calc()

	two_opt : ->
		@swaps = 1
		while @swaps > 0
			@swaps = 0
			for i in [2...@route.length-4]
				print i, @totalScore, Date.now() - @start #, self.route[:64])
				for j in [i+4...@route.length-2] by 2
					@opt i,j
					@opt i+1,j+1
			#self.save('eee')

	init : -> [0...N]

solver = new Solver 'e'
