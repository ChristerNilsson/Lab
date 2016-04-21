# https://github.com/Jhonyrod/Dice/

def Fill (All, sides, n, iarr):
    if n == 0:
        cnt = sum(iarr)
        key = ''.join([str(1+item) for item in sorted(iarr)])
        if key not in All[cnt]: All[cnt][key] = 0
        All[cnt][key] += 1
    else:
		for i in range(sides):
			Fill(All, sides, n-1, iarr + [i])

def solver(n,sides):
    All = []
    for i in range(n*(sides - 1) + 1): All.append({})
    Fill(All, sides, n, [])
    return All

assert solver(2,6) == [{'11': 1}, {'12': 2}, {'13': 2, '22': 1}, {'14': 2, '23': 2}, {'24': 2, '33': 1, '15': 2}, {'25': 2, '34': 2, '16': 2}, {'26': 2, '44': 1, '35': 2}, {'45': 2, '36': 2}, {'46': 2, '55': 1}, {'56': 2}, {'66': 1}]
assert len(solver(3,6)) == 16
assert len(solver(6,6)) == 31
assert len(solver(6,10)) == 55