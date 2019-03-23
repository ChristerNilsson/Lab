import time
clock = time.perf_counter

DIFF_THRESHOLD = 1e-40
DECS = 6

class Fixed:
	FREE = 0
	A = 1
	B = 2

class Node:
	def __init__(self, voltage=0, fixed=Fixed.FREE):
		self.voltage = voltage
		self.fixed = fixed
	def __repr__(self): return f"{str(round(self.voltage,DECS))}"
	def __str__(self): return self.repr()

class Network:
	def __init__(self,n,boundary,network):
		self.n = n
		self.boundary = boundary
		self.nodes = [Node() for i in range(n)]
		self.resistors = {}
		for resistor in network.split('|'):
			n1,n2,resistance = resistor.split(' ')
			n1 = int(n1)
			n2 = int(n2)
			resistance = int(resistance)
			if not n1 in self.resistors: self.resistors[n1] = []
			if not n2 in self.resistors: self.resistors[n2] = []
			self.resistors[n1].append([n2, resistance])
			self.resistors[n2].append([n1, resistance])

	def solve(self):
		start = clock()
		result = self.iter()
		#print(result)
		print(clock()-start)
		return result

	def set_boundary(self):
		a,b,avolt,bvolt = self.boundary
		self.nodes[a] = Node(avolt,Fixed.A)
		self.nodes[b] = Node(bvolt,Fixed.B)

	def calc_difference(self, diff): # returns sum of differences squared
		total = 0.0
		for i in range(len(self.nodes)):
				inode = self.nodes[i]
				upper = 0
				lower = 0
				for [j,resistance] in self.resistors[i]:
					jnode = self.nodes[j]
					upper += jnode.voltage/resistance
					lower += 1/resistance
				v = upper/lower
				v = inode.voltage - v
				diff[i].voltage = v
				if inode.fixed == Fixed.FREE: total += v ** 2
		#print(self.nodes,total)
		return total

	def dump(self):
		print('nodes',self.nodes)
		#print('resistors',self.resistors)

	def iter(self): # returns the equivalent resistance
		difference = [Node() for node in self.nodes]
		antal = 0
		while True:
			self.set_boundary() # Enforce boundary conditions.
			#self.dump()
			if self.calc_difference(difference) < DIFF_THRESHOLD: break
			for i in range(self.n): self.nodes[i].voltage -= difference[i].voltage
			antal += 1
			#print(antal)

		cur = [0.0] * 3
		for i in range(self.n):
			for [j, resistance] in self.resistors[i]:
				if i<j:
					#print(i,j,self.nodes[i].voltage,resistance,self.nodes[i].voltage / resistance)
					cur[self.nodes[i].fixed] += (self.nodes[i].voltage-self.nodes[j].voltage) / resistance
					#cur[self.nodes[i].fixed] +=  (self.nodes[j].voltage) / resistance #
				 	#cur[self.nodes[i].fixed] += difference[i].voltage / resistance # 10*10 ok
					#cur[self.nodes[i].fixed] += (difference[i].voltage-difference[j].voltage) / resistance  # 10 resistors ok 4res ok

		# cur = [0.0] * 3
		# for i in range(self.n):
		# 	for [j, resistance] in self.resistors[i]:
		# 		if i<j:
		# 			print(i,j,difference[i].voltage,resistance,difference[i].voltage / resistance)
		# 			cur[self.nodes[i].fixed] += difference[i].voltage / resistance

		a,b,avolt,bvolt = self.boundary
		return (avolt-bvolt) / (cur[Fixed.A] - cur[Fixed.B])

def createMesh(n,resistance=1):
	result0 = [f"{n*i+j} {n*i+j+1} {resistance}" for i in range(n) for j in range(n-1)]
	result1 = [f"{n*j+i} {n*j+i+n} {resistance}" for i in range(n) for j in range(n-1)]
	return "|".join(result0 + result1)

assert 1.8571428571428568 == Network(4*4,[0,4*4-1,1,-1],createMesh(4)).solve()
assert 3.0116695648965326 == Network(10*10, [0,99,1,-1],createMesh(10)).solve()
assert 1.4999999999999998 == Network(3*3,[0,3*3-1,1,-1],createMesh(3)).solve()
assert 6.023339129793065 == Network(10*10, [0,99,1,-1],createMesh(10,2)).solve()
assert 10 == Network(2,[0,1,1,-1],"0 1 10").solve()
assert 29.999999999999993 == Network(3,[0,2,1,-1],"0 1 10|1 2 20").solve()
assert 6.666666666666666 == Network(2,[0,1,1,-1],"0 1 10|0 1 20").solve()
assert 59.999999999999986 == Network(4,[0,3,1,-1],"0 1 10|1 2 20|2 3 30").solve()
assert 5.454545454545454 == Network(2,[0,1,1,-1],"0 1 10|0 1 20|0 1 30").solve()
assert 22.0 == Network(3,[0,2,1,-1],"0 1 10|1 2 20|1 2 30").solve()

##### KNAS ####
print(createMesh(4))

# assert 10 == Network(7,[0,1,18,0],"0 2 6|2 3 4|3 4 10|4 5 2|5 6 8|6 1 4|3 5 6|3 6 6|3 1 8|2 1 8").solve() # knas
#assert 10.8 == Network(4,[0,1,18,0],"0 2 6|2 3 4|3 1 8|2 1 8").solve() # knas
#assert 1.6089912417307286 == Network(10*10, [11,67,1,-1],createMesh(10)).solve() # KNAS!
