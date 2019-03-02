import sys
import time
import random

FILE = ''
PROBES = 0

clock = time.perf_counter

class Photo:
	def __init__(self,index,orientation,tags):
		self.index = index
		self.orientation = orientation
		self.set = set(tags)

	def __lt__(self, other): return len(self.set) > len(other.set)
	def __str__(self): return f"{self.index} {self.orientation} {len(self.set)} {self.set}"

class Slide:
	def __init__(self):
		self.photos = []
		self.set = set()
	def add(self,photo):
		self.photos.append(photo)
		self.set = self.set.union(photo.set)
	def __str__(self): return f"{self.score()}"

class Problem:
	def __init__(self,letter):
		self.letter = letter
		self.vphotos = []
		self.hphotos = []
		self.slides = []
		self.total = 0
		with open(letter + '.txt') as f:
			head = f.readline()
			n = int(head)
			names = {}
			for i in range(n):
				arr = f.readline().strip().split(' ')
				index = i
				orientation = arr[0]
				tags = arr[2:]
				for tag in tags:
					names[tag] = True
				photo = Photo(index,orientation,tags)
				if orientation == 'V': self.vphotos.append(photo)
				if orientation == 'H': self.hphotos.append(photo)
			print(len(names),'tags')

		self.vphotos.sort()
		self.hphotos.sort()

		if len(self.vphotos) > 0:
			print('v',self.vphotos[0])
			print('v',self.vphotos[-1])
		if len(self.hphotos) > 0:
			print('h',self.hphotos[0])
			print('h',self.hphotos[-1])

	def score(self,slide1,slide2):
		a = slide1.set.intersection(slide2.set)
		b = slide1.set.difference(slide2.set)
		c = slide2.set.difference(slide1.set)
		#if len(a)>0: print('score',len(a),len(b),len(c))
		return min(len(a),len(b),len(c))

	def combineV(self):
		photos = self.vphotos
		print('vphotos',len(photos))
		if len(photos)==0: return
		# add first slide
		slide = Slide()
		slide.add(photos[0])
		slide.add(photos[1])
		#photos = photos[2:]
		photos.remove(photos[1])
		photos.remove(photos[0])
		self.slides.append(slide)
		while len(photos) > 0:
			#scores = []
			n = len(photos)

			best = [-1,-1,-1]
			for i in range(PROBES):
				slide = Slide()

				if self.letter in 'c':
					index0 = index1 = 0
					while index0 == index1:
						index0 = random.randint(0,n-1)
						index1 = random.randint(0,n-1)
				if self.letter in 'd':
					index0 = i % n
					index1 = (i + 1) % n
				if self.letter in 'e':
					index0 = (2*i) % n
					index1 = (2*i+1) % n

				slide.add(photos[index0])
				slide.add(photos[index1])
				score = self.score(self.slides[-1], slide)
				if score > best[0]: best = [score,index0,index1]
				#scores.append([self.score(self.slides[-1], slide),index0,index1])

			score,index0,index1 = best # max(scores)
			self.total += score
			slide = Slide()
			photo0 = photos[index0]
			photo1 = photos[index1]
			slide.add(photo0)
			slide.add(photo1)

			if index0 < index1: index0,index1 = index1,index0
			del photos[index0]
			del photos[index1]

			self.slides.append(slide)
		print('v',self.total)

	def combineH(self):
		photos = self.hphotos
		print('hphotos',len(photos))
		if len(photos)==0: return
		# add first slide
		slide = Slide()
		slide.add(photos[0])
		self.slides.append(slide)
		photos.remove(photos[0])
		while len(photos) > 0:
			scores = []
			n = len(photos)
			for i in range(PROBES):
				slide = Slide()
				#index = random.randint(0,len(photos)-1)
				index = i % n

				slide.add(photos[index])
				scores.append([self.score(self.slides[-1], slide),index])
			score,index = max(scores)
			#print(score)
			self.total += score
			slide = Slide()
			photo = photos[index]
			slide.add(photo)
			self.slides.append(slide)

			del photos[index]

		print('v+h',self.total)

	def findPair(self,photo1):
		for i,photo in enumerate(self.hphotos):
			s = self.score(photo1,photo)
			if s > 0: return i
		return -1

	def combineB(self): # file B. Hor only. Takes one hour. 196000p. Bad!
		print('hphotos',len(self.hphotos))
		if len(self.hphotos)==0: return
		slide = Slide()
		slide.add(self.hphotos[0])
		self.slides.append(slide)
		del self.hphotos[0]
		while len(self.hphotos) > 0:
			i = self.findPair(self.slides[-1].photos[0])
			print(len(self.hphotos), i)
			slide = Slide()
			slide.add(self.hphotos[i])
			self.slides.append(slide)
			del self.hphotos[i]
		print('v+h',self.total)

	def combine(self):
		self.combineV()
		if self.letter=='b':
			self.combineB()
		else:
			self.combineH()
		return list(range(len(self.slides)))

	def write(self,result):
		with open(self.letter + '.out', 'w') as f:
			print(f"{len(result)}", file=f)
			for cand in result:
				slide = self.slides[cand]
				if len(slide.photos)==1:
					print(f"{slide.photos[0].index}", file=f)
				else:
					print(f"{slide.photos[0].index} {slide.photos[1].index}", file=f)

print('FILE PROBES')

FILE = 'c' #sys.argv[1]
PROBES = 40000 # int(sys.argv[2])

print(FILE,PROBES)
problem = Problem(FILE)

start = clock()
result = problem.combine()
print(clock()-start)
problem.write(result)
