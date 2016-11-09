from collections import deque

# start from start and target and meet in the middle.
# This will execute a lot faster and handle larger problems

def solve(start,target):
    def path(a): return [] if a == 0 else path(tree[a]) + [a]
    def expand(a,b):
        if not b in tree:
            q.append(b)
            tree[b] = a
            return b == target
    tree = {start: 0}
    q = deque([start])
    while True:
        a = q.popleft()
        if expand(a, a+2): break
        if expand(a, a*2): break
        if a%2 == 0 and expand(a, a/2): break
    return path(target)

assert solve(3,2) == [3, 6, 8, 4, 2]
assert solve(30,20) == [30, 32, 16, 18, 20]
assert solve(300,200) == [300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200]
assert solve(3000,2000) == [3000, 1500, 750, 752, 376, 188, 94, 96, 48, 50, 25, 27, 29, 31, 62, 124, 248, 250, 500, 1000, 2000]


