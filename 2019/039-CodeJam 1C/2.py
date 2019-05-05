'''
'''
print(2)

def solve(r, c):
  t = [[0]*c for _ in range(r)]
  return 2

for t in range(int(input())):
  print('Case #%d: ' % (t+1), end='')
  r, c = map(int, input().split())
  res = solve(r, c)
  if res:
    print('POSSIBLE')
    ans = [None]*(r*c)
    for i in range(r):
      for j in range(c):
        ans[res[i][j]-1] = (i, j)
    for x, y in ans:
      print(x+1, y+1)
  else:
    print('IMPOSSIBLE')
