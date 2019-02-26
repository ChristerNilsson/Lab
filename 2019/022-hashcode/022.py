grid = None
R=0
C=0
L=0
H=0
slices = []

def read(filename):
	global R,C,L,H,grid
	with open(filename + '.in') as f:
		head = f.readline()
		arr = head.split(' ')
		R = int(arr[0])
		C = int(arr[1])
		L = int(arr[2])
		H = int(arr[3])
		grid = []
		for i in range(R):
			s = f.readline()
			grid.append(s.strip())

# try to find starting and ending indices that satisfies L and H
def find(row,col):
	ts = 0
	ms = 0
	left = col
	while col<C:
		if row[col] == 'T': ts += 1
		if row[col] == 'M': ms += 1
		if ts+ms > H:
			left+=1
			col=left
			ts=0
			ms=0
		elif ts>=L and ms>=L:	return left,col
		else: col = col + 1
	return 0,0

def rowcount(row,c,cols):
	ts = 0
	ms = 0
	antal = 0
	for j in range(c, cols + c):
		if j < C:
			if row[j]=='T': ts+=1
			if row[j]=='M': ms+=1
			antal+=1
	return antal if ts>=L and ms>=L else 0

def calc(r,row):
	col = 0
	result = 0
	seqs = []
	while col < C:
		left, right = find(row, col)
		if left == 0 and right == 0: break
		if right - left + 1 <= H:
			seqs.append([left,right])
			res = rowcount(row, left, right - left + 1)
			result += res
		col = right + 1
		if col>=C: break

	# adjust length of sequences
	seqs.append([C,0])
	for i in range(len(seqs)-1):
		seq = seqs[i]
		left,right = seq
		while right < seqs[i+1][0]-1 and right-left + 1 < H:
			if rowcount(row,seq[0],right-left+1) > 0:
				right += 1
				seq[1] = right
				result += 1

	for i in range(len(seqs)-1):
		left,right = seqs[i]
		slices.append([r,left,r,right])
	return result

def execute(filename):
	read(filename)
	result = 0
	r = 0
	for row in grid:
		result += calc(r,row)
		r+=1

	with open(filename + '.out','w') as f:
		print(f"{len(slices)}",file=f)
		for a,b,c,d in slices:
			print(f"{a} {b} {c} {d}",file=f)

	return result

#print(execute('a'))
#print(execute('b'))
#print(execute('c'))
print(execute('d'))

