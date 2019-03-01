import time
import random
from e import E

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

		cands = []
		for i in range(len(self.slides)):
			cands.append(i)
		result = [0]
		cands.remove(0)
		print(cands)

		start = time.clock()

		while len(cands) > 0:
			a = result[-1]
			bestindex = -1
			bestscore = -1
			for b in cands:
				score = self.score(self.slides[a], self.slides[b])
				if score > bestscore:
					bestindex = b
					bestscore = score
			print('best', len(cands),bestscore,bestindex,time.clock()-start)
			if bestindex == 0: return result
			result.append(bestindex)
			cands.remove(bestindex)
		print(result)
		return result

	# slumpa två slides. Byt vid forbättring
	def swapping(self,lst):

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

		cands = E

		# cands = []
		# for i in range(len(self.slides)):
		# 	cands.append(i)
		#result = [0]
		#cands.remove(0)
		#print(cands)

		start = time.clock()

		total = 0
		n = len(self.slides)
		for i in range(1000000):
			lst = random.sample(range(1,n-1),4)
			lst.sort()
			#print(lst)
			a1,a2,b1,b2 = lst

			a0=a1-1
			a3=a2+1
			b0=b1-1
			b3=b2+1

			a0a1 = self.score(self.slides[cands[a0]], self.slides[cands[a1]])
			a2a3 = self.score(self.slides[cands[a2]], self.slides[cands[a3]])
			b0b1 = self.score(self.slides[cands[b0]], self.slides[cands[b1]])
			b2b3 = self.score(self.slides[cands[b2]], self.slides[cands[b3]])

			a0b1 = self.score(self.slides[cands[a0]], self.slides[cands[b1]])
			b2a3 = self.score(self.slides[cands[b2]], self.slides[cands[a3]])
			b0a1 = self.score(self.slides[cands[b0]], self.slides[cands[a1]])
			a2b3 = self.score(self.slides[cands[a2]], self.slides[cands[b3]])

			# a1 = random.randint(1,n-2)
			# a0 = a1-1
			# a2 = a1+1
			# b1 = random.randint(1,n-2)
			# b0 = b1-1
			# b2 = b1+1
			# a0a1 = self.score(self.slides[cands[a0]], self.slides[cands[a1]])
			# a1a2 = self.score(self.slides[cands[a1]], self.slides[cands[a2]])
			# b0b1 = self.score(self.slides[cands[b0]], self.slides[cands[b1]])
			# b1b2 = self.score(self.slides[cands[b1]], self.slides[cands[b2]])
			# a0b1 = self.score(self.slides[cands[a0]], self.slides[cands[b1]])
			# b1a2 = self.score(self.slides[cands[b1]], self.slides[cands[a2]])
			# b0a1 = self.score(self.slides[cands[b0]], self.slides[cands[a1]])
			# a1b2 = self.score(self.slides[cands[a1]], self.slides[cands[b2]])

			old = a0a1 + a2a3 + b0b1 + b2b3
			new = a0b1 + b2a3 + b0a1 + a2b3
			#print('    ', i, a1, a2, b1, b2, new - old, total)
			if new > old: # swap
				total += new-old
				print('swap',i,a1,a2,b1,b2,new-old,total)
				cands = cands[:a0+1] + cands[b1:b2+1] + cands[a3:b0+1] + cands[a1:a2+1] + cands[b3:]
				#cands[a1],cands[b1] = cands[b1],cands[a1]

		# 	bestindex = -1
		# 	bestscore = -1
		# 	for b in cands:
		# 		score = self.score(self.slides[a], self.slides[b])
		# 		if score > bestscore:
		# 			bestindex = b
		# 			bestscore = score
		# 	print('best', len(cands),bestscore,bestindex,time.clock()-start)
		# 	if bestindex == 0: return result
		# 	result.append(bestindex)
		# 	cands.remove(bestindex)
		# print(result)
		# return result

	def write(self,result):
		with open(self.letter + '.out', 'w') as f:
			print(f"{len(result)}", file=f)
			for cand in result:
				slide = self.slides[cand]
				if len(slide.photos)==1:
					print(f"{slide.photos[0].index}", file=f)
				else:
					print(f"{slide.photos[0].index} {slide.photos[1].index}", file=f)

problem = Problem('e')
print(len(problem.vphotos))
print(len(problem.hphotos))

problem.swapping(E)
# result = problem.combine()
# print(result)
# print(len(result))
# problem.write(result)

