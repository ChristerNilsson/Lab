'''
3
1
RS
3
R
P
S
7
RS
RS
RS
RS
RS
RS
RS
'''
'''
1
3
RSP
PR
PS
'''

# Case #1: RSRSRSP
# Case #2: IMPOSSIBLE
# Case #3: P

def solve(players):
	res = ''
	i = 0
	while True:
		result = 0
		#print(i,players)
		for player in players:
			letter = player[i%len(player)]
			if letter=='R': result |= 1
			if letter=='P': result |= 2
			if letter=='S': result |= 4
		# result contains possible letters
		if result==0: return res
		elif result==1: res+= 'P'
		elif result==2: res+= 'S'
		elif result==3: res+= 'P'
		elif result==4: res+= 'R'
		elif result==5: res+= 'R'
		elif result==6: res+= 'S'
		elif result==7: return 'IMPOSSIBLE'

		# behåll lika
		players1 = []
		for player in players:
			if player[i%len(player)]==res[-1]: players1.append(player)
		players = players1
		i+=1

	return res

for t in range(int(input())):
	print('Case #%d: ' % (t+1), end='')
	A = int(input())
	players = []
	for i in range(A):
		players.append(input())
	arr = solve(players)
	print(arr)
