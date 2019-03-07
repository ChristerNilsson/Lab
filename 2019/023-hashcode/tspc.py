import time

clock = time.perf_counter

PHOTOS  = []
n = 0
result = []
route = []
totalScore = 0
start = 0

class Photo:
	def __init__(self, id, orientation, tags):
		self.id = id
		self.orientation = orientation
		self.tags = tags
		self.set = set(tags)

def read(letter):
	with open(letter + '.txt') as f:
		n = int(f.readline())
		for id in range(n):
			arr = f.readline().strip().split(' ')
			orientation = arr[0]
			tags = arr[2:]
			PHOTOS.append(Photo(id, orientation, tags))

def save(letter):
	with open(letter + '.out', 'w') as f:
		print(f"{len(route)}", file=f)
		for line in route: print(f"{line}", file=f)

def set2(i,j): # in:index out:set
	# assert i>=0
	# assert j>=0
	# assert i<len(self.route)
	# assert j<len(self.route)
	id0 = route[i]
	id1 = route[j]
	#assert id0 >= 0
	#assert id1 >= 0
	s0 = PHOTOS[id0].set
	s1 = PHOTOS[id1].set
	return s0.union(s1)

def score1(s,t): # in:set out:integer
	a = s.intersection(t)
	b = s.difference(t)
	c = t.difference(s)
	return min(len(a), len(b), len(c))

def score4(a,b,c,d): # in:index out:integer
	s0 = set2(a,b) # slides
	s1 = set2(c,d)
	return score1(s0,s1)

def score6(a,b,c,d,e,f): # in:index out:integer
	s0 = set2(a,b) # slides
	s1 = set2(c,d)
	s2 = set2(e,f)
	return score1(s0,s1) + score1(s1,s2)

def swapscore(i,j): # in:index out:integer improvement
	#assert i%2==j%2
	if i%2==0: # even
		# slides: a0b0 c0d0
		# a0 = i - 2  # index to route to photo
		# b0 = i - 1
		# c0 = i
		# d0 = i + 1

		# slides: a1b1 c1d1
		# a1 = j - 2  # index to route to photo
		# b1 = j - 1
		# c1 = j
		# d1 = j + 1

		old = score4(i-2,i-1,i+0,i+1) + score4(j-2,j-1,j+0,j+1)
		new = score4(i-2,i-1,j-1,j-2) + score4(i+1,i+0,j+0,j+1) # even
		return new - old
	else: # odd
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

		old = score6(a0,b0,c0,d0,e0,f0) + score6(a1,b1,c1,d1,e1,f1)
		new = score6(a0,b0,c0,c1,b1,a1) + score6(f0,e0,d0,d1,e1,f1)
		return new - old

def calc1(i): # i is always even

	assert i%2 == 0
	photo0 = PHOTOS[route[i+0]]
	photo1 = PHOTOS[route[i+1]]
	s0 = photo0.set.union(photo1.set)
	photo2 = PHOTOS[route[i+2]]
	photo3 = PHOTOS[route[i+3]]
	s1 = photo2.set.union(photo3.set)
	return score1(s0,s1)

def calc(): return sum([calc1(i) for i in range(0,80000-2,2)])

def swap(i,j): route[i:j] = route[j-1:i-1:-1]

def opt(i,j):
	global swaps,totalScore
	score = swapscore(i, j)
	if score > 0:
		swaps += 1

		# print('before',self.totalScore, self.calc())
		# assert self.totalScore == self.calc()

		totalScore += score
		swap(i, j)

		# print('after',self.totalScore, self.calc())
		# assert self.totalScore == self.calc()

def two_opt():
	swaps = 1
	while swaps > 0:
		swaps = 0
		for i in range(2, len(route)-4):
			print(i, totalScore, round(clock() - start)) #, self.route[:64])
			for j in range(i+4, len(route)-2,2):
				opt(i,j)
				opt(i+1,j+1)
		#self.save('eee')

def init():	return list(range(80000))

letter = 'e'
#solver = Solver('e')
n = 0 # number of photos
result = [] # contains output strings
read(letter)
route = init()
totalScore = calc()
start = clock()
swaps = 0
two_opt()
#save(letter)
