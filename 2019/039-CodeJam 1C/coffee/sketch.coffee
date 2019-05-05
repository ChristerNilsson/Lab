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

solve = (players) ->
	players = players.split ' '
	res = ''
	for i in range 1000
		bits = 0 
		bits |= '-RP-S'.indexOf p[i % p.length] for p in players
		if bits == 0 then return res 
		if bits == 7 then return 'IMPOSSIBLE'
		res += '-PSPRRS'[bits]
		players = (p for p in players when p[i % p.length] == _.last res) 

assert 'P', solve 'RS'
assert 'IMPOSSIBLE', solve 'R P S'
assert 'P', solve 'RS RS RS RS RS RS RS'
assert 'PRS', solve 'RSP PR PS'
