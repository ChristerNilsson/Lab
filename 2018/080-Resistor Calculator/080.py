class Resistance:
	def __init__(self, r): self.r = r
	def __add__(self, other): return Resistance(self.r + other.r)
	def __mul__(self, other): return Resistance(1/(1/self.r + 1/other.r))

r1 = Resistance(6)
r2 = Resistance(8)
r3 = Resistance(4)
r4 = Resistance(8)
r5 = Resistance(4)
r6 = Resistance(6)
r7 = Resistance(8)
r8 = Resistance(10)
r9 = Resistance(6)
r10 = Resistance(2)

r = ((((r8+r10)*r9+r7)*r6+r5)*r4+r3)*r2+r1
print(r.r)

################################

def p(a,b): return 1/(1/a + 1/b)

r1 = 6
r2 = 8
r3 = 4
r4 = 8
r5 = 4
r6 = 6
r7 = 8
r8 = 10
r9 = 6
r10 = 2

r = p(p(p(p(r8+r10,r9)+r7,r6)+r5,r4)+r3,r2)+r1
print(r)

################################ RPN

# 10 2 + 6 p 8 + 6 p 4 + 8 p 4 + 8 p 6 +

