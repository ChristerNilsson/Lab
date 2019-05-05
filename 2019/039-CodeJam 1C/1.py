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
###
# Case #1: RSRSRSP
# Case #2: IMPOSSIBLE
# Case #3: P
###
1
3
RSP
PR
PS
###
# Case #1: PRS
'''

#   421
#   SPR  command (win or tie)
# 0 ---  Success
# 1 --R  P
# 2 -P-  S
# 3 -PR  P
# 4 S--  R
# 5 S-R  R
# 6 SP-  S
# 7 SPR  IMPOSSIBLE

def solve(players):
	res = ''
	for i in range(1000):
		bits = 0 # 4+2+1 SPR (used characters)
		for p in players:
			letter = p[i % len(p)]
			bits |= '-RP-S'.index(letter)
		if bits == 0: return res # Success
		elif bits == 7: return 'IMPOSSIBLE'
		else: res += '-PSPRRS'[bits]
		players = [p for p in players if p[i % len(p)] == res[-1]]

for t in range(int(input())):
	A = int(input())
	players = [input() for i in range(A)]
	arr = solve(players)
	print('Case #%d:' % (t+1), arr)
