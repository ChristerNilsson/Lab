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
		for i in range(len(self.slides)):
			self.cands.append([i])

		total = 0
		#n = len(self.slides)
		for i in range(900):
			lst = []
			if len(self.cands)==0: continue
			indexa = random.randint(0,len(self.cands)-1)
			for indexb in range(len(self.cands)):
				lista = self.cands[indexa]
				listb = self.cands[indexb]
				a1 = lista[0]
				a2 = lista[-1]
				b1 = listb[0]
				b2 = listb[-1]

				scorea1b1 = self.score(self.slides[a1], self.slides[b1])
				a1b1 = lista + list(reversed(listb))
				scorea1b2 = self.score(self.slides[a1], self.slides[b2])
				a1b2 = list(reversed(lista)) + list(reversed(listb))
				scorea2b1 = self.score(self.slides[a2], self.slides[b1])
				a2b1 = lista + listb
				scorea2b2 = self.score(self.slides[a2], self.slides[b2])
				a2b2 = list(reversed(lista)) + listb

				lst.append([scorea1b1, indexa, indexb,a1b1])
				lst.append([scorea1b2, indexa, indexb,a1b2])
				lst.append([scorea2b1, indexa, indexb,a2b1])
				lst.append([scorea2b2, indexa, indexb,a2b2])
			score,a,b,newlist = max(lst)
			print('better', score,a,b)

			self.cands[a]= newlist
			print(len(self.cands),self.cands)
			if a!=b:
				del self.cands[b]

		print(self.cands)

	def write(self):
		with open(self.letter + '.out', 'w') as f:
			print(f"{len(self.cands)}", file=f)
			cands = self.cands[0]
			for cand in cands:
				slide = self.slides[cand]
				if len(slide.photos)==1:
					print(f"{slide.photos[0].index}", file=f)
				else:
					print(f"{slide.photos[0].index} {slide.photos[1].index}", file=f)

problem = Problem('c')
print(len(problem.vphotos))
print(len(problem.hphotos))

problem.combine()
problem.write()


