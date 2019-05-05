'''
5
2 2
..
.#
4 4
.#..
..#.
#...
...#
3 4
#.##
....
#.##
1 1
.
1 2
##
'''

'''
Case #1: 0
Case #2: 0
Case #3: 7
Case #4: 2
Case #5: 0
'''

def solve(r,c,rows):
	res = 0

	for i in range(r):
		antal=0
		for j in range(c):
			if rows[i][j] == '.': antal+=1
		if antal==c: res += r

	for j in range(c):
		antal=0
		for i in range(r):
			if rows[i][j] == '.': antal+=1
		if antal==r: res += c

	return res

for t in range(int(input())):
	print('Case #%d: ' % (t+1), end='')
	r, c = map(int, input().split())
	rows=[]
	for i in range(r):
		rows.append(input())
	res = solve(r,c,rows)
	print(res)
