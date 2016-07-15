# -*- coding: utf-8 -*-

# Enkel lösning av geometriska problem.
# Bygger på att man bara anger geometriska storheter, inga kommandon.
# Då man anger två objekt, skapas alla tänkbara objekt.
#   T ex två trianglar skapar upp till sex punkter.
#   Skärningspunkter, tangenterpunkter, vinkelräta linjer
# Man närmar sig lösningen genom att kombinera/välja ut rätt objekt.

from sympy import *
import time

N_WORDS = "int float Integer Float Pow Mul Add Pi Half Zero NegativeOne One Rational".split()

class Calculator:
    def __init__(self):
        self.reset()

    def reset(self):
        self.start = time.time()
        self.counters = {}
        self.locals = {}
        self.locals['o'] = Point2D(0,0)
        self.locals['x'] = Line(Point2D(0,0),Point2D(1,0))
        self.locals['y'] = Line(Point2D(0,0),Point2D(0,1))
        self.history = [['Original',['o','x','y']]]
        self.decs = 3  # 0 = sym, 1-oo = num
        self.dumpGeometry()

    def help(self):
        print "Exempel:"
        print "o        => Origo"
        print "x        => x-axeln"
        print "y        => y-axeln"
        print "1 1      => Punkten p0"
        print "p0 p1    => Linjen l0"
        print "p0.distance(p1) => Distans"
        print "p0 l0    => Vinkelrät linje l1"
        print "p0 1     => Cirkel c0"
        print "p0 p1 p2 => Triangel t0"
        print "3 4 5    => Triangel t1"
        print "c0 p0    => Tangentlinjer l2 och l3"
        print "l0 l1    => Skärningspunkter 0,1 eller oo (oändligt många)"
        print "l0 c0    => Skärningspunkter 0,1 eller 2"
        print "l0 t0    => Skärningspunkter 0,1 eller 2"
        print "c0 c1    => Skärningspunkter 0,1,2 eller oo"
        print "c0 t0    => Skärningspunkter 0,1,2,3,4,5 eller 6"
        print "t0 t1    => Skärningspunkter 0,1,2,3,4,5,6 eller oo"
        print "t0.centroid     => Centrum"
        print "t0.vertices     => Hörn"
        print "t0.angles       => Vinklar"
        print "t0.sides        => Sidor"
        print "t0.incircle     => Inskriven cirkel"
        print "t0.circumcircle => Omskriven cirkel"
        print "t0.area         => Area"
        print "c0.center => Centrum"
        print "c0.radius => Radie"
        print "c0.area   => Area"
        print "0        => Exakt visning, t ex sqrt(2)"
        print "1-99     => Numerisk visning med angivet antal värdesiffror, t ex 1.41"
        print "undo     => Ångra senaste kommandot"
        print "clear    => Rensa allt"
        print "Starta index.html med P5 för att se grafik."
        print "För mer information, se http://docs.sympy.org"
        print "Mata in ett kommando:"

    def pp(self,x):
        return str(x) if self.decs == 0 else str(N(x,self.decs))

    def showPoint(self,p):
        return 'Point(' + self.pp(p.x) + ',' + self.pp(p.y) +')'

    def dumpObject(self,value):
        type = self.getSignature(value)
        if type == 'p': return self.showPoint(value)
        elif type == 'n': return self.pp(value)
        elif type == 'a': return "Angle(" + self.pp(value) + ')'
        elif type == 'l': return "Line(" + self.showPoint(value.p1) + ',' + self.showPoint(value.p2) + ')'
        elif type == 'c': return "Circle(" + self.showPoint(value.center) + ',' + self.pp(value.radius) + ')'
        elif type == 't':
            a,b,c = value.vertices
            return 'Triangle(' + self.showPoint(a) + ',' + self.showPoint(b) + ',' + self.showPoint(c) + ')'
        elif type == 's': return 'Segment(' + self.showPoint(value.p1) + ',' + self.showPoint(value.p2) + ')'
        else: return 'Error in dumpObject'

    def dump(self):
        for cmd,names in self.history:
            print "  #",cmd
            for name in names:
                print "  ",name,'=', self.dumpObject(self.locals[name])

    def dumpGeometry(self):
        res = []
        for cmd,names in self.history:
            for name in names:
                obj = self.locals[name]
                s = self.getSignature(obj)
                lst = []
                if s == "p":
                    lst = [obj.x,obj.y]
                elif s == "l":
                    lst = [obj.p1.x,obj.p1.y,obj.p2.x,obj.p2.y]
                elif s == "c":
                    lst = [obj.center.x,obj.center.y,obj.radius]
                elif s == "t":
                    a,b,c = obj.vertices
                    lst = [a.x,a.y,b.x,b.y,c.x,c.y]
                if lst != []:
                    res.append([name,[N(item) for item in lst]])
        f = open("lab\data.json", "w")
        f.write("{\n" + ",\n".join(['  "'+name+'":'+str(lst) for name,lst in res]) + "\n}")
        f.close()

    def getName(self,obj,type=''):
        if type == '': type = self.getSignature(obj)
        if type not in self.counters: self.counters[type] = -1
        self.counters[type] += 1
        return type + str(self.counters[type])

    def getSignature(self,obj):
        s = obj.__class__.__name__
        if s in N_WORDS: return 'n'
        elif s == "Triangle": return "t"
        elif s == "Point2D": return "p"
        elif s == "Circle": return "c"
        elif s == "Line": return "l"
        elif s == "Segment": return "s"
        elif s == "dict": return "d"
        return s

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

    def do(self,commands):
        if commands == '':
            self.dump()
            return ''
        elif commands.isdigit():
            self.decs = int(commands)
            self.dump()
            return ''
        elif commands == 'undo':
            if len(self.history) <= 1:
                print "  undo not possible."
                return ''
            command,lst = self.history.pop()
            for name in lst:
                obj = self.locals[name]
                t = self.getSignature(obj)
                self.counters[t] -= 1
            print "  " + command + " undone."
            return ''
        elif commands == 'clear':
            self.reset()
            return ''

        arr = commands.split()
        res = []
        signature = ""
        for cmd in arr:
            obj = eval(cmd,None,self.locals)
            res.append(obj)
            signature += self.getSignature(obj)

        if len(res)>0: a = res[0]
        if len(res)>1: b = res[1]
        if len(res)>2: c = res[2]

        if signature == 'nn': obj = Point(a,b)
        elif signature == 'd': obj = a
        elif signature == 'pp': obj = Line(a,b)
        elif signature == 'pn': obj = Circle(a,b)
        elif signature == 'np': obj = Circle(b,a)
        elif signature == 'cp': obj = a.tangent_lines(b)
        elif signature == 'pc': obj = b.tangent_lines(a)
        elif signature == 'lp': obj = a.perpendicular_line(b)
        elif signature == 'pl': obj = b.perpendicular_line(a)
        elif signature in 'll cc cl lc tt ct tc lt tl'.split(): obj = intersection(a,b)
        elif signature == 'PA':
            v = rad(b.args[0]+0.0000)
            p1 = a
            p2 = Point2D(1,0)
            p2 = p2.rotate(v,Point2D(0,0))
            p2 = p2.translate(a.x,a.y)
            obj = Line(p1,p2)

        elif signature == 'ppp': obj = Triangle(a,b,c)
        elif signature == 'lll':
            p1 = intersection(a,b)[0]
            p2 = intersection(b,c)[0]
            p3 = intersection(c,a)[0]
            obj = Triangle(p1,p2,p3)
        elif signature == 'nnn': obj = Triangle(sss=(a,b,c))
        elif signature == 'ana':
            va = rad(a.args[0])
            vc = rad(c.args[0])
            obj = Triangle(asa=(va,b,vc))
        elif signature == 'nan':
            vb = rad(b.args[0])
            obj = Triangle(sas=(a,vb,c))

        result = []
        names = []
        if isinstance(obj,list):
            for o in obj:
                name = self.getName(o)
                names.append(name)
                self.locals[name] = o
                result.append(name)
        elif isinstance(obj,dict):
            name = self.getName(obj)
            names.append(name)
            self.locals[name] = obj.values()
            result.append(name)
        else:
            t = self.getSignature(obj)
            if t == 'l': obj = self.normalizeLine(obj)
            if t == 't': obj = self.normalizeTriangle(obj)

            for cmd,names in self.history:
                for name in names:
                    v = self.locals[name]
                    type = self.getSignature(v)
                    if t == type:
                        if self.dumpObject(obj)==self.dumpObject(v):
                            print '  ' + name
                            return []

            name = self.getName(obj)
            names.append(name)
            self.locals[name] = obj
            result.append(name)
        s = "  " + "\n  ".join([name + " = " + self.dumpObject(self.locals[name]) for name in result])
        print s
        self.history.append([commands,names])
        return s

    def run(self):
        self.help()
        while True:
            commands = raw_input()
            try:
                self.do(commands)
                self.dumpGeometry()
            except Exception as e:
                print "  Error: " + e.message

    def ready(self):
        print "  " + str(round(time.time()-self.start,3)) + "s"

if __name__ == "__main__":
    calc = Calculator()
    calc.run()


    # def dumpToFile(self):
    #     res = []
    #     for lst in self.history:
    #         for name,type,value in lst:
    #             if name not in ['O','X','Y']:
    #                 if type == 'P':   res.append('"' + name + '": {"type":"P","x":' + str(N(value.x)) + ',"y":' + str(N(value.y)) + '}')
    #                 elif type == 'L': res.append('"' + name + '": {"type":"L","x1":' + str(N(value.p1.x)) + ',"y1":' + str(N(value.p1.y)) + ',"x2":' + str(N(value.p2.x)) + ',"y2":' + str(N(value.p2.y)) + '}')
    #                 elif type == 'T':
    #                     a,b,c = value.vertices
    #                     res.append('"' + name + '": {"type":"T","x1":' + str(N(a.x)) + ',"y1":' + str(N(a.y)) + ',"x2":' + str(N(b.x)) + ',"y2":' + str(N(b.y))  + ',"x3":' + str(N(c.x)) + ',"y3":' + str(N(c.y))+ '}')
    #                 elif type == 'C': res.append('"' + name + '": {"type":"C","x":' + str(N(value.center.x)) + ',"y":' + str(N(value.center.y)) + ',"radius":' + str(N(value.radius))+ '}')
    #                 elif type == 'S': res.append('"' + name + '": {"type":"S","x1":' + str(N(value.p1.x)) + ',"y1":' + str(N(value.p1.y)) + ',"x2":' + str(N(value.p2.x)) + ',"y2":' + str(N(value.p2.y)) + '}')
    #                 else:
    #                     print "Problem in dumpToFile: " + type
    #
    #     f = open("lab\data.json", "w")
    #     f.write("{\n  " + ",\n  ".join(res) + "\n}")
    #     f.close()

    # def getType(self,obj):
    #     signature = obj.__class__.__name__
    #     signature = signature.replace('Zero','N').replace('Float','N').replace('Integer','N').replace('NegativeOne','N')
    #     signature = signature.replace('One','N').replace('Pow','N').replace('Mul','N').replace('Rational','N')
    #     signature = signature.replace('Point2D','P').replace('Circle','C').replace('Line','L').replace('Triangle','T')
    #     signature = signature.replace('ANGLE','A').replace('Segment','S')
    #     return signature

    # def dump(self):
    #     for lst in self.history:
    #         for name,obj in lst:
    #             print "# " + name + " = " + self.dumpObject(obj)

    # def calc(self,commands):
    #
    #     arr = commands.split()
    #     signature = []
    #     res = []
    #     for cmd in arr:
    #         lst = self.getItem(cmd)
    #         if lst:
    #             if lst[0] == '*':
    #                 print lst[1]
    #                 return []
    #             else:
    #                 signature.append(lst[0])
    #                 res.append(S(lst[1]))
    #         else:
    #             obj = S(cmd)
    #             signature.append(self.getType(obj))
    #             res.append(obj)
    #
    #     signature = "".join(signature)
    #     #print signature
    #
    #     if len(res) > 0: a = res[0]
    #     if len(res) > 1: b = res[1]
    #     if len(res) > 2: c = res[2]
    #
    #     if signature == 'A': result = [self.storeAngle(a)]
    #     elif signature == 'C': result = [self.storeCircle(a)]
    #     elif signature == 'L': result = [self.storeLine(a)]
    #     elif signature == 'N': result = [self.storeNumber(a)]
    #     elif signature == 'P': result = [self.storePoint(a)]
    #     elif signature == 'T': result = [self.storeTriangle(a)]
    #
    #     elif signature == 'NN': result = [self.storePoint(Point(a,b))]
    #     elif signature == 'PP': result = [] if a == b else [self.storeLine(Line(a,b))]
    #     elif signature == 'PA':
    #         v = rad(b.args[0]+0.0000)
    #         p1 = a
    #         p2 = Point2D(1,0)
    #         p2 = p2.rotate(v,Point2D(0,0))
    #         p2 = p2.translate(a.x,a.y)
    #         line = Line(p1,p2)
    #         result = [self.storeLine(line)]
    #     elif signature == 'PN': result = [self.storeCircle(Circle(a,b))]
    #     elif signature == 'NP': result = [self.storeCircle(Circle(b,a))]
    #     elif signature == 'CP': result = [self.storeLine(line) for line in a.tangent_lines(b)]
    #     elif signature == 'PC': result = [self.storeLine(line) for line in b.tangent_lines(a)]
    #     elif signature == 'LP': result = [self.storeLine(a.perpendicular_line(b))]
    #     elif signature == 'PL': result = [self.storeLine(b.perpendicular_line(a))]
    #     elif signature in ['LL','CL','LC','TT','CT','TC','LT','TL']:
    #         result = [self.storeObject(self.getType(obj),obj) for obj in intersection(a,b)]
    #     elif signature in ['CC']: # pga att intersection returnerar [Point] eller Circle.
    #         anything = intersection(a,b)
    #         if anything.__class__ is list: result = [self.storeObject(self.getType(obj),obj) for obj in anything]
    #         else: result = [self.storeObject(self.getType(anything),anything)]
    #
    #     elif signature == 'LLL':
    #         p1 = intersection(a,b)[0]
    #         p2 = intersection(b,c)[0]
    #         p3 = intersection(c,a)[0]
    #         result = [self.storeTriangle(Triangle(p1,p2,p3))]
    #     elif signature == 'PPP': result = [self.storeTriangle(Triangle(a,b,c))]
    #     elif signature == 'NNN': result = [self.storeTriangle(Triangle(sss=(a,b,c)))]
    #     elif signature == 'ANA':
    #         va = rad(a.args[0])
    #         vc = rad(c.args[0])
    #         result = [self.storeTriangle(Triangle(asa=(va,b,vc)))]
    #     elif signature == 'NAN':
    #         vb = rad(b.args[0])
    #         result = [self.storeTriangle(Triangle(sas=(a,vb,c)))]
    #     else:
    #         print 'Unhandled command!'
    #         result = []
    #     self.history.append([lst for lst in result if lst!=[]])
    #     return result
    #

    # def var(self,name):
    #     type,value = self.findItem(name)
    #     return self.dumpObject(name,type,value)


    # def storeObject(self,type,obj,name=''):
    #     for lst in self.history:
    #         for n,t,v in lst:
    #             if t==type:
    #                 if self.dumpObject(type,obj)==self.dumpObject(type,v):
    #                     print '  ' + n
    #                     return []
    #     self.count[type] += 1
    #     if name == '': name = type + str(self.count[type])
    #     print '  ' + name + ' = ' + self.dumpObject(type,obj)
    #     return [name,type,obj]

    # def storeNumber(self, n, name=''): return self.storeObject('N',n,name)
    # def storePoint(self, p, name=''): return self.storeObject('P',p,name)
    # def storeAngle(self, a, name=''): return self.storeObject('A',a,name)
    # def storeCircle(self, c, name=''): return self.storeObject('C',c,name)
    # def storeLine(self, line): return self.storeObject('L',self.normalizeLine(line))
    # def storeTriangle(self, tri): return self.storeObject('T',self.normalizeTriangle(tri))

    # def getObject(self,item,arr):
    #     klassname = item.__class__.__name__
    #     if klassname == 'Circle':
    #         if len(arr)==0: return ['C',item]
    #         elif arr[0]=='X': return ['N',item.center.x]
    #         elif arr[0]=='Y': return ['N',item.center.y]
    #         elif arr[0]=='R': return ['N',item.radius]
    #         elif arr[0]=='AREA': return ['N',item.area]
    #     elif klassname == 'Point2D':
    #         if len(arr)==0: return ['P',item]

    # def getItem(self,name):  # klarar punktnotation med flera punkter
    #     arr = name.split('.')
    #     lst = self.findItem(arr[0])
    #     if lst == None: return None
    #     if len(arr) == 1: return lst
    #     item = lst[1]
    #     klassname = item.__class__.__name__
    #     if klassname == 'Triangle':
    #         if arr[1]=='A': return ['*',[a*180/pi for a in item.angles.values()]] # just print
    #         elif arr[1]=='A0': return ['A',item.angles.values()[0]*180/pi]
    #         elif arr[1]=='A1': return ['A',item.angles.values()[1]*180/pi]
    #         elif arr[1]=='A2': return ['A',item.angles.values()[2]*180/pi]
    #         elif arr[1]=='P': return ['*',item.vertices]
    #         elif arr[1]=='P0': return ['P',item.vertices[0]]
    #         elif arr[1]=='P1': return ['P',item.vertices[1]]
    #         elif arr[1]=='P2': return ['P',item.vertices[2]]
    #         elif arr[1]=='S':  return ['*',[s.length for s in item.sides]]
    #         elif arr[1]=='S0': return ['N',item.sides[0].length]
    #         elif arr[1]=='S1': return ['N',item.sides[1].length]
    #         elif arr[1]=='S2': return ['N',item.sides[2].length]
    #         elif arr[1]=='M':  return self.getObject(item.centroid,arr[2:])
    #         elif arr[1]=='IC': return self.getObject(item.incircle,arr[2:])
    #         elif arr[1]=='OC': return self.getObject(item.circumcircle,arr[2:])
    #         elif arr[1]=='AREA': return ['N',item.area]
    #     elif klassname == 'Line':
    #         if arr[1]=='L': return ['N',Segment(item.p1,item.p2).length]
    #     elif klassname == 'Circle':
    #         return self.getObject(item,arr[1:])
    #     return None

    # def findItem(self,name):
    #     for lst in self.history:
    #         for key,type,value in lst:
    #             if name == key: return [type,value]
    #     return None

