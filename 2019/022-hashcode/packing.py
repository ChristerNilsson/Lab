# Algorithm:
# Start from the top, from left to right (Example: 4-12)
# Start with:
#   12x1 6x2 4x3 3x4 2x6 1x12
# Once placed, never change
# Check the MT composition for each tile.
# Stop when no more fits in.

class Tile:
	def __init__(self,r,c,w,h,index):
		self.r=r
		self.c=c
		self.w=w
		self.h=h
		self.index=index

	def ok(self,packer,r,c):
		ts = 0
		ms = 0
		antal = 0
		for i in range(c, c + self.w):
			if i < packer.C:
				for j in range(r, r + self.h):
					if j < packer.R:
						if packer.grid[j][i]=='T': ts+=1
						if packer.grid[j][i]=='M': ms+=1
						antal += 1
		return antal if ts >= packer.L and ms >= packer.L else 0

	def fit(self,packer):
		if not self.ok(packer,self.r,self.c): return False
		for i in range(self.w):
			for j in range(self.h):
				y = self.r + j
				x = self.c + i
				if y >= packer.R or x >= packer.C: return False
				if packer.used[y][x] == 1: return False
		return True

class Packer:
	def __init__(self,filename):
		self.filename = filename
		self.slices = []
		self.read()

	def read(self):
		with open(self.filename + '.in') as f:
			head = f.readline()
			arr = head.split(' ')
			self.R = int(arr[0])
			self.C = int(arr[1])
			self.L = int(arr[2])
			self.H = int(arr[3])
			self.used = []

			self.grid = []
			for r in range(self.R):
				s = f.readline().strip()
				arr = list(s)
				self.grid.append(arr)
				self.used.append([0] * self.C)
				#self.grid.reverse()

			self.tiles = [] # defined by L,H

			# a 1-6
			# self.tiles.append([6,1]) # 12
			# self.tiles.append([5,1])
			# self.tiles.append([4,1])
			# self.tiles.append([3,1])
			# self.tiles.append([2,1])
			# self.tiles.append([3,2])
			# self.tiles.append([1,2])
			# self.tiles.append([2,3])
			# self.tiles.append([1,3])
			# self.tiles.append([1,4])
			# self.tiles.append([1,5])
			# self.tiles.append([1,6])

	# b
	# 		self.tiles.append([5,1]) # 35 40 grid.reversed
	# 		self.tiles.append([4,1])
	# 		self.tiles.append([3,1])
	# 		self.tiles.append([2,1])
	# 		#self.tiles.append([1,2])
	# 		#self.tiles.append([1,3])
	# 		#self.tiles.append([1,4])
	# 		self.tiles.append([1,5])

			# c 4-12
			self.tiles.append([12,1]) # 49437
			self.tiles.append([11,1])
			self.tiles.append([10,1])
			self.tiles.append([9,1])
			self.tiles.append([8,1])
			self.tiles.append([6,2])
			self.tiles.append([4,3])
			self.tiles.append([3,4])
			self.tiles.append([2,6])
			self.tiles.append([1,12])
			self.tiles.append([1,11])
			self.tiles.append([1,10])
			self.tiles.append([1,9])
			self.tiles.append([1,8])

	# d 6-14
	# 		self.tiles.append([14,1]) # 894217
	# 		self.tiles.append([13,1])
	# 		self.tiles.append([12,1])
	# 		self.tiles.append([7,2])
	# 		self.tiles.append([6,2])
	# 		self.tiles.append([4,3])
	#
	# 		self.tiles.append([3,4])
	# 		self.tiles.append([2,6])
	# 		self.tiles.append([2,7])
	# 		self.tiles.append([1,12])
	# 		self.tiles.append([1,13])
	# 		self.tiles.append([1,14])
	# 		#self.tiles.reverse()

	def write(self):
		with open(self.filename + '.out','w') as f:
			print(f"{len(self.slices)}",file=f)
			for slice in self.slices:
				a = slice.r
				b = slice.c
				c = slice.w
				d = slice.h
				print(f"{a} {b} {a+d-1} {b+c-1}",file=f)

	def json(self):
		with open(self.filename + '.js','w') as f:
			print(f"slices=[",file=f)
			for slice in self.slices:
				a = slice.r
				b = slice.c
				c = slice.w
				d = slice.h
				index = slice.index
				print(f"  [{a},{b},{a+d-1},{b+c-1},{index}],",file=f)
			print("]",file=f)

	def findTile(self,r0,c0):
		index=0
		for w,h in self.tiles:
			tile = Tile(r0,c0,w,h,index)
			index+=1
			if tile.fit(self): return tile
		return None

	def mark(self,tile):
		for i in range(tile.w):
			for j in range(tile.h):
				self.used[tile.r+j][tile.c+i] = 1

	def execute(self):
		self.slices = []
		value = 0
		for r in range(self.R):
			for c in range(self.C):
				if self.used[r][c] == 0:
					tile = self.findTile(r,c)
					if tile != None:
						self.mark(tile)
						self.slices.append(tile)
						value+=tile.w*tile.h
						continue
		print(value)
		self.write()
		self.json()
		return self.slices

	def dump(self,a):
		print('')
		for row in a:
			print(''.join([str(item) for item in row]))

	def dump2(self):
		print('')
		for r in range(self.R):
			s = ''
			for c in range(self.C):
				ug = self.grid[r][c] + str(self.used[r][c])
				if ug == 'T0': ch = 't'
				if ug == 'T1': ch = 'T'
				if ug == 'M0': ch = 'm'
				if ug == 'M1': ch = 'M'
				s += ch + ' '
			print(s)

packer = Packer('c')
packer.slices = packer.execute()
#packer.dump2()
print('')
# for slice in packer.slices:
# 	print(slice.r,slice.c,slice.r+slice.w-1,slice.c+slice.h-1)
#packer.dump(packer.grid)
#packer.dump(packer.used)
