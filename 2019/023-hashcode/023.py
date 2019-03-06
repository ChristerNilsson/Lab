import random
import time

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
		#self.sortPhotos()

		if len(self.vphotos) > 0:
			print('v',self.vphotos[0])
			print('v',self.vphotos[-1])
		if len(self.hphotos) > 0:
			print('h',self.hphotos[0])
			print('h',self.hphotos[-1])

	def score(self,set1,set2):
		a = set1.intersection(set2)
		b = set1.difference(set2)
		c = set2.difference(set1)
		return min(len(a),len(b),len(c))

	def combineV(self, prevSlide=None):
		photos = self.vphotos
		if len(photos)==0: return

		if prevSlide == None:
			slide = Slide()
			slide.add(photos[0])
			slide.add(photos[1])
			del photos[1]
			del photos[0]
			score = 0
			return score,slide,0,1

		n = len(photos)

		def findBest():
			best = [-1] * 100
			bestSoFar = [-1,-1,-1]
			for summa in range(len(best)):
				for i in range(summa//2):
					j = summa - i - 1
					if i>=n or j>=n:continue
					#print(summa,i,j)
					photo1 = photos[i]
					photo2 = photos[j]
					#maxScore = min(len(photo1.set) // 2, len(photo2.set) // 2)
					set12 = photo1.set.union(photo2.set)
					score = self.score(prevSlide.set, set12)
					if score > bestSoFar[0]: bestSoFar = [score,i,j]
					#if self.score(photo1.set,photo2.set) == maxScore:
					#	maxScore = min(len(prevSlide.set) // 2, len(set12) // 2)
					#	if score == maxScore: return maxScore,i,j
					#best[summa] = score
			#print('fallback')
			return bestSoFar

		score,index0,index1 = findBest()
		slide=Slide()
		slide.add(photos[index0])
		slide.add(photos[index1])
		return score,slide,index0,index1

	def combineH(self,prevSlide=None):
		photos = self.hphotos
		if len(photos)==0: return

		if prevSlide == None:
			slide = Slide()
			slide.add(photos[0])
			del photos[0]
			return 0,slide,0

		scores = []
		n = len(photos)
		for i in range(PROBES):
			slide = Slide()
			index = i % n
			slide.add(photos[index])
			scores.append([self.score(prevSlide.set, slide.set),index])
		score,index = max(scores)
		slide = Slide()
		photo = photos[index]
		slide.add(photo)
		return score,slide,index


	# def sortPhotos(self): # enligt antal forst. Inom antalsgrupperna alla med alla.
	# 	def findFriend(i, n, lst):
	# 		for j in range(n):
	# 			score = self.score(lst[i], lst[j])
	# 			if score == index // 2:  # done
	# 				return j
	# 		return -1
	# 			#key = f"{index} {score}"
	# 			#if key not in stats: stats[key] = 0
	# 			#if score != 0: stats[key] += 1
	#
	# 	arr = [[] for i in range(50)]
	# 	stats = {}
	# 	for photo in self.vphotos:
	# 		index = len(photo.set)
	# 		arr[index].append(photo)
	# 	for index in range(len(arr)):
	# 		lst = arr[index]
	# 		n = len(lst)
	# 		print(index,n)
	# 		for i in range(n):
	# 			print(i,findFriend(i,n,lst))
	# 			break
	# 	z=99


	def findPair(self,photo1):
		for i,photo in enumerate(self.hphotos):
			s = self.score(photo1.set,photo.set)
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
			print(len(self.hphotos), i, self.total)
			slide = Slide()
			slide.add(self.hphotos[i])
			self.slides.append(slide)
			del self.hphotos[i]
		print('v+h',self.total)

	def combine(self):
		if self.letter=='b': n = 80000 # slides
		if self.letter=='c': n = 750   # 250 + 500
		if self.letter=='d': n = 60000 # 30000 + 30000
		if self.letter=='e': n = 40000

		self.slides = []
		if self.letter in 'bc':
			score,slide,index = self.combineH(None)
			self.slides.append(slide)
		if self.letter in 'de':
			score,slide,index0,index1 = self.combineV(None)
			self.slides.append(slide)

		while len(self.slides) < n:
			slide = self.slides[-1]
			scoreV = -1
			scoreH = -1
			if len(self.vphotos) >= 2: scoreV,slideV,index0,index1 = self.combineV(slide)
			if len(self.hphotos) >= 1: scoreH,slideH,index = self.combineH(slide)
			#print(scoreV,index0,index1)
			#print(scoreH,index)
			if scoreV > scoreH and scoreV != -1:
				self.total += scoreV
				self.slides.append(slideV)
				if index0 < index1: index0,index1 = index1,index0
				del self.vphotos[index0]
				del self.vphotos[index1]
			elif scoreH != -1:
				self.total += scoreH
				self.slides.append(slideH)
				del self.hphotos[index]
			print(len(self.slides), n, self.total)

		print('')
		print('hphotos',len(self.hphotos))
		print('vphotos',len(self.vphotos))
		print('v+h',self.total)

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

FILE = 'e'
PROBES = 10

print(FILE,PROBES)
problem = Problem(FILE)

start = clock()
result = problem.combine()
print(clock()-start)
problem.write(result)


