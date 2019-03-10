#? replace(sub = "\t", by = "  ")

from times import cpuTime
from algorithm import reverse
from strutils import split
import sets 

# nim c --checks:off --boundChecks:off --opt:speed -r tspc.nim

type 
	StringSet = HashSet[string]

var
	photos: array[80000,StringSet]
	route: array[80000,int]
	totalScore: int
	start: float
	swaps: int

proc read() = 
	var id : int = 0
	for line in lines("e.txt"):
		let arr = line.split ' '
		photos[id] = toSet arr[2..^1]
		id += 1

proc save() =
	let f = open("e.nim", fmWrite)
	defer: f.close()
	f.writeLine route.len
	for line in route:
		f.writeLine line

proc slide(i: int, j: int) : StringSet = 
	photos[route[i]].union photos[route[j]]

func score(s: StringSet, t: StringSet): int =
	min [(s.intersection t).card, (s.difference t).card, (t.difference s).card]

proc swapscore(i:int,j:int): int =
	if i mod 2 == 0: # both even
		let a = slide(i-2,i-1)
		let b = slide(i+0,i+1)
		let c = slide(j-2,j-1)
		let d = slide(j+0,j+1)
		let xold = score(a,b) + score(c,d)
		let xnew = score(a,c) + score(b,d)
		result = xnew - xold
	else: # both odd
		let a = slide(i-3,i-2)
		let b = slide(i-1,i+0)
		let c = slide(i+1,i+2)
		let d = slide(j-3,j-2)
		let e = slide(j-1,j+0)
		let f = slide(j+1,j+2)
		let g = slide(i-1,j-1)
		let h = slide(i+0,j+0)
		let xold = score(a,b) + score(b,c) + score(d,e) + score(e,f)
		let xnew = score(a,g) + score(g,d) + score(c,h) + score(h,f)
		result = xnew - xold

proc calc1(i : int): int = score slide(i+0,i+1), slide(i+2,i+3)
proc calc(): int =
	for i in countup(0,80000-2-1,2): result += calc1 i

proc opt(i:int,j:int) =
	let score = swapscore(i, j)
	if score > 0:
		swaps += 1
		totalScore += score
		route.reverse i,j-1 

proc two_opt() =
	swaps = 1
	while swaps > 0:
		swaps = 0
		for i in countup(2, route.len-4-3):
			let t = cpuTime() - start
			echo i, ' ', totalScore, ' ', t 
			for j in countup(i+4, route.len-2-3,2):
				opt i,j
				opt i+1,j+1
		save()

proc init() = 
	for i in countup(0,80000-1): route[i] = i

read()
init()
totalScore = calc()
start = cpuTime()
echo start
swaps = 0
two_opt()
