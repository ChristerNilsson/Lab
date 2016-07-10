# -*- coding: utf-8 -*-

from symcalc import RPN

def ass(a,b):
    res = calc.rpn(a)
    if res != b:
        print res
        print b
#        assert res == b


calc = RPN()
#calc.run()

# Genomgång av boken "Ellips 2"

# 1.1:2
ass('[-7,0,5,-2] polynom','-2*x**3 + 5*x**2 - 7')
ass('[-7,0,5,-2] polynom chs','2*x**3 - 5*x**2 + 7')

# 1.1:3
ass('[-1,0,4/9] polynom P=','4*x**2/9 - 1')
ass('P 6 xeval','15')
ass('P -3/2 xeval','0')
ass('P 3 sqrt 2 / xeval','-2/3')

# 1.1:4
ass('[3,-1] polynom P=','-x + 3')
ass('P -a xeval','a + 3')
ass('P 1-x xeval','x + 2')
ass('2 P * 3 P x 2 - xeval * -','x - 9')

# 1.1:5
ass('x sq y sq - P=', 'x**2 - y**2')
ass('P 3 xeval y -2 eval', '5')

# 102
ass('[1,0,-3,0,0,-4] polynom P=','-4*x**5 - 3*x**2 + 1')
ass('P chs', '4*x**5 + 3*x**2 - 1')
ass('P -2 xeval', '117')

# 103 trivialt
# 104
ass('[4,-2] polynom P=','-2*x + 4')
ass('P -t xeval','2*t + 4')

# 1.2:1 Addition och subtraktion av polynom
ass('[3,-2,1] polynom P=','x**2 - 2*x + 3')
ass('[3,2,-2] polynom Q=','-2*x**2 + 2*x + 3')
ass('P Q +','-x**2 + 6')
ass('P Q -','3*x**2 - 4*x')

# 1.2:2 Multiplikation av polynom
ass('[0,0,0,6] polynom P=','6*x**3')
ass('[0,0,0,0,0,0,-3] polynom Q=','-3*x**6')
ass('P Q *','-18*x**9')

# 1.2:5b Multiplikation av polynom
ass('[2,-3] polynom P=','-3*x + 2')
ass('P P * t xeval','(-3*t + 2)**2')

# 1.2:6a
ass('9*x*(x-1)*(x+1) P=','9*x*(x - 1)*(x + 1)')
ass('P 1/3 xeval','-8/3')

# 107
ass('9*a+3*b-5*a','4*a + 3*b')
ass('3*x*y**2-7*x*y**2+2*y**2*x+3*x**2*y','3*x**2*y - 2*x*y**2')

# 118
ass('-(1-x)*(-x*x+1)-x*(-x*x+2*x+1) simplify P=','-x**2 - 1')
ass('P 0 xeval','-1')
ass('P -sqrt(7) xeval','-8')

# 119c
ass('[2,0,-3,0,1] polynom P=','x**4 - 3*x**2 + 2')
ass('[1,0,-1,0,-1] polynom Q=','-x**4 - x**2 + 1')
ass('P -x xeval chs x**4 Q -1 xeval * -','3*x**2 - 2')

# 1.3
ass('(a+b)*(a-b) expand','a**2 - b**2')
ass('(a+b)*(a+b) expand','a**2 + 2*a*b + b**2')
ass('(a-b)*(a-b) expand','a**2 - 2*a*b + b**2')

# 1.3:2c
ass('(1-x)**2-(x-1)**2 simplify','0')

# 1.3:4
ass('16 x 4 / 1 + sq * 4 x 2 inv - sq * - expand','-3*x**2 + 12*x + 15')

# 1.3:8
ass('x*sqrt(2)-1-sqrt(3)*x xsolve','[1/(-sqrt(3) + sqrt(2))]')

# 1.3:9
ass('(a-10)*(a+10) a*a - simplify','-100')

# 124c
ass('(-a*b**2+1)*(1+a*b**2) simplify','-a**2*b**4 + 1')

# 128c
ass('(a*a+2)**2 expand','a**4 + 4*a**2 + 4')

# 153
ass('(2*x-1+2)*2*(2*x+1)-2*(2*x+1) expand A=','8*x**2 + 4*x')
ass('A 30 xeval','7320')

# 154
ass('2*x sq x sq + sqrt h=','sqrt(5)*sqrt(x**2)')
ass('h sq 2*x x * 2 / + A=','6*x**2')
ass('A 30 xeval','5400')

# 169
ass('2**(2*x)+1 2**x+1 2**x-1 * * expand','2**(4*x) - 1')

# 1.4:1
ass('x**3+x**2 factor','x**2*(x + 1)')

# 1.4:2
ass('x**2-9 factor','(x - 3)*(x + 3)')

calc.run()

