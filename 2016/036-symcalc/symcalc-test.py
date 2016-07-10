# -*- coding: utf-8 -*-

from symcalc import RPN,N

calc = RPN()
#calc.run()

# op0
assert calc.rpn('x') == 'x'
assert calc.rpn('y') == 'y'
assert calc.rpn('z') == 'z'
assert calc.rpn('oo') == 'oo'
assert calc.rpn('inf') == 'oo'
assert calc.rpn('infinity') == 'oo'

# op1
assert calc.rpn('0 sin') == '0'
assert calc.rpn('pi/2 sin') == '1'
assert calc.rpn('pi sin') == '0'
assert calc.rpn('3*pi/2 sin') == '-1'

assert calc.rpn('0 radians sin') == '0'
assert calc.rpn('90 radians sin') == '1'
assert calc.rpn('180 radians sin') == '0'
assert calc.rpn('270 radians sin') == '-1'

assert calc.rpn('x sin') == 'sin(x)'
assert calc.rpn('x cos') == 'cos(x)'
assert calc.rpn('x tan') == 'tan(x)'
assert calc.rpn('x sq') == 'x**2'
assert calc.rpn('x sqrt') == 'sqrt(x)'
assert calc.rpn('x log') == 'log(x)'
assert calc.rpn('x ln') == 'log(x)'
assert calc.rpn('x exp') == 'exp(x)'
assert calc.rpn('x cos sq x sin sq +') == 'sin(x)**2 + cos(x)**2'
assert calc.rpn('x cos sq x sin sq + simplify') == '1'
assert calc.rpn('[1,2,3]') == '[1, 2, 3]'
assert calc.rpn('[1,2,3] polynom') == '3*x**2 + 2*x + 1'
assert calc.rpn('x inv') == '1/x'
assert calc.rpn('x chs') == '-x'
assert calc.rpn('x 1 + x 2 + *') == '(x + 1)*(x + 2)'
assert calc.rpn('x 1 + x 2 + * expand') == 'x**2 + 3*x + 2'
assert calc.rpn('x**2 xdiff') == '2*x'
assert calc.rpn('x*y**2 ydiff') == '2*x*y'
assert calc.rpn('x**2 xint') == 'x**3/3'
assert calc.rpn('x**2-1 xsolve') == '[-1, 1]'
assert calc.rpn('x**4-1 xsolve') == '[-1, 1, -I, I]'
assert calc.rpn('1/((x+2)*(x+1)) xapart') == '-1/(x + 2) + 1/(x + 1)'
assert calc.rpn('-1/(x+2)+1/(x+1) xtogether') == '1/((x + 1)*(x + 2))'
assert calc.rpn('0 0 point 3 circle center') == 'Point2D(0, 0)'
assert calc.rpn('0 0 point 3 circle radius') == '3'
assert calc.rpn('0 0 point 0 1 point 1 0 point triangle incircle') == 'Circle(Point2D(-sqrt(2)/2 + 1, -sqrt(2)/2 + 1), -sqrt(2)/2 + 1)'

# op2
assert calc.rpn('x x +') == '2*x'
assert calc.rpn('2 3 -') == '-1'
assert calc.rpn('x x *') == 'x**2'
assert calc.rpn('2 3 /') == '2/3'
assert calc.rpn('x**2 x diff') == '2*x'
assert calc.rpn('x**2 x int') == 'x**3/3'
assert calc.rpn('x**4-1 x solve') == '[-1, 1, -I, I]'
assert calc.rpn('[x+y-4,x-y+2] [x,y] solve') == '{x: 1, y: 3}'
assert calc.rpn('x**3 3 xeval') == '27'
assert calc.rpn('[11,12,13] 0 item') == '11'
assert calc.rpn('1 2 point') == 'Point2D(1, 2)'
assert calc.rpn('1 2 point 3 4 point line') == 'Line(Point2D(1, 2), Point2D(3, 4))'
assert calc.rpn('1 2 point 3 circle') == 'Circle(Point2D(1, 2), 3)'
assert calc.rpn('0 0 point 1 circle 0 2 point tangent_lines') == '[Line(Point2D(0, 2), Point2D(-sqrt(3)/2, 1/2)), Line(Point2D(0, 2), Point2D(sqrt(3)/2, 1/2))]'
assert calc.rpn('-1 -1 point 1 1 point line 1 -1 point -1 1 point line intersection') == '[Point2D(0, 0)]'
assert calc.rpn('0 0 point 1 circle 0 0 point 1 1 point line intersection') == '[Point2D(-sqrt(2)/2, -sqrt(2)/2), Point2D(sqrt(2)/2, sqrt(2)/2)]'
assert calc.rpn('0 0 point 1 1 point line 3 4 point perpendicular_line') == 'Line(Point2D(3, 4), Point2D(4, 3))'
assert calc.rpn('x**2 x diff') == '2*x'
assert calc.rpn('x**2 x int') == 'x**3/3'
assert calc.rpn('1/((x+2)*(x+1)) x apart') == '-1/(x + 2) + 1/(x + 1)'
assert calc.rpn('-1/(x+2)+1/(x+1) x together') == '1/((x + 1)*(x + 2))'

# op3
assert calc.rpn('x**3 x 3 eval') == '27'
assert calc.rpn('0 0 point 0 1 point 1 0 point triangle') == 'Triangle(Point2D(1, 0), Point2D(0, 1), Point2D(0, 0))'
assert calc.rpn('x sin x / x 0 limit') == '1'
assert calc.rpn('limit(sin(x)/x,x,0)') == '1'

# op4
assert calc.rpn('Sum(1/x**2,(x,1,oo)).doit()') == 'pi**2/6'
assert calc.rpn('1 x x * / x 1 oo sum') == 'pi**2/6'

# misc
calc.rpn('2 5 * clr')
assert calc.stack == []

calc.rpn('12 dup')
assert calc.stack == [12, 12]

calc.rpn('12 13 drp')
assert calc.stack == [12]

calc.rpn('12 13 swp')
assert calc.stack == [13, 12]

calc.rpn('2*x f=')
assert calc.rpn('f') == '2*x'
calc.rpn('x-1 g=')
assert calc.rpn('g') == 'x - 1'

assert calc.rpn('f g +') == '3*x - 1'
assert calc.rpn('f g *') == '2*x*(x - 1)'
assert calc.rpn('f g xeval') == '2*x - 2'  # f o g
assert calc.rpn('g f xeval') == '2*x - 1'  # g o f

################################################### Geometry: intersection

# intersection: Circle,Circle -> Circle
# intersection: Circle,Circle -> [Point2D]
assert calc.rpn('0 0 point 1 circle 0 0 point 1 circle intersection') == 'Circle(Point2D(0, 0), 1)'
assert calc.rpn('0 0 point 1 circle 1 0 point 1 circle intersection') == '[Point2D(1/2, -sqrt(3)/2), Point2D(1/2, sqrt(3)/2)]'
assert calc.rpn('0 0 point 1 circle 2 0 point 1 circle intersection') == '[Point2D(1, 0)]'
assert calc.rpn('0 0 point 1 circle 3 0 point 1 circle intersection') == '[]'

# intersection: Line,Line -> [Line]
# intersection: Line,Line -> [Point2D]
assert calc.rpn('0 0 point 1 0 point line 0 0 point 1 0 point line intersection') == '[Line(Point2D(0, 0), Point2D(1, 0))]'
assert calc.rpn('0 0 point 1 0 point line 0 0 point 0 1 point line intersection') == '[Point2D(0, 0)]'
assert calc.rpn('0 0 point 1 0 point line 0 1 point 1 1 point line intersection') == '[]'

# intersection: Circle,Line -> [Point]
assert calc.rpn('0 0 point 1 circle 0 0 point 1 0 point line intersection') == '[Point2D(-1, 0), Point2D(1, 0)]'
assert calc.rpn('0 0 point 1 circle 0 1 point 1 1 point line intersection') == '[Point2D(0, 1)]'
assert calc.rpn('0 0 point 1 circle 0 2 point 1 2 point line intersection') == '[]'

# intersection: Triangle,Line -> [Point]
# intersection: Triangle,Line -> [Segment]
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle 0 0 point 1 1 point line intersection') == '[Point2D(1/2, 1/2), Point2D(0, 0)]'
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle 0 0 point -1 1 point line intersection') == '[Point2D(0, 0)]'
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle 1 0 point 0 1 point line intersection') == '[Segment(Point2D(0, 1), Point2D(1, 0)), Point2D(1, 0), Point2D(0, 1)]'
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle 0 2 point 2 0 point line intersection') == '[]'

# intersection: Triangle,Circle -> [Point]
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle 0 0 point 1/2 circle intersection') == '[Point2D(1/2, 0), Point2D(0, 1/2)]'
assert calc.rpn('-2 -1 point 2 -1 point 0 3 point triangle 0 0 point 2 circle intersection') == '[Point2D(-sqrt(11)/5 + 6/5, 3/5 + 2*sqrt(11)/5), Point2D(sqrt(11)/5 + 6/5, -2*sqrt(11)/5 + 3/5), Point2D(-sqrt(3), -1), Point2D(sqrt(3), -1), Point2D(-6/5 - sqrt(11)/5, -2*sqrt(11)/5 + 3/5), Point2D(-6/5 + sqrt(11)/5, 3/5 + 2*sqrt(11)/5)]'

# intersection: Triangle,Triangle -> [Point] (judisk stjärna)
assert calc.rpn('0 2 point 2 -1 point -2 -1 point triangle 2 1 point 0 -2 point -2 1 point triangle intersection') == '[Point2D(-2/3, -1), Point2D(-4/3, 0), Point2D(2/3, -1), Point2D(4/3, 0), Point2D(2/3, 1), Point2D(-2/3, 1)]'

################################################### Geometry: tangent_lines

# tangent_lines: Circle,Point -> [Line]
assert calc.rpn('0 0 point 1 circle 0 2 point tangent_lines') == '[Line(Point2D(0, 2), Point2D(-sqrt(3)/2, 1/2)), Line(Point2D(0, 2), Point2D(sqrt(3)/2, 1/2))]'
assert calc.rpn('0 0 point 1 circle 0 1 point tangent_lines') == '[Line(Point2D(0, 1), Point2D(1, 1))]'
assert calc.rpn('0 0 point 1 circle 0 1/2 point tangent_lines') == '[]'

################################################### Geometry: Misc

# perpendicular_line: Line,Point -> Line
assert calc.rpn('0 0 point 1 1 point line 3 4 point perpendicular_line') == 'Line(Point2D(3, 4), Point2D(4, 3))'
assert calc.rpn('0 0 point 1 1 point line 1/2 1/2 point perpendicular_line') == 'Line(Point2D(1/2, 1/2), Point2D(3/2, -1/2))'

# incircle: Triangle -> Circle
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle incircle') == 'Circle(Point2D(-sqrt(2)/2 + 1, -sqrt(2)/2 + 1), -1 + sqrt(2)/2)'
assert calc.rpn('0 0 point 1 0 point 0 1 point triangle circumcircle') == 'Circle(Point2D(1/2, 1/2), sqrt(2)/2)'


###################################################
assert calc.rpn('0 0 point 1 0 point line xaxis=') == 'Line(Point2D(0, 0), Point2D(1, 0))'

assert calc.rpn('0 8 point B=') == 'Point2D(0, 8)'
assert calc.rpn('0 2 point A=') == 'Point2D(0, 2)'
assert calc.rpn('A 2 circle C1=') == 'Circle(Point2D(0, 2), 2)'
assert calc.rpn('C1 B tangent_lines 0 item BC=') == 'Line(Point2D(0, 8), Point2D(-4*sqrt(2)/3, 8/3))'
assert calc.rpn('C1 BC intersection 0 item C=') == 'Point2D(-4*sqrt(2)/3, 8/3)'
assert calc.rpn('xaxis BC intersection 0 item D=') == 'Point2D(-2*sqrt(2), 0)'
assert calc.rpn('D A line DA=') == 'Line(Point2D(-2*sqrt(2), 0), Point2D(0, 2))'
assert calc.rpn('C1 DA intersection 0 item E=') == 'Point2D(-2*sqrt(6)/3, -2*sqrt(3)/3 + 2)'
assert calc.rpn('DA E perpendicular_line GH=') == 'Line(Point2D(-2*sqrt(6)/3, -2*sqrt(3)/3 + 2), Point2D(-2*sqrt(6)/3 + 2, -2*sqrt(2) - 2*sqrt(3)/3 + 2))'
assert calc.rpn('GH D B line intersection 0 item G=') == 'Point2D(-sqrt(2) - sqrt(6)/3, -4*sqrt(3)/3 + 4)'
assert calc.rpn('GH xaxis intersection 0 item H=') == 'Point2D(-sqrt(6) + sqrt(2), 0)'
assert calc.rpn('G D H triangle DGH=') == 'Triangle(Point2D(-sqrt(6) + sqrt(2), 0), Point2D(-2*sqrt(2), 0), Point2D(-sqrt(2) - sqrt(6)/3, -4*sqrt(3)/3 + 4))'
assert calc.rpn('DGH incircle C2=') == 'Circle(Point2D(-2*sqrt(6) + 2*sqrt(2), -2*sqrt(3) + 4), -4 + 2*sqrt(3))'
assert calc.rpn('C2 center I=') == 'Point2D(-2*sqrt(6) + 2*sqrt(2), -2*sqrt(3) + 4)'
assert calc.rpn('C2 radius') == '-4 + 2*sqrt(3)'
assert calc.rpn('C2 radius N') == '-0.535898384862245'

calc.rpn('defs')

calc.run()