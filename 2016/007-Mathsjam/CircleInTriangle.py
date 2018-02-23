# Krävs Sympy 1.0 for att fungera
# 1.1.1 Kraschade

from sympy import Point,Line,Circle,intersection,Triangle,N
import time

p1 = Point(0,8)
p0 = Point(0,2)
X = Line(Point(0,0),Point(1,0))
c0 = Circle(p0,2)
l0 = c0.tangent_lines(p1)[0]
p2 = intersection(l0, X)[0]
l2 = Line(p2, p0)

def findCircle(circle):
	p3 = intersection(circle, l2)[0] # Kraschar här.
	l3 = l2.perpendicular_line(p3)
	p5 = intersection(l3, l0)[0]
	p6 = intersection(l3, X)[0]
	t1 = Triangle(p5, p2, p6)
	return t1.incircle

circle = c0
for i in range(5):
	start = time.time()
	circle = findCircle(circle)
	r = circle.radius
	print()
	print(r)
	print(i,time.time()-start, N(r))
