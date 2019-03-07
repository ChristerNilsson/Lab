import tables, strutils, sets, algorithm, times

type
	Photo* = ref object of RootObj
		id: int
		orientation: string
		tags: seq[string]
		set: HashSet[string]

var
	PHOTOS: array[80000,Photo]
	n: int
	route: array[80000,int]
	totalScore: int
	start: float
	swaps: int

proc read() = 
	var orientation: string
	var arr : seq[string]
	var id : int = 0
	var tags : seq[string]
	var set : HashSet[string]

	for line in lines "e.txt":
		arr = line.split ' '
		orientation = arr[0]
		tags = arr[2..^1]
		set = toSet tags
		PHOTOS[id] = Photo(id:id, orientation:orientation, tags:tags, set:set) # parens req.
		id += 1

proc save() =
	let f = open("eeee.out", fmWrite)
	defer: f.close()
	f.writeLine route.len
	for line in route:
		f.writeLine line

proc set(i: int, j: int) : HashSet[string] = 
	#assert i>=0
	#assert j>=0
	#assert i<route.len
	#assert j<route.len # problem!

	#let id0 = route[i]
	#let id1 = route[j]

	#assert id0 >= 0
	#assert id1 >= 0

	let s0 = PHOTOS[route[i]].set
	let s1 = PHOTOS[route[j]].set
	union s0,s1

proc score1(s: HashSet[string], t: HashSet[string]): int =
	let a = s.intersection t
	let b = s.difference t
	let c = t.difference s
	min [a.len, b.len, c.len]

proc score4(a:int,b:int,c:int,d:int): int = 
	let s0 = set(a,b) # parens req 
	let s1 = set(c,d)
	score1 s0,s1

proc score6(a:int,b:int,c:int,d:int,e:int,f:int): int = 
	let s0 = set(a,b)
	let s1 = set(c,d)
	let s2 = set(e,f)
	score1(s0,s1) + score1(s1,s2)

proc swapscore(i:int,j:int): int =
	#assert i mod 2 == j mod 2 
	if i mod 2 == 0: # even
		# slides: a0b0 c0d0
		#let a0 = i - 2  # index to route to photo
		#let b0 = i - 1
		#let c0 = i
		#let d0 = i + 1

		# slides: a1b1 c1d1
		#let a1 = j - 2  # index to route to photo
		#let b1 = j - 1
		#let c1 = j
		#let d1 = j + 1

		let old = score4(i-2,i-1,i+0,i+1) + score4(j-2,j-1,j+0,j+1)
		let new = score4(i-2,i-1,j-1,j-2) + score4(i+1,i+0,j+0,j+1) # even
		return new - old
	else: # odd
		# slides: a0b0 c0d0 e0f0
		let a0 = i - 3  # index to route to photo
		let b0 = i - 2
		let c0 = i - 1
		let d0 = i + 0
		let e0 = i + 1
		let f0 = i + 2

		# slides: a1b1 c1d1 e1f1
		let a1 = j - 3  # index to route to photo
		let b1 = j - 2
		let c1 = j - 1
		let d1 = j + 0
		let e1 = j + 1
		let f1 = j + 2

		let old = score6(a0,b0,c0,d0,e0,f0) + score6(a1,b1,c1,d1,e1,f1)
		let new = score6(a0,b0,c0,c1,b1,a1) + score6(f0,e0,d0,d1,e1,f1)
		return new - old

proc calc1(i : int): int = 
	#assert i mod 2 == 0
	let photo0 = PHOTOS[route[i+0]]
	let photo1 = PHOTOS[route[i+1]]
	let s0 = photo0.set.union(photo1.set)
	let photo2 = PHOTOS[route[i+2]]
	let photo3 = PHOTOS[route[i+3]]
	let s1 = photo2.set.union(photo3.set)
	score1 s0,s1

proc calc(): int =
	for i in countup(0,80000-2-1,2):
		result += calc1 i
	#result

#proc swap(i:int, j:int) = # reverses the nodes between the indices.
#  route.reverse i,j-1

proc opt(i:int,j:int) =
	var score = swapscore(i, j)
	if score > 0:
		swaps += 1

		# print('before',totalScore, calc())
		# assert totalScore == calc()

		totalScore += score
		route.reverse i,j-1 # swap(i, j)

		# print('after',totalScore, calc())
		# assert totalScore == calc()

proc two_opt() =
	swaps = 1
	while swaps > 0:
		swaps = 0
		for i in countup(2, route.len-4-3):
			let t = cpuTime() - start
			echo i, ' ', totalScore, ' ', t  #, route[:64]
			for j in countup(i+4, route.len-2-3,2):
				opt i,j
				opt i+1,j+1
		save()

proc init() = 
	for i in countup(0,80000-1):
		route[i] = i
	#assert route.len == 80000

n = 80000 # number of photos
read()
init()
totalScore = calc()
start = cpuTime()
echo start
swaps = 0
two_opt()
