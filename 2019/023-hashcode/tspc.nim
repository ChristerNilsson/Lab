import tables, strutils, sets, algorithm, times #, sugar

# nim c --checks:off --boundChecks:off --opt:speed -r tspc.nim

type 
  StringSet = HashSet[string]

var
  photos: array[80000,StringSet]
  n: int
  route: array[80000,int]
  totalScore: int
  start: float
  swaps: int

proc read() = 
  var id : int = 0

  for line in lines "e.txt":
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
  photos[route[i]] + photos[route[j]]

proc score1(s: StringSet, t: StringSet): int =
  min [(s*t).card, (s-t).card, (t-s).card]

proc score4(a:int,b:int,c:int,d:int): int = 
  score1 slide(a,b),slide(c,d)

proc score6(a:int,b:int,c:int,d:int,e:int,f:int): int = 
  let s0 = slide(a,b)
  let s1 = slide(c,d)
  let s2 = slide(e,f)
  score1(s0,s1) + score1(s1,s2)

proc swapscore(i:int,j:int): int =
  if i mod 2 == 0: # both even
    let xold = score4(i-2,i-1,i+0,i+1) + score4(j-2,j-1,j+0,j+1)
    let xnew = score4(i-2,i-1,j-1,j-2) + score4(i+1,i+0,j+0,j+1) 
    return xnew - xold
  else: # both odd
    let xold = score6(i-3,i-2,i-1,i+0,i+1,i+2) + score6(j-3,j-2,j-1,j+0,j+1,j+2)
    let xnew = score6(i-3,i-2,i-1,j-1,j-2,j-3) + score6(i+2,i+1,i+0,j+0,j+1,j+2)
    return xnew - xold

proc calc1(i : int): int = score4 i+0,i+1,i+2,i+3

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

n = 80000 # number of photos
read()
init()
totalScore = calc()
start = cpuTime()
echo start
swaps = 0
two_opt()
