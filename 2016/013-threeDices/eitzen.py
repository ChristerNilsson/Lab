# The winner.
# https://www.youtube.com/watch?v=hBBftD7gq7Y
# https://www.youtube.com/watch?v=vRSkHaDhM7s


def xcalc(a,b,c):
    a,b,c = sorted([a,b,c])
    diff = [b-a,c-b]
    x,y = diff
    if x == 0 and y == 0: return [6,3]  # ALL SAME
    if x == 0 or y == 0: return [a,c]  # TWO SAME
    if diff == [1,4]: return [a,a] # CONSECUTIVE
    if diff == [1,1]: return [b,b]
    if diff == [4,1]: return [c,c]
    if diff == [2,2]: return [a+3,a]  # EQUILATERAL
    if y == 3: return [b,a] # RIGHT TRIANGLE
    if x == 3: return [c,a]
    return [c,b]


def ycalc(a,b,c):
    a,b,c = sorted([a,b,c])
    return [[6,3],[a,c],[b,b],[c,b],[b,a],[a,a],[c,a],[c,c],[a+3,a]][[[0,1,1,1,1,1],[1,2,3,4,5],[1,3,8,4],[1,6,6],[1,7],[1]][b-a][c-b]]

def calc(a,b,c): # @tarim8 correct tweet. Not the one in the video
    a,b,c = sorted([a,b,c])
    s=a+b+c
    d=[b-a,c-b]
    x,y=d
    if d==[0,0]: return [6,6]
    if x==0 or y==0: return [a,c]
    if x==1: return [c,a]
    if y==1:
        if [s-8,s-9] == [0,-1]: return [1,1]
        return [s-8,s-9]
    return [s-7,s-7]

# def calc(a,b,c):
#     a,b,c = sorted([a,b,c])
#     s=a+b+c
#     d=[b-a,c-b]
#     x,y=d
#     ai = [[0,1,1,1,1,1],[1,2,2,2,2],[1,3,4,4],[1,3,4],[1,3],[1]]
#     bi = [[6,6],[a,c],[c,a],[s-8,s-9],[s-7,s-7],[1,1]]
#     res = bi[ai[x][y]]
#     if res == [0,-1]:
#         print [1,1],
#         return [1,1]
#     return res


# assert calc(1,1,1) == [6,3]  # ALL SAME
# assert calc(2,2,2) == [6,3]
# assert calc(3,3,3) == [6,3]
# assert calc(4,4,4) == [6,3]
# assert calc(5,5,5) == [6,3]
# assert calc(6,6,6) == [6,3]
#
# assert calc(1,1,2) == [1,2]  # TWO SAME
# assert calc(1,1,3) == [1,3]
# assert calc(1,1,4) == [1,4]
# assert calc(1,1,5) == [1,5]
# assert calc(1,1,6) == [1,6]
# assert calc(1,6,6) == [1,6]
# assert calc(2,2,3) == [2,3]
# assert calc(2,2,4) == [2,4]
# assert calc(2,2,5) == [2,5]
# assert calc(2,2,6) == [2,6]
# assert calc(2,3,3) == [2,3]
# assert calc(2,4,4) == [2,4]
# assert calc(2,5,5) == [2,5]
# assert calc(2,6,6) == [2,6]
# assert calc(3,3,4) == [3,4]
# assert calc(3,3,5) == [3,5]
# assert calc(3,3,6) == [3,6]
# assert calc(3,4,4) == [3,4]
# assert calc(3,5,5) == [3,5]
# assert calc(3,6,6) == [3,6]
# assert calc(4,4,5) == [4,5]
# assert calc(4,4,6) == [4,6]
# assert calc(4,5,5) == [4,5]
# assert calc(4,6,6) == [4,6]
# assert calc(5,5,6) == [5,6]
# assert calc(5,6,6) == [5,6]
#
# assert calc(1,2,6) == [1,1]  # CONSECUTIVE
# assert calc(1,2,3) == [2,2]
# assert calc(2,3,4) == [3,3]
# assert calc(3,4,5) == [4,4]
# assert calc(4,5,6) == [5,5]
# assert calc(1,5,6) == [6,6]
#
# assert calc(1,3,5) == [4,1]  # EQUILATERAL
# assert calc(2,4,6) == [5,2]
#
# assert calc(1,2,5) == [2,1]  # RIGHT TRIANGLE c-b==3 [b,a]
# assert calc(1,3,6) == [3,1]
# assert calc(2,3,6) == [3,2]
# assert calc(1,4,5) == [5,1]  # RIGHT TRIANGLE b-a==3 [c,a]
# assert calc(1,4,6) == [6,1]
# assert calc(2,5,6) == [6,2]
# assert calc(1,2,4) == [4,2]  # RIGHT TRIANGLE [c,b]
# assert calc(1,3,4) == [4,3]
# assert calc(2,3,5) == [5,3]
# assert calc(2,4,5) == [5,4]
# assert calc(3,4,6) == [6,4]
# assert calc(3,5,6) == [6,5]

stat = []
for i in range(6):
    stat.append([0,0,0,0,0,0])
for a in range(6):
    for b in range(6):
        for c in range(6):
            i,j = calc(a+1,b+1,c+1)
            print a+1,b+1,c+1,i,j
            stat[i-1][j-1] += 1
for i in range(6):
    print stat[i] #== [6,6,6,6,6,6]