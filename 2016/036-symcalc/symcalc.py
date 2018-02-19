# -*- coding: utf-8 -*-

# En symbolisk RPN kalkylator byggd på sympy av Christer Nilsson

# Översikt:
# Hanterar de fem räknesätten.
# Alla heltal lagras som Bignums, dvs oändligt antal siffror.
# Bråktal hanteras och förenklas automatiskt
#
# Funktioner kan deriveras och integreras
# Oändliga serier kan beräknas
# Trigonometriska och logaritmiska funktioner hanteras
# Komplexa tal hanteras.
#
# Ekvationer kan lösas med "solve"
#
# Geometriska funktioner finns. T ex point, line, circle, triangle, intersection, perpendicular_line, incircle
#
# Numeriska värden kan enkelt visas. Funktioners värden kan enkelt beräknas.

# Hanterar både infix och RPN: "x+1 y+2" eller "x 1 + y 2 +". Notera mellanslagens signifikans.
# Komplexa tal: Använd I istf i. "I*I" och "I I *" ger både värdet -1.
# Hjälp erhålls med "?"
# Övriga kommandon: clr, dup, drp, swp, defs
# Uttryck kan sparas med t ex "f=". Hämtas med t ex "f".
# Se asserts i slutet för exempel.
# Tom rad byter mellan symbolisk och numerisk visning
# Förutom ovan listade kommandon har man tillgång till allt i sympy. Se t ex limit och Sum bland exemplen.

from sympy.simplify import simplify
from sympy.solvers import solve
from sympy.geometry import Line,Point,Point2D,intersection
from sympy.core import pi,symbols,Symbol,S,N
from sympy.functions import sqrt,acos,log,ln,sin,cos,tan,exp
from sympy import Circle,Triangle,N,apart,together,Sum,limit,ring
import time

class RPN:
    def __init__(self):
        self.s,self.t,self.x,self.y,self.z = symbols('s,t,x,y,z')
        self.stack = []
        self.defs = {}
        self.mode = 0
        self.hist = [('',[])] # Innehåller en lista med (kommandorad, stack)
        self.lastx = ''
        self.clear = True

        self.op0 = {
            's': lambda : self.s,
            't': lambda : self.t,
            'x': lambda : self.x,
            'y': lambda : self.y,
            'z': lambda : self.z,
            'oo': lambda : S('oo'),
            'inf': lambda : S('oo'),
            'infinity': lambda : S('oo'),
            '?': lambda : self.help(),
            'help': lambda : self.help(),
            'hist': lambda : self.history(),
            'history': lambda : self.history(),
            'sketch': lambda : self.sketch(),
        }

        self.op1 = {
            'radians': lambda x : pi/180*x,
            'sin': lambda x : sin(x),
            'cos': lambda x : cos(x),
            'tan': lambda x : tan(x),
            'sq':  lambda x : x ** 2,
            'sqrt':  lambda x : sqrt(x),
            'ln':  lambda x : ln(x),
            'exp':  lambda x : exp(x),
            'log':  lambda x : log(x),
            'simplify': lambda x : simplify(x),
            'polynom': lambda x : self.polynom(x),
            'inv': lambda x : 1/x,
            'chs': lambda x : -x,
            'center': lambda x : x.center,
            'radius': lambda x : x.radius,
            'expand': lambda x : x.expand(),
            'factor': lambda x : x.factor(),
            'incircle': lambda x : x.incircle,
            'circumcircle': lambda x : x.circumcircle,
            'xdiff':  lambda x : x.diff(self.x),
            'ydiff': lambda x : x.diff(self.y),
            'xint': lambda x : x.integrate(self.x),
            'xsolve': lambda x : solve(x,self.x),
            'xapart': lambda x : apart(x,self.x),
            'xtogether': lambda x : together(x,self.x),
            'N': lambda x : N(x),
            'info': lambda x : [x.__class__.__name__, [m for m in dir(x) if m[0]!= '_']],
        }
        self.op2 = {
            '+': lambda x,y : y+x,
            '-': lambda x,y : y-x,
            '*': lambda x,y : y*x,
            '/': lambda x,y : y/x,
            '**': lambda x,y : y**x,
            'item': lambda x,y : y[x],
            'point': lambda x,y : Point(y,x),
            'line': lambda x,y : Line(y,x),
            'circle': lambda x,y : Circle(y,x),
            'tangent_lines': lambda x,y : y.tangent_lines(x),
            'intersection': lambda x,y : intersection(x,y),
            'perpendicular_line': lambda x,y : y.perpendicular_line(x),
            'diff':  lambda x,y : y.diff(x),
            'int': lambda x,y : y.integrate(x),
            'solve': lambda x,y : solve(y,x),
            'apart': lambda x,y : apart(y,x),
            'together': lambda x,y : together(y,x),
            'xeval': lambda x,y : y.subs(self.x,x),
        }
        self.op3 = {
            'triangle': lambda x,y,z : Triangle(x,y,z),
            'limit': lambda x,y,z : limit(z,y,x),  # limit(sin(x)/x,x,0) <=> x sin x / x 0 limit
            'eval': lambda x,y,z : z.subs(y,x),
        }
        self.op4 = {
            'sum': lambda x,y,z,t : Sum(t,(z,y,x)).doit()  # Sum(1/x**2,(x,1,oo)).doit() <=> 1 x x * / x 1 oo sum
        }
        self.lastx = ''

    def findpoint(self,point):
        if point in self.lookup:
            return self.lookup[point]
        else:
            return "punkt(''," + str(N(point.x,6)) + "," + str(N(point.y,6)) + ")"

    def sketch(self):
        self.lookup = {}

        # spara först alla punkter
        for key in self.defs:
            obj = self.defs[key]
            klassnamn = obj.__class__.__name__
            if klassnamn=='Point2D':
                print(key + " = punkt("+"'"+key+"',"+str(N(obj.x,6))+","+str(N(obj.y,6))+")")
                self.lookup[obj] = key

        # därefter hanteras övriga objekt
        for key in self.defs:
            obj = self.defs[key]
            klassnamn = obj.__class__.__name__
            if klassnamn=='Line':
                print('linje("' + key +'",'+ self.findpoint(obj.p1) + "," + self.findpoint(obj.p2) + ')')
            elif klassnamn=='Circle':
                print('cirkel(' + self.findpoint(obj.center) + ',' + str(N(obj.radius,6))+')')
            elif klassnamn=='Triangle':
                a,b,c = obj.vertices
                print('triangel(' + self.findpoint(a) + ',' + self.findpoint(b) + ',' + self.findpoint(c) + ')')

    def help(self):
        for index,op in enumerate([self.op0, self.op1, self.op2, self.op3, self.op4]):
            print(index, " ".join(sorted(op.keys())))

    def history(self):
        for commands,stack in self.hist:
            print(commands,":",stack)

    def defs(self):
        for key in sorted(self.defs):
            print(key,'=',self.pretty(self.defs[key]))

    def rpn(self,s):
        start = time.time()
        if self.clear:
            self.stack = []
        if s in ['?','help']:
            self.help()
            return ''
        elif s in ['hist','history']:
            self.history()
            return ''
        elif s == 'undo':
            if len(self.hist) > 1:
                self.hist.pop()
                _,self.stack = self.hist[-1]
                if self.stack != []:
                    self.lastx = self.stack[-1]
                else:
                    self.lastx = ''
                return self.stack
            return ''
        if s == '': self.mode = 1 - self.mode
        self.lastx = ''
        for command in s.split():

            if command == '': pass
            elif command in self.op0: self.stack.append(self.op0[command]())
            elif command in self.op1: self.stack.append(self.op1[command](self.stack.pop()))
            elif command in self.op2: self.stack.append(self.op2[command](self.stack.pop(),self.stack.pop()))
            elif command in self.op3: self.stack.append(self.op3[command](self.stack.pop(),self.stack.pop(),self.stack.pop()))
            elif command in self.op4: self.stack.append(self.op4[command](self.stack.pop(),self.stack.pop(),self.stack.pop(),self.stack.pop()))
            
            elif command == 'clr': self.stack = []
            elif command == 'dup': self.stack.append(self.stack[-1])
            elif command == 'drp': self.stack.pop()
            elif command == 'swp': self.stack[-1],self.stack[-2] = self.stack[-2],self.stack[-1]

            elif command == 'defs':
                for key in sorted(self.defs): print(key,'=',self.pretty(self.defs[key]))
            elif command[-1] == '=':
                self.lastx = str(self.stack[-1])
                self.defs[command.replace('=','')] = self.stack.pop()
            elif command in self.defs:
                self.stack.append(self.defs[command])
            else:
                if S(command).__class__ == Symbol:
                    print(command + " not recognized!")
                else:
                    self.stack.append(S(command))
        if self.lastx == '':
            if self.stack != []:
                self.lastx = str(self.stack[-1])
        self.hist.append((s,self.stack[:]))
        #print round(time.time()-start,3),s
        return self.lastx

    def removeZeros(self,s):
        t = s.rstrip('0').rstrip('.')
        if t=='': t = '0'
        return t

    def pretty(self,item):
        if self.mode==0: return str(item)
        elif item.__class__ == Point2D:
            return 'Point2D(' + self.pretty(item.x) + ", " + self.pretty(item.y) + ")"
        elif item.__class__ == Line:
            return 'Line(' + self.pretty(item.p1) + ", " + self.pretty(item.p2)+")"
        elif item.__class__ == Circle:
            return 'Circle(' + self.pretty(item.center) + ", " + self.pretty(item.radius) + ")"
        elif item.__class__ == Triangle:
            a,b,c = item.vertices
            return 'Triangle(' + self.pretty(a) + ', ' + self.pretty(b) + ', ' + self.pretty(c) + ')'
        else:
            return self.removeZeros(str(N(item,n=7)))

    def polynom(self,lst):
        res = 0
        factor = 1
        for i in range(len(lst)):
            res += lst[i] * factor
            factor *= self.x
        return res

    def run(self, clear=False):
        self.clear = clear
        while True:
            if self.stack == []: prompt = self.lastx
            else: prompt = " ".join([self.pretty(item) for item in self.stack])
            print(prompt)
            self.rpn(input(": "))

if __name__ == "__main__":
    calc = RPN()
    calc.run()
