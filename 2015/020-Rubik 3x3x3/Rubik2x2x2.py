# http://codegolf.stackexchange.com/questions/10768/solve-rubiks-cube

# Same as Rubik3x3x3 but with target 2x2x2

T = []
S = [0]*8,'UVZYeijf',0
I = 'FBRLUD'

#     F       R       U
G = [(0, 1), (1, 5), (4, 5),
     (3, 0), (2, 1), (0, 4),
     (2, 3), (6, 2), (1, 0)]
assert len(G) == 9


def Move(o, s, p):  # p = 0..2 = FRU
    print o,s,p
    #z = ~p/2 % -3
    z = [-1, -1, -2, -2, 0, 0][p]
    #print p,z
    #k = 1
    for i,j in G[p::3]:
        #i *= k
        #j *= k
        o[i], o[j] = o[j]-z, o[i]+z
        s[i], s[j] = s[j], s[i]   # pos is side, neg is corner
        #k = -k
    z=99

# N = lambda p: sum([i << i for i in range(4) for j in range(i) if p[j] < p[i]])

def N(p):  # Calc a sum getting bigger if p is sorted. Only first four elements. 0..90
    res = sum([i << i for i in range(4) for j in range(i) if p[j] < p[i]])
    #print p,res
    return res

def Heuristic(i,t,s):

    n = 0
    d = ()

    if i > 4:
        n = N(s[2-i::2] + s[7+i::2]) * 84 + N(s[i & 1::2]) * 6 + divmod(N(s[8:]), 24)[i & 1]

    elif i > 3:
        for j in s:
            l = 'UZifVYje'.find(j)  # corner
            t[l] = i
            d += (l-4,)[l < 4:]
            n += (i+1) << i
            i += l < 4
        n += N([t[j] ^ t[d[3]] for j in d])

    # elif i > 1:  # 8 of 12 sides. Not 'TXdh'
    #     for j in s:
    #         if i % 2 == 0:
    #             n += n + (j in 'EIFJ')
    #         else:
    #             n += n + (j in 'QRab')

    if i == 1:
        for j in t:  # i=1 flipped corners
            n += j % (2+i) + n * (i+1)

    return n

assert 1 + ('A' < 'K') == 2
assert 1 + ('Z' < 'K') == 1
assert 1 + ('A' < 'a') == 2

assert ~-1 == 0
assert ~0 == -1
assert ~1 == -2

assert ~-1 == 0
assert ~0 == -1
assert ~1 == -2


# assert Heuristic(0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], []) == 0
# assert Heuristic(0, [0, 2, 0, 0, 0, 2, 0, 0,-2, 0,-2, 0], []) == 0
# assert Heuristic(0, [0, 0, 1, 0, 0, 0, 1, 0, 0, 0,-1,-1], []) == 547
# assert Heuristic(0, [1, 0, 0, 0, 1, 0, 0, 0, 0,-1,-1, 0], []) == 2182
# assert Heuristic(0, [1, 0, 0, 0, 1, 0, 0, 0,-1, 0, 0,-1], []) == 2185
# assert Heuristic(0, [1, 0, 0, 0, 1, 0, 0, 0,-1,-1, 0, 0], []) == 2188
# assert Heuristic(0, [1, 0, 0, 2, 1, 0, 0, 1,-1,-2, 0,-2], []) == 2200
# assert Heuristic(0, [1, 2, 0, 0, 1, 1, 0, 0,-2,-1,-2, 0], []) == 2244
# assert Heuristic(0, [1, 0, 1, 0, 1, 0, 1, 0,-1,-1,-1,-1], []) == 2735
# assert Heuristic(0, [1, 1, 0, 0, 1, 2, 0, 0,-2,-1,-2, 0], []) == 3204

assert Heuristic(1, [-2, 2, 0, 0, 2, 0, 0,-2], []) == 3700
assert Heuristic(1, [ 0, 0,-2, 2, 0,-2, 2, 0], []) == 420
assert Heuristic(1, [ 0, 2, 0, 2, 0,-2, 0,-2], []) == 1630
assert Heuristic(1, [-2, 0,-2, 0, 2, 0, 2, 0], []) == 2490
assert Heuristic(1, [-2, 2,-2, 2, 2,-2, 2,-2], []) == 4120
assert Heuristic(1, [ 2, 0, 0,-2, 2, 0, 0,-2], []) == 4510
assert Heuristic(1, [ 0, 0,-2, 2, 2, 0, 0,-2], []) == 460
assert Heuristic(1, [ 0,-2, 2, 0, 2, 0, 0,-2], []) == 1270
assert Heuristic(1, [-2, 2, 0, 0, 0, 0,-2, 2], []) == 3650

def Search(i,m,t,s,l=''):
    for j in i-1, i:
        if T[j][Heuristic(j,t,s)] < m:
            return
    if m >= 0:
        print l
        return t,s
    for p in range(6):  # six faces
        u = t[:]
        v = s[:]
        for n in 1,2,3:  # one, two and three turns
            Move(u,v,p)
            r = p < n % 2 * i or Search(i, m + 1, u, v, l + I[p] + str(n))
            if r > 1:
                return r

# assert N('abcd') == 90 # 24+24+24+8+8+2
# assert N('bacd') == 88
# assert N('acbd') == 82 # 24+24+24+8  +2
# assert N('cabd') == 80
# assert N('bcad') == 74
# assert N('cbad') == 72
# assert N('abdc') == 66 # 24+24   +8+8+2
# assert N('badc') == 64
# assert N('adbc') == 58
# assert N('dabc') == 56
# assert N('bdac') == 50
# assert N('dbac') == 48
# assert N('acdb') == 42
# assert N('cadb') == 40
# assert N('adcb') == 34
# assert N('dacb') == 32
# assert N('cdab') == 26
# assert N('dcab') == 24
# assert N('bcda') == 18
# assert N('cbda') == 16
# assert N('bdca') == 10
# assert N('dbca') == 8
# assert N('cdba') == 2
# assert N('dcba') == 0

s = 'LDF LBD FUL RFD UFR RDB UBL RBU'.split()
o = [0 + (-(p[-1] in 'UD') or p[0] in 'RL' or p[1] in 'UD') for p in s]
s = [chr(64+sum(1 << I.find(a) for a in x)) for x in s]

for i in range(7):
    m = 0
    C = {}
    T.append(C)
    x = [S]
    for j, k, d in x:
        h = Heuristic(i, j, k)
        print i,j,k,h
        for p in range(C.get(h,3)):
            C[h] = d
            u = j[:]
            v = list(k)
            for n in i,0,i:
                Move(u,v,p)
                x += [(u[:], v[:], d-1)] * (p | 1 > n)
    if i % 2 == 0:
        while [] > d:
            d = Search(i, m, o, s)
            m -= 1
        o, s = d

# F3R1U3D3B1
# F2R1F2R3F2U1R1L1
# R2U3F2U3F2U1R2U3R2U1
# F2L2B2R2U2L2D2L2F2

# fRudB       # B1=B D1=D F1=F L1=L R1=R U1=U
# gRgrgURL    # B2=c D2=e F2=g L2=m R2=s U2=v
# sugugUsusU  # B3=b D3=d F3=f L3=l R3=r U3=u
# gmcsvmemg
