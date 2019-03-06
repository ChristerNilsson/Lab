#from collections import OrderedDict
import time
import random

clock = time.perf_counter

PHOTOS  = {} # OrderedDict()

class Photo:
	def __init__(self, id, orientation, tags):
		self.id = id
		self.orientation = orientation
		self.tags = tags
		self.set = set(tags)
	def __gt__(self, other): return len(self.tags) < len(other.tags)

class Solver:
	def __init__(self, letter):
		self.n = 0 # number of photos
		self.result = [] # contains output strings
		self.read(letter)
		self.route = self.init()
		self.totalScore = self.calc()
		self.start = clock()
		self.swaps = 0
		self.two_opt()
		self.save(letter)

	def read(self,letter):
		with open(letter + '.txt') as f:
			self.n = int(f.readline())
			for id in range(self.n):
				arr = f.readline().strip().split(' ')
				orientation = arr[0]
				tags = arr[2:]
				PHOTOS[id] = Photo(id, orientation, tags)

	def save(self,letter):
		with open(letter + '.out', 'w') as f:
			print(f"{len(self.route)}", file=f)
			for line in self.route: print(f"{line}", file=f)

	def set(self,i,j): # in:index out:set
		# assert i>=0
		# assert j>=0
		# assert i<len(self.route)
		# assert j<len(self.route)
		id0 = self.route[i]
		id1 = self.route[j]
		#assert id0 >= 0
		#assert id1 >= 0
		s0 = PHOTOS[id0].set
		s1 = PHOTOS[id1].set
		return s0.union(s1)

	def score1(self,s,t): # in:set out:integer
		a = s.intersection(t)
		b = s.difference(t)
		c = t.difference(s)
		return min(len(a), len(b), len(c))

	def score4(self,a,b,c,d): # in:index out:integer
		s0 = self.set(a,b) # slides
		s1 = self.set(c,d)
		return self.score1(s0,s1)

	def score6(self,a,b,c,d,e,f): # in:index out:integer
		s0 = self.set(a,b) # slides
		s1 = self.set(c,d)
		s2 = self.set(e,f)
		return self.score1(s0,s1) + self.score1(s1,s2)

	def swapscore(self,i,j): # in:index out:integer improvement
		#assert i%2==j%2
		if i%2==0: # even
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

			old = self.score4(a0,b0,c0,d0) + self.score4(a1,b1,c1,d1)
			new = self.score4(a0,b0,b1,a1) + self.score4(d0,c0,c1,d1) # even
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

			old = self.score6(a0,b0,c0,d0,e0,f0) + self.score6(a1,b1,c1,d1,e1,f1)
			new = self.score6(a0,b0,c0,c1,b1,a1) + self.score6(f0,e0,d0,d1,e1,f1)
			return new - old

	def calc1(self,i): # i is always even
		assert i%2 == 0
		photo0 = PHOTOS[self.route[i+0]]
		photo1 = PHOTOS[self.route[i+1]]
		s0 = photo0.set.union(photo1.set)
		photo2 = PHOTOS[self.route[i+2]]
		photo3 = PHOTOS[self.route[i+3]]
		s1 = photo2.set.union(photo3.set)
		return self.score1(s0,s1)

	def calc(self): return sum([self.calc1(i) for i in range(0,80000-2,2)])

	def swap(self,i,j): # reverses the nodes between the indices.
		#new = self.route[i:j]
		#new.reverse()
		self.route[i:j] = self.route[j-1:i-1:-1]

	def opt(self,i,j):
		score = self.swapscore(i, j)
		if score > 0:
			self.swaps += 1

			# print('before',self.totalScore, self.calc())
			# assert self.totalScore == self.calc()

			self.totalScore += score
			self.swap(i, j)

			# print('after',self.totalScore, self.calc())
			# assert self.totalScore == self.calc()

	def two_opt(self):
		self.swaps = 1
		while self.swaps > 0:
			self.swaps = 0
			for i in range(2, len(self.route)-4):
				print(i, self.totalScore, round(clock() - self.start)) #, self.route[:64])
				for j in range(i+4, len(self.route)-2,2):
					self.opt(i,j)
					self.opt(i+1,j+1)
			#self.save('eee')

	def init(self):	return list(range(80000))

solver = Solver('e')
