DIFF_THRESHOLD = 1e-40
DECS = 2

class Fixed:
	FREE = 0
	A = 1
	B = 2

class Node:
	def __init__(self, voltage=0, fixed=Fixed.FREE):
		self.voltage = voltage
		self.fixed = fixed
	def __repr__(self): return f"{str(round(self.voltage,DECS))} {self.fixed}"
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
		print("R = %.16f" % (self.iter()))

	def set_boundary(self):
		a,b,avolt,bvolt = self.boundary
		self.nodes[a] = Node(avolt,Fixed.A)
		self.nodes[b] = Node(bvolt,Fixed.B)

	def calc_difference(self, diff): # returnerar kvadratsumman
		total = 0.0
		for i in range(len(self.nodes)):
				inode = self.nodes[i]
				#if inode.fixed != Fixed.FREE: continue
				v = 0
				for [j,resistance] in self.resistors[i]:
					jnode = self.nodes[j]
					v += jnode.voltage # /resistance
				v = inode.voltage - v / len(self.resistors[i])
				diff[i].voltage = v
				#print(total,v)
				if inode.fixed == Fixed.FREE: total += v ** 2
		#print(self.nodes,total)
		return total

	def iter(self): # returns the eq Resistance
		difference = [Node() for node in self.nodes]
		antal = 0
		while True:
			self.set_boundary()  # Enforce boundary conditions.
			if self.calc_difference(difference) < DIFF_THRESHOLD: break
			for i in range(self.n): self.nodes[i].voltage -= difference[i].voltage
			antal += 1
			print(antal)

		cur = [0.0] * 3
		for i in range(self.n):
			for [j, resistance] in self.resistors[i]:
				if i<j:
					cur[self.nodes[i].fixed] += difference[i].voltage / resistance # / len(resistors[i]) # / resistance

		a,b,avolt,bvolt = self.boundary
		return (avolt-bvolt) / (cur[Fixed.A] - cur[Fixed.B])

def createMesh(n,resistance=1):
	result0 = [f"{n*i+j} {n*i+j+1} {resistance}" for i in range(n) for j in range(n-1)]
	result1 = [f"{n*j+i} {n*j+i+n} {resistance}" for i in range(n) for j in range(n-1)]
	return "|".join(result0 + result1)

#print(createMesh(2))
#network = Network(4*4, [0,15,1,-1],"0 1 1|1 2 1|2 3 1|4 5 1|5 6 1|6 7 1|8 9 1|9 10 1|10 11 1|12 13 1|13 14 1|14 15 1|0 4 1|4 8 1|8 12 1|1 5 1|5 9 1|9 13 1|2 6 1|6 10 1|10 14 1|3 7 1|7 11 1|11 15 1")

network = Network(10*10, [11,67,1,-1],createMesh(10)) # RC: Resistor Mesh Original 1.6089912417307286 (samma)

#network = Network(10*10, [0,99,1,-1],createMesh(10)) # 3.0116695648965326    original 3.0116695648965326
#network = Network(10*10, [0,99,1,-1],createMesh(10,2)) # 6.0233391297930652

#network = Network(7,[0,1,1,-1],"0 2 6|2 3 4|3 4 10|4 5 2|5 6 8|6 1 4|3 5 6|3 6 6|3 1 8|2 1 8") # 10 ohm

#N = 3
#network = Network(N*N,[0,N*N-1,1,-1],createMesh(N)) # 1 ohm

#network = Network(2,[0,1,1,-1],"0 1 10") # 1 res: 10 ohm ok
#network = Network(3,[0,2,1,-1],"0 1 10|1 2 12") # 2 res i serie: 30 ohm i serie NIX!
#network = Network(2,[0,1,1,-1],"0 1 10|0 1 20") # 2 res parallellt: 6.67 ohm YES!

#network = Network(4,[0,3,1,-1],"0 1 10|1 2 20|2 3 30") # 3 res i serie: 60 ohm i serie
#network = Network(2,[0,1,1,-1],"0 1 10|0 1 20|0 1 30") # 3 res par: 5.45 YES!
