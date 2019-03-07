# istf att använda Pythons sets.
import time

# Resultat: bits tar 20-40% mera tid for stora N
# e har 500 olika tags. dvs 500 bitar behovs.

PHOTOS = []
hash = {}

clock = time.perf_counter

def getbit(tag):
	if tag in hash: return hash[tag]
	bit = 1 << len(hash)
	hash[tag] = bit
	return bit

# def getnr(tag):
# 	if tag in hash: return hash[tag]
# 	nr = len(hash)
# 	hash[tag] = nr
# 	return nr

def bits(tags):
	result = 0
	for tag in tags:
		result |= getbit(tag)
	return result

class Photo:
	def __init__(self, id, tags):
		self.id = id
		self.bits = bits(tags)
		self.set = set(tags)

def read(letter):
	with open(letter + '.txt') as f:
		n = int(f.readline())
		for id in range(n):
			arr = f.readline().strip().split(' ')
			tags = arr[2:]
			PHOTOS.append(Photo(id, tags))

####################

#arr = [0,1, 1,2, 1,2,2,3, 1,2,2,3,2,3,3,4, 1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5]
# def bitcount(bits):
# 	result = 0
# 	while bits > 0:
# 		result += arr[bits & 31]
# 		bits >>= 5
# 		#result += arr[bits & 15]
# 		#bits >>= 4
# 	return result

def score0(i,j):
	bits0 = PHOTOS[i].bits
	bits1 = PHOTOS[j].bits
	a = bits0 & bits1
	b = bits0 ^ a
	c = bits1 ^ a
	a = bin(a).count("1")
	b = bin(b).count("1")
	c = bin(c).count("1")
	return min(a,b,c)
	# print('')
	# print(PHOTOS[i].tags)
	# print(bin(bits0))
	# print(PHOTOS[j].tags)
	# print(bin(bits1))
	# print(bits0,bits1,result)

def score1(i,j):
	set0 = PHOTOS[i].set
	set1 = PHOTOS[j].set
	a = set0.intersection(set1)
	b = set0.difference(set1)
	c = set1.difference(set0)
	return min(len(a),len(b),len(c))

N = 80000
i = N-1
read('e')

start = clock()
for j in range(N): score0(i,j)
print('bits',clock()-start)

start = clock()
for j in range(N): score1(i,j)
print('sets',clock()-start)

print(len(hash))
print(PHOTOS[N-1].bits)
print(bin(PHOTOS[N-1].bits))
print(PHOTOS[N-1].set)
