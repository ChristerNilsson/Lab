# 4
# H 3 cat beach sun
# V 2 selfie smile
# V 2 garden selfie
# H 2 garden cat

import random

class Photo:
	def __init__(self,index,orientation,tags):
		self.index = index
		self.orientation = orientation
		self.tags = tags
		self.set = set()
		for tag in tags:
			self.set.add(tag)

	def __str__(self):
		return f"{self.index} {self.orientation} {self.tags} {self.set}"

class Slide:
	def __init__(self):
		self.photos = []
		self.set = set()
	def add(self,photo):
		self.photos.append(photo)
		for tag in photo.tags:
			self.set.add(tag)

	def __str__(self):
		return f"{self.score()}"

class Problem:
	def __init__(self,letter):
		self.letter = letter
		self.vphotos = []
		self.hphotos = []
		self.photos = []
		self.slides = []
		with open(letter + '.txt') as f:
			head = f.readline()
			n = int(head)
			print(n)
			for i in range(n):
				arr = f.readline().strip().split(' ')
				index = i
				orientation = arr[0]
				tags = arr[2:]
				photo = Photo(index,orientation,tags)
				if orientation == 'V': self.vphotos.append(photo)
				if orientation == 'H': self.hphotos.append(photo)

	def score(self,slide1,slide2):
		a = slide1.set.intersection(slide2.set)
		b = slide1.set.difference(slide2.set)
		c = slide2.set.difference(slide1.set)
		return min(len(a),len(b),len(c))

	def combine(self):
		print('vphotos',len(self.vphotos))
		for i in range(len(self.vphotos)//2):
			slide = Slide()
			slide.add(self.vphotos[2*i])
			slide.add(self.vphotos[2*i+1])
			self.slides.append(slide)
		print('hphotos',len(self.hphotos))
		for i in range(len(self.hphotos)):
			slide = Slide()
			slide.add(self.hphotos[i])
			self.slides.append(slide)

		self.cands = []
		print(len(self.slides))
		for i in range(len(self.slides)):
			self.cands.append(i)

		total = 0
		for i in range(1000):
			r1 = random.randint(1,len(self.slides)-2)
			a = self.cands[r1-1]
			b = self.cands[r1]
			c = self.cands[r1+1]
			r2 = random.randint(1,len(self.slides)-2)
			d = self.cands[r2-1]
			e = self.cands[r2]
			f = self.cands[r2+1]
			ab = self.score(self.slides[a],self.slides[b])
			bc = self.score(self.slides[b],self.slides[c])
			de = self.score(self.slides[d],self.slides[e])
			ef = self.score(self.slides[e],self.slides[f])

			ae = self.score(self.slides[a],self.slides[e])
			ec = self.score(self.slides[e],self.slides[c])
			db = self.score(self.slides[d],self.slides[b])
			bf = self.score(self.slides[b],self.slides[f])

			old = ab+bc+de+ef
			new = ae+ec+db+bf
			if new > old:
				total += new - old
				print('better', new-old,r1,r2,total)
				self.cands[r1],self.cands[r2] = self.cands[r2],self.cands[r1]

	def write(self):
		with open(self.letter + '.out', 'w') as f:
			print(f"{len(self.cands)}", file=f)
			for cand in self.cands:
				slide = self.slides[cand]
				if len(slide.photos)==1:
					print(f"{slide.photos[0].index}", file=f)
				else:
					print(f"{slide.photos[0].index} {slide.photos[1].index}", file=f)

problem = Problem('e')
print(len(problem.vphotos))
print(len(problem.hphotos))

problem.combine()
problem.write()


