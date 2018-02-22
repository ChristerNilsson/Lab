from sympy import Point,Line,Circle,intersection,Triangle,N

p1 = Point(0,8)
p0 = Point(0,2)
X = Line(Point(0,0),Point(1,0))
c0 = Circle(p0,2)
l0 = c0.tangent_lines(p1)[0]
p2 = intersection(l0, X)[0]
l2 = Line(p2, p0)
print('l2',l2)

print("")
p3 = intersection(c0, l2)[0]
print('p3',p3)
l3 = l2.perpendicular_line(p3)
print('l3',l3)
p5 = intersection(l3, l0)[0]
print('p5',p5)
p6 = intersection(l3, X)[0]
print('p6',p6)
t0 = Triangle(p5,p2,p6)
print('t0',t0)
c1 = t0.incircle
print('c1',c1)
print(N(c1.center.x), N(c1.center.y), N(c1.radius))

print("")
p13 = intersection(c1, l2)[0] # Kraschar här. Detta har fungerat forut.
print(p13)
# l13 = l2.perpendicular_line(p13)
# print(l13)
# p15 = intersection(l13, l0)[0]
# print(p15)
# p16 = intersection(l13, X)[0]
# print(p16)
# t1 = Triangle(p15, p2, p16)
# print(t1)
# c11 = t1.incircle

