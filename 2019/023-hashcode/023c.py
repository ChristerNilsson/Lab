# useful for e only. (V+V)

# V0 0123456789
# V1 abcdefghij
#        *  *
# All three combinations are considered: 4e == e4
# old0 = 4e + 7h
# new1 = 7h + 4e
# new2 = 47 + eh
# new3 = 4h + 7e
# calculation includes 3d 4e 5f and 6g 7h 8i

import time
from collections import OrderedDict

PHOTOS = OrderedDict() # contains all photos
tag2ids = {} # tag => ids

clock = time.perf_counter

def printFreq(freq):
	keys = list(freq.keys())
	keys.sort()
	best = [-1,0]
	print('length',len(freq))
	for key in keys:
		if freq[key]>1:
			print('freq', key, freq[key])
			if freq[key] > best[0]: best = [freq[key], key]
	print('best',best)

class Slide:
	def __init__(self, ids): # ids is a list with one or two photo ids
		self.photos = [PHOTOS[id] for id in ids]
		self.set = set()
		for photo in self.photos: self.set = self.set.union(photo.set)

class Photo:
	def __init__(self, id, orientation, tags):
		self.id = id
		self.orientation = orientation
		self.tags = tags
		self.set = set(tags)

	def __gt__(self, other): return len(self.tags) < len(other.tags)

	def remove(self):  # delete all ids from tag2ids and also delete the photo itself
		for tag in self.tags: tag2ids[tag].remove(self.id)
		PHOTOS.pop(self.id)

class Solver:
	def __init__(self, letter):
		self.n = 0 # number of photos
		self.totalScore = 0
		self.result = [] # contains output strings
		self.read(letter)
		self.execute()
		self.save(letter)

	def score(self, slide1, slide2):
		s1 = slide1.set
		s2 = slide2.set
		a = s1.intersection(s2)
		b = s1.difference(s2)
		c = s2.difference(s1)
		return min(len(a), len(b), len(c))

	def read(self,letter):
		antal = 0
		freq = {}
		temp = []
		with open(letter + '.txt') as f:
			self.n = int(f.readline())
			for id in range(self.n):
				arr = f.readline().strip().split(' ')
				orientation = arr[0]
				tags = arr[2:]
				antal += len(tags)
				key = len(tags)
				freq[key] = freq[key] + 1 if key in freq else 1

				for tag in tags:
					if tag not in tag2ids: tag2ids[tag] = []
					tag2ids[tag].append(id)
					#PHOTOS[id] = Photo(id, orientation, tags)
					temp.append(Photo(id, orientation, tags))

		temp.sort()
		for photo in temp:
			PHOTOS[photo.id] = photo

		print('avg',antal/self.n)
		printFreq(freq)
		#return temp

	def save(self,letter):
		with open(letter + '.out', 'w') as f:
			print(f"{len(self.result)}", file=f)
			for line in self.result: print(f"{line}", file=f)

	def find(self, orientation):
		n = 1 if orientation=='H' else 2
		res = []
		for id in PHOTOS:
			photo = PHOTOS[id]
			if photo.orientation == orientation:
				res.append(id)
				if len(res) == n:
					return res
		return [-1]

	def execute(self):
		starttime = clock()
		self.save('ee')

		[seed] = self.find('H')
		if seed != -1:
			currentSlide = Slide([seed])
			PHOTOS.pop(seed)
			self.result = [seed]
		else:
			[seed0, seed1] = self.find('V')
			currentSlide = Slide([seed0, seed1])
			PHOTOS.pop(seed0)
			PHOTOS.pop(seed1)
			self.result = [f"{seed0} {seed1}"]

		while len(PHOTOS) > 0:
			best = [-1, None]
			possibleSlides = []
			#print('curr',currentSlide.photos[0].id)
			possiblePhotos = self.getPhotosWithTags(currentSlide)

			# calculate all the possible combinations of slides
			for start in range(len(possiblePhotos) - 1):
				if (possiblePhotos[start].orientation == 'H'):
					possibleSlides.append(Slide([possiblePhotos[start].id]))
				else:
					for pos, photo in enumerate(possiblePhotos):
						if photo.orientation == 'V' and pos >= start + 1:
							possibleSlides.append(Slide([possiblePhotos[start].id, photo.id]))

			for slide in possibleSlides:
				points = self.score(slide, currentSlide)
				if points > best[0]: best = [points, slide]

			maxPoints, selectedSlide = best
			if selectedSlide == None:  # No slide found -> Fallback: select the first photo(s) available
				[seed] = self.find('H')
				if seed == -1:
					[seed,seed1] = self.find('V')
				photo = PHOTOS[seed]
				if photo.orientation == 'H':  # Horizontal photo found
					selectedSlide = Slide([photo.id])
					points = self.score(selectedSlide, currentSlide)
					maxPoints = points
				else:  # Horizontal photo not found -> only vertical photos available
					[seed0, seed1] = self.find('V')
					selectedSlide = Slide([seed0, seed1])
					points = self.score(selectedSlide, currentSlide)
					maxPoints = points
					if len(selectedSlide.photos) != 2:  # Exactly 2 vertical photos per slide
						selectedSlide = None

			if (selectedSlide):
				self.totalScore += maxPoints
				currentSlide = selectedSlide
				photos = selectedSlide.photos
				if (len(photos) == 1):
					self.result.append(photos[0].id)
					PHOTOS[photos[0].id].remove()
				else:
					self.result.append(f"{photos[0].id} {photos[1].id}")
					PHOTOS[photos[0].id].remove()
					PHOTOS[photos[1].id].remove()

				#if len(PHOTOS)%1000==0:
				print(f"TotalScore {self.totalScore} photos:{self.n-len(PHOTOS)} LastScore:{maxPoints} CPU:{clock()-starttime}")

	def getPhotosWithTags(self, slide):

		idPossiblePhotos = OrderedDict()
		returnPhotos = []
		tagsInCommon2photoIds = {}

		for tag in slide.set:
			for id in tag2ids[tag]:
				if id not in idPossiblePhotos:
					idPossiblePhotos[id] = 1
				else:
					idPossiblePhotos[id] += 1

		# searching for the highest tags number and collecting a sample of photos for each record beaten
		highestTagsNumber = 0
		for id in idPossiblePhotos:
			if id not in PHOTOS: continue
			num = idPossiblePhotos[id]
			if num >= highestTagsNumber:
				returnPhotos.append(PHOTOS[id])
				highestTagsNumber = num
			else:  # We are interested to add to the tagsInCommon2photoIds only the photos not yet added!
				if num not in tagsInCommon2photoIds:
					tagsInCommon2photoIds[num] = [id] # set([id])
				else:
					tagsInCommon2photoIds[num].append(id) # add(id)
			z=99

		def calcReturnPhotos(k=0.5,addablePhotos=100):
			# adding N photos found halfway between "1 tag in common" and "highestTagsNumber tags in common" to increase the likelihood of a good score */
			#if len(tagsInCommon2photoIds) > 0:
			for num in tagsInCommon2photoIds:
				if num >= highestTagsNumber * k:
					ids = tagsInCommon2photoIds[num]
					for id in ids:
						returnPhotos.append(PHOTOS[id])
						addablePhotos -= 1
						if addablePhotos <= 0:
							return returnPhotos
			return returnPhotos

		return calcReturnPhotos(0.7,100) # Tunable from 0 to 1

solver = Solver('e')
