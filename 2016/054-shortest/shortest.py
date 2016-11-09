class Solver:

  def expand(self, a, b):
    if not b in self.tree:
      self.tree[b] = a
      self.front.append(b)

  def solution(self, target):
    res = []
    while target != 0:
      res.append(target)
      target = self.tree[target]
    return res

  def solve(self, start, target):
    fr = [start]
    self.tree = {start: 0}
    while not target in fr:
      self.front = []
      for f in fr:
        self.expand(f,f+2)
        self.expand(f,f*2)
        if f%2 == 0: self.expand(f,f/2)
      fr = self.front[:]
    return self.solution(target)[::-1]

solver = Solver()
assert solver.solve(3,2) == [3, 6, 8, 4, 2]
assert solver.tree == {2: 4, 3: 0, 4: 8, 5: 3, 6: 3, 7: 5, 8: 6, 9: 7, 10: 5, 11: 9, 12: 6, 14: 7, 16: 8, 18: 9, 20: 10, 22: 20, 24: 12, 26: 24, 28: 14, 32: 16, 40: 20, 48: 24}
assert solver.solve(30,20) == [30, 32, 16, 18, 20]
assert len(solver.tree) == 40
assert solver.solve(300,200) == [300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200]
assert len(solver.tree) == 1441
assert solver.solve(600,400) == [600, 300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200, 400]
assert len(solver.tree) == 3836
#assert solver.solve(1200,800) == [1200, 600, 300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200, 400, 800]
#assert len(solver.c) == 10150
#assert solver.solve(2400,1600) == [2400, 1200, 600, 300, 150, 152, 76, 38, 19, 21, 23, 25, 50, 100, 200, 400, 800, 1600]
#assert len(solver.c) == 26758
