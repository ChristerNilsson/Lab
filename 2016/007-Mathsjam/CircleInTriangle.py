from sympy import Point,Line,Circle,intersection,Triangle,N
from svg import Svg

C = Point(0,8)
D = Point(0,2)
xaxis = Line(Point(0,0),Point(1,0))
CircleD = Circle(D,2)
tangentE = CircleD.tangent_lines(C)[0]
E = intersection(tangentE,CircleD)[0]
A = intersection(tangentE, xaxis)[0]
CircleD = Circle(D,2)

svg = Svg()
svg.append(C,"C")
#svg.append(D)
svg.append(CircleD,"CircleD")
svg.append(tangentE,"tangE")
svg.append(E,"E")
svg.append(A,"A")

def find_circle(circle,A,C,D,i):
    AD = Line(A,D)
    svg.append(AD,"AD",i)
    K = intersection(circle, AD)[0]
    svg.append(K,"K",i)
    tangentK = Line(A,D).perpendicular_line(K)
    svg.append(tangentK,"tangK",i)
    P1 = intersection(tangentK, Line(A,C))[0]
    svg.append(P1,"P1",i)
    P2 = intersection(tangentK, xaxis)[0]
    svg.append(P2,"P2",i)
    T = Triangle(P1,A,P2)
    svg.append(T,"T",i)
    return T.incircle

circle = CircleD

for i in range(1):
    circle = find_circle(circle,A,C,D,i)
    svg.append(circle,"circle",i)

svg.close()