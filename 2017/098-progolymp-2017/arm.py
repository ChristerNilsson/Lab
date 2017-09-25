arms = []

def execute(ch,s,n):
    global arms
    sorry = 0
    for i in range(n):
        v = (i-1)%n
        h = i
        ch = s[i]
        if ch=='H':
            if arms[h]==0: arms[h]=1
            else: sorry += 1
        if ch=='V':
            if arms[v]==0:
                arms[v]=1
            else:
                sorry += 1
        if ch=='A':
            if arms[v]==0 and arms[h]==0: arms[h]=1
            elif arms[v]==1 and arms[h]==1: sorry += 1
        if ch=='B':
            if arms[v]==0 and arms[h]==0:
                arms[v]=1
                arms[h]=1
            else: sorry += 1
    return sorry

def f(s):
    n = len(s)
    global arms
    arms = [0] * n
    sorry = 0
    sorry += execute('V',s,n)
    sorry += execute('H',s,n)
    sorry += execute('A',s,n)
    sorry += execute('B',s,n)
    return sorry


assert f('BAVIABH'), 6
assert f('IHAVB'), 4
assert f('BHVBABHVIBHABVV'), 11
