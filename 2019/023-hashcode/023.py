# 4
# H 3 cat beach sun
# V 2 selfie smile
# V 2 garden selfie
# H 2 garden cat

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
		self.photos = []
		self.slides = []
		with open(letter + '.txt') as f:
			head = f.readline()
			n = int(head)
			for i in range(n):
				arr = f.readline().strip().split(' ')
				index = i
				orientation = arr[0]
				tags = arr[2:]
				photo = Photo(index,orientation,tags)
				self.photos.append(photo)
	def score(self,slide1,slide2):
		a = slide1.set.intersection(slide2.set)
		b = slide1.set.difference(slide2.set)
		c = slide2.set.difference(slide1.set)
		return min(len(a),len(b),len(c))

	def combine(self):
		slide = Slide()
		slide.add(self.photos[0])
		self.slides.append(slide)
		slide = Slide()
		slide.add(self.photos[3])
		self.slides.append(slide)
		slide = Slide()
		slide.add(self.photos[1])
		slide.add(self.photos[2])
		self.slides.append(slide)

	def write(self):
		with open(self.letter + '.out', 'w') as f:
			print(f"{len(self.slides)}", file=f)
			for slide in self.slides:
				if len(slide.photos)==1:
					print(f"{slide.photos[0].index}", file=f)
				else:
					print(f"{slide.photos[0].index} {slide.photos[1].index}", file=f)

problem = Problem('a')
for photo in problem.photos:
	print(photo)

problem.combine()

for i in range(len(problem.slides)-1):
	slide1 = problem.slides[i]
	slide2 = problem.slides[i+1]
	print(problem.score(slide1,slide2))

problem.write()


