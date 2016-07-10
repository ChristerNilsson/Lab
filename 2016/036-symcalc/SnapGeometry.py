# -*- coding: utf-8 -*-

# Enkel lösning av geometriska problem.
# Bygger på att man bara anger geometriska storheter, inga kommandon.
# Då man anger två objekt, skapas alla tänkbara objekt.
#   T ex två cirklar skapar upp till tolv punkter.
#   Skärningspunkter, tangenterpunkter, närmaste, avlägsnaste, osv.
# Man närmar sig lösningen genom att kombinera/välja ut rätt objekt.

# Undvik vinklar som är multiplar av 3 grader. Lägg därför till eller dra ifrån någon miljondels grad.
# Orsaken är att dessa vinklar kan representeras exakt. Beräkningstiderna kan handla om tio minuter istf en sekund.
# Alltså: 78 grader blir Angle(78.000001) (0.000001 läggs till automatiskt)

# Primitiver:
# x y   => Point a
# a b   => Line ab
# a r   => Circle c1
# a b c => Triangle abc
# abc   => Circle c2 c3
# ab c2 => 0..6 points (intersection)
# c1 b  => 2 points (tangent points)
# ab c  => 1 point (perpendicular point)

# Exempel:
# 0 2 => a     (punkt)
# 0 8 => b     (punkt)
# a 2 => c1    (cirkel)
# c1 b => c d  (tangerande punkter)
# b c => bc    (linje)
# xx bc => e   (skärningspunkt)
# e a => ea    (linje)
# ea c1 => f g (skärningspunkt)
# ea f => h    (vinkelrät)
# f h => fh    (linje)
# fh bc => i   (skärningspunkt)
# fh xx => j   (skärningspunkt)
# e i j => eij (triangel)
# eij => c2 c3 (inre och yttre cirkel)

# todo Visa grafik direkt efter varje inmatning.
# Man ska ej behöva trycka på Refresh.
# Kräver automatisk inläsning av datafil. zoom/pan ska ej påverkas.

from sympy.geometry import Line,Point,Point2D,intersection,Circle,Triangle,Segment,Ray,rad
from sympy.core import S,N,pi
import time
import math

class Calculator:
    def __init__(self):
        self.reset()

    def reset(self):
        self.start = time.time()
        self.numberCount = -1
        self.pointCount = -1
        self.circleCount = -1
        self.lineCount = -1
        self.angleCount = -1
        self.triangleCount = -1

        self.history = []
        self.history.append(['o','P',Point2D(0,0)])
        self.history.append(['x','L',Line(Point2D(0,0),Point2D(1,0))])
        self.history.append(['y','L',Line(Point2D(0,0),Point2D(0,1))])
        self.mode = 1 # 0='sym' 1='num'
        self.decs = 3
        self.dumpToFile()

    def dumpObject(self,name,type,value):
        if type == 'P':
            return name + " = Point " + self.showPoint(value)
        elif type == 'N':
            return name + " = Number " + str(value if self.mode == 0 else N(value,self.decs))
        elif type == 'A':
            return name + " = Angle " + str(value if self.mode == 0 else N(value,self.decs))
        elif type == 'L':
            line = value
            segment = Segment(line.p1,line.p2)
            length = str(segment.length) if self.mode==0 else str(N(segment.length,self.decs))
            return name + " = Line " + self.showPoint(line.p1) + ' ' + self.showPoint(line.p2) + ' length='+length
        elif type == 'C':
            c = value
            radius = c.radius if self.mode==0 else str(N(c.radius,self.decs))
            return name + " = Circle " + self.showPoint(c.center) + ' radius=' + str(radius)
        elif type == 'T':
            a,b,c = value.vertices
            return name + ' = Triangle ' + self.showPoint(a) + ' ' + self.showPoint(b) + ' ' + self.showPoint(c)
        else:
            return 'Error in dumpObject'

    def dump(self):
        for name,type,value in self.history:
            print "# " + self.dumpObject(name,type,value)

    def dumpToFile(self):
        f = open("lab\data.js", "w")
        f.write("data = {\n")
        for name,type,value in self.history:
            if name not in ['o','x','y']:
                if type=='P':   f.write("  " + name + ": {type:'P',x:" + str(N(value.x)) + ",y:" + str(N(value.y)) + "},\n")
                elif type=='L': f.write("  " + name + ": {type:'L',x1:" + str(N(value.p1.x)) + ",y1:" + str(N(value.p1.y)) + ",x2:" + str(N(value.p2.x)) + ",y2:" + str(N(value.p2.y)) + "},\n")
                elif type=='T':
                    a,b,c = value.vertices
                    f.write("  " + name + ": {type:'T',x1:" + str(N(a.x)) + ",y1:" + str(N(a.y)) + ",x2:" + str(N(b.x)) + ",y2:" + str(N(b.y))  + ",x3:" + str(N(c.x)) + ",y3:" + str(N(c.y))+ "},\n")
                elif type=='C': f.write("  " + name + ": {type:'C',x:" + str(N(value.center.x)) + ",y:" + str(N(value.center.y)) + ",radius:" + str(N(value.radius))+ "},\n")
        f.write("}")
        f.close()

    def showPoint(self,p):
        if self.mode == 0:
            return 'x=' + str(p.x) + ' y='+str(p.y)
        else:
            return 'x=' + str(N(p.x,self.decs)) + ' y=' + str(N(p.y,self.decs))

    def storeNumber(self, n):
        self.numberCount += 1
        name = 'n' + str(self.numberCount)
        self.history.append([name,'N',n])
        print '  ' + self.dumpObject(name,'N',n)
        return name

    def storePoint(self, p):
        self.pointCount += 1
        name = 'p' + str(self.pointCount)
        self.history.append([name,'P',p])
        print '  ' + self.dumpObject(name,'P',p)
        return name

    def storeAngle(self, a):
        self.angleCount += 1
        name = 'a' + str(self.angleCount)
        self.history.append([name,'A',a])
        print '  ' + self.dumpObject(name,'A',a)
        return name

    def storeCircle(self, c):
        self.circleCount += 1
        name = 'c' + str(self.circleCount)
        self.history.append([name,'C',c])
        print '  ' + self.dumpObject(name,'C',c)
        return name

    def storeLine(self, line):
        self.lineCount += 1
        name = 'l' + str(self.lineCount)
        self.history.append([name,'L',line])
        print '  ' + self.dumpObject(name,'L',line)
        return name

    def storeTriangle(self, tri):
        self.triangleCount += 1
        name = 't' + str(self.triangleCount)
        self.history.append([name,'T',tri])
        print '  ' + self.dumpObject(name,'T',tri)
        return name

    def findItem(self,name):
        for key,type,value in self.history:
            if name==key: return [key,type,value]
        return None

    def more(self):
        self.decs += 1

    def less(self):
        self.decs -= 1

    def calc(self,commands):

        if commands == '':
            self.dump()
            return ''
        elif commands == 'sym':
            self.mode=0
            self.dump()
            return ''
        elif commands == 'num':
            self.mode=1
            self.dump()
            return ''
        elif commands == 'undo':
            name,type,value = self.history.pop()
            if type =='P': self.pointCount -= 1
            elif type =='C': self.circleCount -= 1
            return ''
        elif commands == 'more':
            self.decs += 1
            self.dump()
            return ''
        elif commands == 'less':
            self.decs -= 1
            self.dump()
            return ''

        arr = commands.split()
        res = []
        for cmd in arr:
            item = self.findItem(cmd)
            if item: res.append(S(item[2]))
            else: res.append(S(cmd))

        signature = "".join([item.__class__.__name__ for item in res])
        signature = signature.replace('Zero','N').replace('Float','N').replace('Integer','N').replace('NegativeOne','N').replace('One','N')
        signature = signature.replace('Point2D','P').replace('Circle','C').replace('Line','L').replace('Triangle','T')
        signature = signature.replace('Angle','A')

        if len(res) > 0: a = res[0]
        if len(res) > 1: b = res[1]
        if len(res) > 2: c = res[2]

        if signature == 'NN':
            result = self.storePoint(Point(a,b))
        elif signature == 'NNN':
            result = self.storeTriangle(Triangle(sss=(a,b,c)))
        elif signature == 'ANA':
            va = rad(a.args[0])
            vc = rad(c.args[0])
            result = self.storeTriangle(Triangle(asa=(va,b,vc)))
        elif signature == 'NAN':
            vb = rad(b.args[0])
            result = self.storeTriangle(Triangle(sas=(a,vb,c)))
            z=99
        elif signature == 'PP':
            result = self.storeLine(Line(a,b))
        elif signature == 'PA':
            v = rad(b.args[0]+0.0000)
            p1 = a
            p2 = Point2D(1,0)
            p2 = p2.rotate(v,Point2D(0,0))
            p2 = p2.translate(a.x,a.y)
            line = Line(p1,p2)
            result = self.storeLine(line) # N
        elif signature in ['PN','NP']:
            result = self.storeCircle(Circle(a,b))
        elif signature in ['CP']:
            result = ' '.join([self.storePoint(line.p2) for line in a.tangent_lines(b)])
        elif signature in ['PC']:
            result = ' '.join([self.storePoint(line.p2) for line in b.tangent_lines(a)])
        elif signature in ['LP']:
            result = self.storePoint(a.perpendicular_line(b).p2)
        elif signature in ['PL']:
            result = self.storePoint(b.perpendicular_line(a).p2)
        elif signature in ['LL','CL','LC','CC','TT','CT','TC','LT','TL']:
            result = ' '.join([self.storePoint(p) for p in intersection(a,b)])
        elif signature == 'PPP':
            result = self.storeTriangle(Triangle(a,b,c))
        elif signature == 'T':
            r = [self.storeAngle(N(180/pi*angle)) for angle in a.angles.values()]
            result = ' '.join([self.storePoint(a.centroid), self.storeCircle(a.incircle), self.storeCircle(a.circumcircle), self.storeNumber(a.area)] + r)
        else:
            print 'Unhandled command!'
            result = []
        return result

    def run(self):
        while True:
            commands = raw_input(':').lower()
            self.calc(commands)
            self.dumpToFile()

    def var(self,name):
        name,type,value = self.findItem(name)
        return self.dumpObject(name,type,value)

    def ready(self):
        print "  " + str(round(time.time()-self.start,3)) + "s"

if __name__ == "__main__":
    calc = Calculator()
    calc.run()