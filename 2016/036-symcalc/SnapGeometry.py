# -*- coding: utf-8 -*-

# Enkel lösning av geometriska problem.
# Bygger på att man bara anger geometriska storheter, inga kommandon.
# Då man anger två objekt, skapas alla tänkbara objekt.
#   T ex två trianglar skapar upp till sex punkter.
#   Skärningspunkter, tangenterpunkter, vinkelräta linjer
# Man närmar sig lösningen genom att kombinera/välja ut rätt objekt.

from sympy.geometry import Line,Point,Point2D,intersection,Circle,Triangle,Segment,Ray,rad
from sympy.core import S,N,pi
import time

class Calculator:
    def __init__(self):
        self.reset()

    def reset(self):
        self.start = time.time()
        self.count = {'N':-1, 'P':-1, 'C':-1, 'L':-1, 'A':-1, 'T':-1, 'S':-1}
        session = []
        session.append(['O','P',Point2D(0,0)])
        session.append(['X','L',Line(Point2D(0,0),Point2D(1,0))])
        session.append(['Y','L',Line(Point2D(0,0),Point2D(0,1))])
        self.history = [session]
        self.decs = 3  # 0 = sym, 1-oo = num
        self.dumpToFile()

    def help(self):
        print "Exempel:"
        print "o        => Origo"
        print "x        => x-axeln"
        print "y        => y-axeln"
        print "1 1      => Punkten P0"
        print "P0 P1    => Linjen L0"
        print "P0 L0    => Vinkelrät linje L1"
        print "P0 1     => Cirkel C0"
        print "P0 P1 P2 => Triangel T0"
        print "3 4 5    => Triangel T1"
        print "C0 P0    => Tangentlinjer L2 och L3"
        print "L0 L1    => Skärningspunkter 0,1 eller oo (oändligt många)"
        print "L0 C0    => Skärningspunkter 0,1 eller 2"
        print "L0 T0    => Skärningspunkter 0,1 eller 2"
        print "C0 C1    => Skärningspunkter 0,1,2 eller oo"
        print "C0 T0    => Skärningspunkter 0,1,2,3,4,5 eller 6"
        print "T0 T1    => Skärningspunkter 0,1,2,3,4,5,6 eller oo"
        print "T0.m     => Centrum"
        print "T0.p T0.p0 T0.p1 T0.p2 => Hörn"
        print "T0.a T0.a0 T0.a1 T0.a2 => Vinklar"
        print "T0.s T0.s0 T0.s1 T0.s2 => Sidor"
        print "T0.ic    => Inskriven cirkel"
        print "T0.oc    => Omskriven cirkel"
        print "T0.area  => Area"
        print "C0.x     => x-koordinat"
        print "C0.y     => y-koordinat"
        print "C0.r     => Radie"
        print "C0.area  => Area"
        print "L0.l     => Längd"
        print "0        => Exakt visning, t ex sqrt(2)"
        print "3        => Numerisk visning med tre värdesiffror, t ex 1.41"
        print "undo     => Ångra senaste kommandot"
        print "clear    => Rensa allt"
        print "Starta index.html för att se grafik."

    def dumpObject(self,type,value):
        if type == 'P': return self.showPoint(value)
        elif type == 'N': return str(value if self.decs == 0 else N(value,self.decs))
        elif type == 'A': return "Angle(" + str(value if self.decs == 0 else N(value,self.decs)) + ')'
        elif type == 'L': return "Line(" + self.showPoint(value.p1) + ',' + self.showPoint(value.p2) + ')'
        elif type == 'C':
            radius = value.radius if self.decs==0 else str(N(value.radius,self.decs))
            return "Circle(" + self.showPoint(value.center) + ',' + str(radius) + ')'
        elif type == 'T':
            a,b,c = value.vertices
            return 'Triangle(' + self.showPoint(a) + ',' + self.showPoint(b) + ',' + self.showPoint(c) + ')'
        elif type == 'S': return 'Segment(' + self.showPoint(value.p1) + ',' + self.showPoint(value.p2) + ')'
        else: return 'Error in dumpObject'

    def dump(self):
        for lst in self.history:
            for name,type,value in lst:
                print "# " + name + " = " + self.dumpObject(type,value)

    def dumpToFile(self):
        res = []
        for lst in self.history:
            for name,type,value in lst:
                if name not in ['O','X','Y']:
                    if type == 'P':   res.append('"' + name + '": {"type":"P","x":' + str(N(value.x)) + ',"y":' + str(N(value.y)) + '}')
                    elif type == 'L': res.append('"' + name + '": {"type":"L","x1":' + str(N(value.p1.x)) + ',"y1":' + str(N(value.p1.y)) + ',"x2":' + str(N(value.p2.x)) + ',"y2":' + str(N(value.p2.y)) + '}')
                    elif type == 'T':
                        a,b,c = value.vertices
                        res.append('"' + name + '": {"type":"T","x1":' + str(N(a.x)) + ',"y1":' + str(N(a.y)) + ',"x2":' + str(N(b.x)) + ',"y2":' + str(N(b.y))  + ',"x3":' + str(N(c.x)) + ',"y3":' + str(N(c.y))+ '}')
                    elif type == 'C': res.append('"' + name + '": {"type":"C","x":' + str(N(value.center.x)) + ',"y":' + str(N(value.center.y)) + ',"radius":' + str(N(value.radius))+ '}')
                    elif type == 'S': res.append('"' + name + '": {"type":"S","x1":' + str(N(value.p1.x)) + ',"y1":' + str(N(value.p1.y)) + ',"x2":' + str(N(value.p2.x)) + ',"y2":' + str(N(value.p2.y)) + '}')
                    else:
                        print "Problem in dumpToFile: " + type

        f = open("lab\data.json", "w")
        f.write("{\n  " + ",\n  ".join(res) + "\n}")
        f.close()

    def getType(self,obj):
        signature = obj.__class__.__name__
        signature = signature.replace('Zero','N').replace('Float','N').replace('Integer','N').replace('NegativeOne','N')
        signature = signature.replace('One','N').replace('Pow','N').replace('Mul','N').replace('Rational','N')
        signature = signature.replace('Point2D','P').replace('Circle','C').replace('Line','L').replace('Triangle','T')
        signature = signature.replace('ANGLE','A').replace('Segment','S')
        return signature

    def showPoint(self,p):
        if self.decs == 0: return 'Point(' + str(p.x) + ','+str(p.y)+')'
        else: return 'Point(' + str(N(p.x,self.decs)) + ',' + str(N(p.y,self.decs)) +')'

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

    def storeObject(self,type,obj,name=''):
        for lst in self.history:
            for n,t,v in lst:
                if t==type:
                    if self.dumpObject(type,obj)==self.dumpObject(type,v):
                        print '  ' + n
                        return []
        self.count[type] += 1
        if name == '': name = type + str(self.count[type])
        print '  ' + name + ' = ' + self.dumpObject(type,obj)
        return [name,type,obj]

    def storeNumber(self, n, name=''): return self.storeObject('N',n,name)
    def storePoint(self, p, name=''): return self.storeObject('P',p,name)
    def storeAngle(self, a, name=''): return self.storeObject('A',a,name)
    def storeCircle(self, c, name=''): return self.storeObject('C',c,name)
    def storeLine(self, line): return self.storeObject('L',self.normalizeLine(line))
    def storeTriangle(self, tri): return self.storeObject('T',self.normalizeTriangle(tri))

    def getObject(self,item,arr):
        klassname = item.__class__.__name__
        if klassname == 'Circle':
            if len(arr)==0: return ['C',item]
            elif arr[0]=='X': return ['N',item.center.x]
            elif arr[0]=='Y': return ['N',item.center.y]
            elif arr[0]=='R': return ['N',item.radius]
            elif arr[0]=='AREA': return ['N',item.area]
        elif klassname == 'Point2D':
            if len(arr)==0: return ['P',item]

    def getItem(self,name):  # klarar punktnotation med flera punkter
        arr = name.split('.')
        lst = self.findItem(arr[0])
        if lst == None: return None
        if len(arr) == 1: return lst
        item = lst[1]
        klassname = item.__class__.__name__
        if klassname == 'Triangle':
            if arr[1]=='A': return ['*',[a*180/pi for a in item.angles.values()]] # just print
            elif arr[1]=='A0': return ['A',item.angles.values()[0]*180/pi]
            elif arr[1]=='A1': return ['A',item.angles.values()[1]*180/pi]
            elif arr[1]=='A2': return ['A',item.angles.values()[2]*180/pi]
            elif arr[1]=='P': return ['*',item.vertices]
            elif arr[1]=='P0': return ['P',item.vertices[0]]
            elif arr[1]=='P1': return ['P',item.vertices[1]]
            elif arr[1]=='P2': return ['P',item.vertices[2]]
            elif arr[1]=='S':  return ['*',[s.length for s in item.sides]]
            elif arr[1]=='S0': return ['N',item.sides[0].length]
            elif arr[1]=='S1': return ['N',item.sides[1].length]
            elif arr[1]=='S2': return ['N',item.sides[2].length]
            elif arr[1]=='M':  return self.getObject(item.centroid,arr[2:])
            elif arr[1]=='IC': return self.getObject(item.incircle,arr[2:])
            elif arr[1]=='OC': return self.getObject(item.circumcircle,arr[2:])
            elif arr[1]=='AREA': return ['N',item.area]
        elif klassname == 'Line':
            if arr[1]=='L': return ['N',Segment(item.p1,item.p2).length]
        elif klassname == 'Circle':
            return self.getObject(item,arr[1:])
        return None

    def findItem(self,name):
        for lst in self.history:
            for key,type,value in lst:
                if name == key: return [type,value]
        return None

    def calc(self,commands):
        commands = commands.upper()
        if commands == '':
            self.dump()
            return ''
        elif commands.isdigit():
            self.decs = int(commands)
            self.dump()
            return ''
        elif commands == 'UNDO':
            if len(self.history) <= 1: return ''
            lst = self.history.pop()
            for n,t,v in lst:
                self.count[t] -= 1
            return ''
        elif commands == 'CLEAR':
            self.reset()
            return ''

        arr = commands.split()
        signature = []
        res = []
        for cmd in arr:
            lst = self.getItem(cmd)
            if lst:
                if lst[0] == '*':
                    print lst[1]
                    return []
                else:
                    signature.append(lst[0])
                    res.append(S(lst[1]))
            else:
                obj = S(cmd)
                signature.append(self.getType(obj))
                res.append(obj)

        signature = "".join(signature)
        #print signature

        if len(res) > 0: a = res[0]
        if len(res) > 1: b = res[1]
        if len(res) > 2: c = res[2]

        if signature == 'A': result = [self.storeAngle(a)]
        elif signature == 'C': result = [self.storeCircle(a)]
        elif signature == 'L': result = [self.storeLine(a)]
        elif signature == 'N': result = [self.storeNumber(a)]
        elif signature == 'P': result = [self.storePoint(a)]
        elif signature == 'T': result = [self.storeTriangle(a)]

        elif signature == 'NN': result = [self.storePoint(Point(a,b))]
        elif signature == 'PP': result = [] if a == b else [self.storeLine(Line(a,b))]
        elif signature == 'PA':
            v = rad(b.args[0]+0.0000)
            p1 = a
            p2 = Point2D(1,0)
            p2 = p2.rotate(v,Point2D(0,0))
            p2 = p2.translate(a.x,a.y)
            line = Line(p1,p2)
            result = [self.storeLine(line)]
        elif signature == 'PN': result = [self.storeCircle(Circle(a,b))]
        elif signature == 'NP': result = [self.storeCircle(Circle(b,a))]
        elif signature == 'CP': result = [self.storeLine(line) for line in a.tangent_lines(b)]
        elif signature == 'PC': result = [self.storeLine(line) for line in b.tangent_lines(a)]
        elif signature == 'LP': result = [self.storeLine(a.perpendicular_line(b))]
        elif signature == 'PL': result = [self.storeLine(b.perpendicular_line(a))]
        elif signature in ['LL','CL','LC','TT','CT','TC','LT','TL']:
            result = [self.storeObject(self.getType(obj),obj) for obj in intersection(a,b)]
        elif signature in ['CC']: # pga att intersection returnerar [Point] eller Circle.
            anything = intersection(a,b)
            if anything.__class__ is list: result = [self.storeObject(self.getType(obj),obj) for obj in anything]
            else: result = [self.storeObject(self.getType(anything),anything)]

        elif signature == 'LLL':
            p1 = intersection(a,b)[0]
            p2 = intersection(b,c)[0]
            p3 = intersection(c,a)[0]
            result = [self.storeTriangle(Triangle(p1,p2,p3))]
        elif signature == 'PPP': result = [self.storeTriangle(Triangle(a,b,c))]
        elif signature == 'NNN': result = [self.storeTriangle(Triangle(sss=(a,b,c)))]
        elif signature == 'ANA':
            va = rad(a.args[0])
            vc = rad(c.args[0])
            result = [self.storeTriangle(Triangle(asa=(va,b,vc)))]
        elif signature == 'NAN':
            vb = rad(b.args[0])
            result = [self.storeTriangle(Triangle(sas=(a,vb,c)))]
        else:
            print 'Unhandled command!'
            result = []
        self.history.append([lst for lst in result if lst!=[]])
        return result

    def run(self):
        self.help()
        while True:
            commands = raw_input(':').upper()
            self.calc(commands)
            self.dumpToFile()

    def var(self,name):
        type,value = self.findItem(name)
        return self.dumpObject(name,type,value)

    def ready(self):
        print "  " + str(round(time.time()-self.start,3)) + "s"

if __name__ == "__main__":
    calc = Calculator()
    calc.run()