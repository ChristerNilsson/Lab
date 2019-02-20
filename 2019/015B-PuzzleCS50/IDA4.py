from time import perf_counter
import numpy as np

ALFA = '_ABCDEFGHIJKLMNO' # enbart for indexkonvertering. Ej goal i Borowski!

#                     A  B  C  D  E  F  G  H  I  J  K  L  M  N  O
#                 0   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
#tileSubsets   = [-1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1] # ABCDEFGH IJKLMNO
#tilePositions = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6]

#tileSubsets   = [-1, 0, 0, 0, 1, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2, 2] # ABCEF DGHKL IJMNO
#tilePositions = [-1, 0, 1, 2, 0, 3, 4, 1, 2, 0, 1, 3, 4, 2, 3, 4]

#                    A  B  C  D  E  F  G  H  I  J  K  L  M  N  O
#                 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
#tileSubsets   = [-1, 2, 2, 2, 2, 2, 2, 0, 0, 1, 1, 1, 0, 1, 1, 1] # GHL AEFIJM GHKLNO
#tilePositions = [-1, 0, 1, 2, 3, 4, 5, 0, 1, 0, 1, 2, 2, 3, 4, 5] #

tileSubsets   = [-1, 1, 0, 0, 0, 1, 1, 2, 2, 1, 1, 2, 2, 1, 2, 2] # BCD AEFIJM GHKLNO
tilePositions = [-1, 0, 0, 1, 2, 1, 2, 0, 1, 3, 4, 2, 3, 5, 4, 5] #

GOAL = 'ABCDEFGHIJKLMNO_'

N = 4
nodeCount = 0
nodes = {}
db = {}

costTable0 = None
costTable1 = None
costTable2 = None

def loadCostTable(filename, n):
	with open(filename, "rb") as f: return f.read(n)
costTable0 = loadCostTable('db/15-puzzle-663-0.db',4096)     # BCD
costTable1 = loadCostTable('db/15-puzzle-663-1.db',16777216) # AEFIJM
costTable2 = loadCostTable('db/15-puzzle-663-2.db',16777216) # GHKLNO

class Node:

	def __init__(self,state,move=0):
		global nodeCount
		self.state = state
		self.move = move
		nodeCount += 1

	def is_goal(self): return self.state == GOAL

	def successors(self): # 0 moves
		def swap(m):
			if self.move == -m: return
			sk = list(self.state)
			sk[loc], sk[loc+m] = sk[loc+m], sk[loc]
			ret.append(Node(''.join(sk),m))
		ret = []
		loc = self.state.index('_')
		if loc % N != 0:   swap(-1) # Left
		if loc % N != N-1: swap(+1) # Right
		if loc//N != 0:    swap(-N) # Up
		if loc//N != N-1:  swap(+N) # Down
		return ret

	def succ(self): # builds pattern database
		def swap(i,j):
			if self.state[j] == '.':
				sk = list(self.state)
				sk[i], sk[j] = sk[j], sk[i]
				state = ''.join(sk)
				if state not in nodes: ret.append(Node(state))
		ret = []
		for i,tile in enumerate(self.state):
			if tile != '.':
				if i % N != 0:      swap(i,i-1)  # Left
				if i % N != N - 1:  swap(i,i+1)  # Right
				if i // N != 0:     swap(i,i-N)  # Up
				if i // N != N - 1: swap(i,i+N)  # Down
		return ret

	def dbindex(self,sn): # builds pattern database
		result = 0
		for pos in range(16):
			if self.state[pos] == '.': continue
			tile = ALFA.index(self.state[pos])
			if tile != 0 and sn == tileSubsets[tile]:
				result |= pos << (tilePositions[tile] << 2)
		return result

	def display(self):
		result = ''
		for i in range(N*N):
			if i % N == 0: result += "\n"
			result += ' ' + self.state[i]
		result += '  ' + self.state + ' value=' + str(self.h())
		if self.state == GOAL: result += "  Solved!"
		return result

	def h(self):
		index0 = 0
		index1 = 0
		index2 = 0
		for pos in range(N*N-1, -1, -1):
			tile = ALFA.index(self.state[pos])
			if tile != 0:
				subsetNumber = tileSubsets[tile]
				if subsetNumber == 0: index0 |= pos << (tilePositions[tile] << 2)
				if subsetNumber == 1: index1 |= pos << (tilePositions[tile] << 2)
				if subsetNumber == 2: index2 |= pos << (tilePositions[tile] << 2)
		return costTable0[index0] + costTable1[index1] + costTable2[index2]

def makeCostTable(sn,state,n): # builds pattern database
	print('')
	global nodes
	result = [255]*n

	nodes = {}
	node = Node(state)
	q = [node]
	level = 0
	while True:
		r = []
		if len(q)==0: break
		for node in q:
			if node.state in nodes: continue
			index = node.dbindex(sn)
			nodes[node.state] = True
			result[index] = level
			for child in node.succ():
				if child.state not in nodes: r.append(child)
		level += 1
		print(f'moves : {level:2} {(perf_counter() - start):10.3}')
		q = r
	return result

start = perf_counter()
#costTable1 = makeCostTable(1,"........IJKLMNO.",16**7) # IJKLMNO
# print(perf_counter() - start)
# costTable0 = makeCostTable(0,"ABCDEFGH........",16**8) # ABCDEFGH
# print(perf_counter() - start)

# costTable0 = makeCostTable(0,"ABC.EF..........",16**5) # ABCEF 16 sec
# costTable1 = makeCostTable(1,"...D..GH..KL....",16**5) # DGHKL 16 sec
# costTable2 = makeCostTable(2,"........IJ..MNO.",16**5) # IJMNO 16 sec

# costTable0 = makeCostTable(0,"......GH...L....",16**3) # GHL      0.059 sec
# costTable1 = makeCostTable(0,"ABCDEF..........",16**6) # ABCDEF   180 sec
# costTable2 = makeCostTable(0,"........IJK.MNO.",16**6) # IJKMNO   184 sec

# costTable0 = makeCostTable(0,".BCD............",16**3) # BCD      0 sec
# costTable1 = makeCostTable(1,"A...EF..IJ..M...",16**6) # AEFIJM 200 sec
# costTable2 = makeCostTable(2,"......GH..KL.NO.",16**6) # GHKLNO 200 sec
print(perf_counter() - start)

def dfs(node, limit, path=[]):
	if node.state in nodes and len(path) >= nodes[node.state]: return []
	nodes[node.state] = len(path)
	if node.is_goal(): return path
	if len(path) == limit: return []
	for child in node.successors():
		if len(path) + 1 + child.h() <= limit:
			p = dfs(child, limit, path + [child])
			if len(p) > 0: return p
	return []

# def skapaDB(node, limit, level = 0):
# 	if node.state in db: return
# 	db[node.state] = level
# 	if level == limit: return
# 	for child in node.successors():
# 		p = skapaDB(child, limit, level+1)
# 		if len(p) > 0: return
# 	return


def skapaDB(n=17):
	db = {}
	node = Node('ABCDEFGHIJKLMNO_')
	node.parent = ''
	q1 = [node]
	for i in range(n):
		q2 = []
		for node in q1:
			if node.state not in db:
				db[node.state] = [i,node.parent]
				for child in node.successors():
					child.parent = node.state
					q2.append(child)
		q1 = q2
	return db

# pga olika goals.
def boro(lst): return ''.join([ALFA[lst[i]] for i in range(16)])
def korf(lst):
	print(''.join(['_ABCDEFGHIJKLMNO_'[16-lst[15-i]] for i in range(16)]))
	lst = [16 if lst[i]==0 else lst[i] for i in range(16)]
	print([16-lst[15-i] for i in range(16)]) # to borowski

start = perf_counter()
#db = skapaDB(17)
print(nodeCount, perf_counter() - start)
# for node in db:
# 	print(node,db[node])


# Two different goal states:

# _ A B C  Korf, Culberson, Gasser
# D E F G
# H I J K
# L M N O

# A B C D  Borowski
# E F G H
# I J K L
# M N O _

#boro([9,8,3,6,0,13,1,4,5,2,15,7,10,11,12,14]) # IHCF_MADEBOGJKLN 41 OK!  0.065 sek (java 15ms)
#korf([3,14,9,11,5,4,8,2,13,12,6,7,10,1,15,0]) # _AOFIJDCNHLKEGBM 46 OK!  0.298 sek (java 15ms)
#boro([9,7,5,2,0,3,1,13,11,4,6,10,15,12,14,8]) # IGEB_CAMKDFJOLNH 51 OK!  0.596 sek (java 31ms)
#boro([15,6,7,3,2,5,1,10,4,0,9,13,12,11,8,14]) # OFGCBEAJD_IMLKHN 53 OK!  1.232 sek (java 46ms)
#boro([10,3,12,5,6,15,13,7,14,11,9,2,0,4,1,8]) # JCLEFOMGNKIB_DAH 57 OK!  1.981 sek (java 31ms)
#boro([14,15,7,9,5,2,8,6,10,4,1,0,12,11,3,13]) # NOGIEBHFJDA_LKCM 61 OK! 76.166 sek (java 989ms)
#boro([14,13,15,8,7,12,5,9,3,2,10,0,1,4,11,6]) # NMOHGLEICBJ_ADKF 63 OK! 67.353 sek (java 579ms)
#korf([11,15,14,13,1,9,10,4,3,6,2,12,7,5,8,0]) # _HKIDNJMLFGOCBAE 64 NY!  8.867 sek (java 47ms)
#boro([15,14,7,11,0,10,6,1,12,2,13,5,3,4,8,9]) # ONGK_JFALBMECDHI 65 OK! 33.505 sek (java 297ms)
#korf([11,14,13,1,2,3,12,4,15,7,9,5,10,6,8,0]) # _HJFKGIALDMNOCBE 66 OK! 87.986 sek (java 703ms)
#korf([15,14,8,12,10,11,9,13,2,6,5,1,3,7,4,0]) # _LIMOKJNCGEFDHBA 80 OK!     22 h   (java 255sek) (Gasser)

# def convert(state):
# 	res = ''
# 	for ch in state:
# 		i = '_ABCDEFGHIJKLMNO'.index(ch)
# 		res += '0123456789ABCDEF'[i]
# 	return res

start = perf_counter()
#ALFA = convert(ALFA)
#GOAL = convert(GOAL)
startNode = Node('IHCF_MADEBOGJKLN')

for limit in range(99):
	nodes = {}
	print(f"Limit Search at level {limit}",nodeCount,perf_counter() - start)
	path = dfs(startNode, limit)
	if len(path) > 0:
		print(f"Finished {limit}", nodeCount, perf_counter() - start)
		for p in path: print(p.display())
		if path[-1].state in db:
			print('\nfinns i db!')
			state = db[path[-1].state][1]
			while state != '':
				node = Node(state)
				print(node.display())
				state = db[state][1]
		print(len(path)) # + db[path[-1].state][0])
		break

# nodes = {}
# limit = 10
# skapaDB(Node('_ABCDEFGHIJKLMNO', 'ONHLJKIMBFEACGD_'), limit)
# print(f"Limit Search at level {limit}", nodeCount, perf_counter() - start)

	# def h_MDLC(self):
	#
	# 	def manhattan(i, j): return abs(i // N - j // N) + abs(i % N - j % N)
	# 	def manhattanTotal(): return 1.0 * sum([manhattan(i, self.target.index(self.state[i])) for i in range(N*N) if self.state[i] != '_'])
	#
	# 	def movesForConflicts(conflictCount):
	# 		a,b,c,d = conflictCount
	# 		if a == 4: return 0
	# 		elif d == 4:return 6
	# 		elif b == 2 and c != 2 or b == 3:return 2
	# 		else: return 4
	#
	# 	return manhattanTotal()
	#
	# 	#if self.state in db:
	# 		#print('h',manh,self.state,db[self.state][0])
	# 		#return db[self.state][0]
	# 	#else:
	#
	# 	reqMoves = 0
	# 	cp = self.target # correct positions
	#
	# 	hConflicts = [0] * 16
	# 	vConflicts = [0] * 16
	#
	# 	board = self.state
	#
	# 	for i in range(4): # row
	# 		for j in range(4): # col
	# 			ij = 4*i+j
	# 			tileij = board[ij]
	# 			if tileij != '_':
	#
	# 				if cp.index(tileij) // 4 == i:
	# 					for k in range(j + 1, 4):
	# 						ik = 4*i+k
	# 						tileik = board[ik]
	# 						if tileik != '_' and cp.index(tileik) // 4 == i and cp.index(tileik) % 4 < cp.index(tileij) % 4:
	# 							hConflicts[ik] += 1
	# 							hConflicts[ij] += 1
	#
	# 				if cp.index(tileij) % 4 == j:
	# 					for k in range(i + 1, 4):
	# 						kj = 4*k+j
	# 						tilekj = board[kj]
	# 						if tilekj != '_' and cp.index(tilekj) % 4 == j and cp.index(tilekj) // 4 < cp.index(tileij) // 4:
	# 							vConflicts[kj] += 1
	# 							vConflicts[ij] += 1
	#
	# 	for i in range(4):
	# 		conflictCount = [0, 0, 0, 0]
	# 		for j in range(4):
	# 			ij = 4*i+j
	# 			conflictCount[hConflicts[ij]] += 1
	# 		#print('a',conflictCount,movesForConflicts(conflictCount))
	# 		reqMoves += movesForConflicts(conflictCount)
	#
	# 	for j in range(4):
	# 		conflictCount = [0, 0, 0, 0]
	# 		for i in range(4):
	# 			ij = 4*i+j
	# 			conflictCount[vConflicts[ij]] += 1
	# 		#print('b',conflictCount,movesForConflicts(conflictCount))
	# 		reqMoves += movesForConflicts(conflictCount)
	#
	# 	#print('h',self.state, vConflicts, hConflicts, reqMoves,manhattanTotal())
	# 	return reqMoves + manhattanTotal()
