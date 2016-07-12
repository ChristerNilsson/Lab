# -*- coding: utf-8 -*-

# Enkel lösning av geometriska problem.
# Bygger på att man bara anger geometriska storheter, inga kommandon.
# Då man anger två objekt, skapas alla tänkbara objekt.
#   T ex två trianglar skapar upp till sex punkter.
#   Skärningspunkter, tangenterpunkter, vinkelräta linjer
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
        self.count = {'N':-1, 'P':-1, 'C':-1, 'L':-1, 'A':-1, 'T':-1}

        self.history = []
        self.history.append(['O','P',Point2D(0,0)])
        self.history.append(['X','L',Line(Point2D(0,0),Point2D(1,0))])
        self.history.append(['Y','L',Line(Point2D(0,0),Point2D(0,1))])
        self.mode = 1 # 0='sym' 1='num'
        self.decs = 3
        self.dumpToFile()

    def dumpObject(self,type,value):
        if type == 'P':
            return self.showPoint(value)
        elif type == 'N':
            return str(value if self.mode == 0 else N(value,self.decs))
        elif type == 'A':
            return "Angle(" + str(value if self.mode == 0 else N(value,self.decs)) + ')'
        elif type == 'L':
            line = value
            segment = Segment(line.p1,line.p2)
            length = str(segment.length) if self.mode==0 else str(N(segment.length,self.decs))
            return "Line(" + self.showPoint(line.p1) + ',' + self.showPoint(line.p2) + ') length='+length
        elif type == 'C':
            c = value
            radius = c.radius if self.mode==0 else str(N(c.radius,self.decs))
            return "Circle(" + self.showPoint(c.center) + ',' + str(radius) + ')'
        elif type == 'T':
            a,b,c = value.vertices
            return 'Triangle(' + self.showPoint(a) + ',' + self.showPoint(b) + ',' + self.showPoint(c) + ')'
        else:
            return 'Error in dumpObject'

    def dump(self):
        for name,type,value in self.history:
            print "# " + name + " = " + self.dumpObject(type,value)

    def dumpToFile(self):
        f = open("lab\data.js", "w")
        f.write("data = {\n")
        for name,type,value in self.history:
            if name not in ['O','X','Y']:
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
            return 'Point(' + str(p.x) + ','+str(p.y)+')'
        else:
            return 'Point(' + str(N(p.x,self.decs)) + ',' + str(N(p.y,self.decs)) +')'

    def normalizeLine(self,line):
        lst = []
        lst.append([line.p1.x,line.p1.y,line.p2.x,line.p2.y])
        lst.append([line.p2.x,line.p2.y,line.p1.x,line.p1.y])
        x1,y1,x2,y2 = sorted(lst)[0]
        return Line(Point(x1,y1),Point(x2,y2))

    def normalizeTriangle(self,tri):
        lst = []
        a,b,c = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        a,c,b = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        b,a,c = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        b,c,a = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        c,a,b = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        c,b,a = tri.vertices
        lst.append([a.x,a.y,b.x,b.y,c.x,c.y])
        x1,y1,x2,y2,x3,y3 = sorted(lst)[0]
        return Triangle(Point(x1,y1),Point(x2,y2),Point(x3,y3))

    def storeObject(self,type,obj):
        for name,t,value in self.history:
            if t==type:
                if self.dumpObject(type,obj)==self.dumpObject(type,value):
                    print '  ' + name
                    return name
        self.count[type] += 1
        name = type + str(self.count[type])
        self.history.append([name,type,obj])
        print '  ' + name + ' = ' + self.dumpObject(type,obj)
        return name

    def storeNumber(self, n):
        return self.storeObject('N',n)
        # self.count['N'] += 1
        # name = 'N' + str(self.count['N'])
        # self.history.append([name,'N',n])
        # print '  ' + name + " = " + self.dumpObject('N',n)
        # return name

    def storePoint(self, p):
        return self.storeObject('P',p)

    def storeLine(self, line):
        line = self.normalizeLine(line)
        return self.storeObject('L',line)

    def storeAngle(self, a):
        return self.storeObject('A',a)
        # self.count['A'] += 1
        # name = 'A' + str(self.count['A'])
        # self.history.append([name,'A',a])
        # print '  ' + name + ' = ' + self.dumpObject('A',a)
        # return name

    def storeCircle(self, c):
        return self.storeObject('C',c)

    def storeTriangle(self, tri):
        tri = self.normalizeTriangle(tri)
        return self.storeObject('T',tri)

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
        elif commands == 'SYM':
            self.mode=0
            self.dump()
            return ''
        elif commands == 'NUM':
            self.mode=1
            self.dump()
            return ''
        elif commands == 'UNDO':
            name,type,value = self.history.pop()
            self.count[type] -= 1
            return ''
        elif commands == 'CLEAR':
            self.reset()
            return ''
        elif commands == '+':
            self.decs += 1
            self.dump()
            return ''
        elif commands == '-':
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
        signature = signature.replace('Zero','N').replace('Float','N').replace('Integer','N').replace('NegativeOne','N').replace('One','N').replace('Pow','N').replace('Mul','N')
        signature = signature.replace('Point2D','P').replace('Circle','C').replace('Line','L').replace('Triangle','T')
        signature = signature.replace('Angle','A')

        # print signature

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
        elif signature == 'PN':
            result = self.storeCircle(Circle(a,b))
        elif signature == 'NP':
            result = self.storeCircle(Circle(b,a))
        elif signature == 'CP':
            result = ' '.join([self.storeLine(line) for line in a.tangent_lines(b)])
        elif signature == 'PC':
            result = ' '.join([self.storeLine(line) for line in b.tangent_lines(a)])
        elif signature == 'LP':
            result = self.storeLine(a.perpendicular_line(b))
        elif signature == 'PL':
            result = self.storeLine(b.perpendicular_line(a))
        elif signature in ['LL','CL','LC','CC','TT','CT','TC','LT','TL']:
            result = ' '.join([self.storePoint(p) for p in intersection(a,b)])
        elif signature == 'LLL':
            p1 = intersection(a,b)[0]
            p2 = intersection(b,c)[0]
            p3 = intersection(c,a)[0]
            result = self.storeTriangle(Triangle(p1,p2,p3))
        elif signature == 'PPP':
            result = self.storeTriangle(Triangle(a,b,c))
        elif signature == 'L':
            segment = Segment(a.p1,a.p2)
            result = ' '.join([self.storeNumber(segment.length)])
        elif signature == 'T':
            r = [self.storeAngle(N(180/pi*angle)) for angle in a.angles.values()]
            result = ' '.join([self.storePoint(a.centroid), self.storeCircle(a.incircle), self.storeCircle(a.circumcircle), self.storeNumber(a.area)] + r)
        else:
            print 'Unhandled command!'
            result = []
        return result

    def run(self):
        while True:
            commands = raw_input(':').upper()
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