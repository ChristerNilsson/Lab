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
EXACT = True

# vinklar, pyth, prop och bandpunkter är hjälprutiner för att lösa vanligt förekommande delproblem.

def ass(a,b):
    if a!=b:
        print a
        print b
        assert a==b
    return a==b

def vinkel(p0,p1,p2):
    l0 = Line(p1,p0)
    l1 = Line(p1,p2)
    a = Line.angle_between(l0,l1)
    return a
a,b,c = Point(-1,1),Point(0,1),Point(1,1)
d,e,f = Point(-1,0),Point(0,0),Point(1,0)
assert vinkel(a,b,c) == pi
assert vinkel(b,c,f) == pi/2
assert vinkel(a,b,f) == 3*pi/4
assert vinkel(a,e,c) == pi/2
assert vinkel(a,d,a) == 0
assert vinkel(b,f,c) == pi/4
def vinkel2(p0,p1,p2): # Komplementvinkel
    l0 = Line(p1,p0)
    l1 = Line(p1,p2)
    a = Line.angle_between(l0,l1)
    return pi-a

def pyth(a,b,h): # tre sidor givna
    x = Symbol('x')
    return abs(solve(a*a+b*b-h*h,x)[0])
x = Symbol('x')
assert pyth(x,4,5)==3
assert pyth(3,x,5)==4
assert pyth(3,4,x)==5
def pyth2(a,b,h): # tre sidor givna. Den andra roten
    x = Symbol('x')
    return abs(solve(a*a+b*b-h*h,x)[1])

def prop(a,b,c,d): # a/b==c/d
    x = Symbol('x')
    return solve(S(a)/b-S(c)/d,x)[0]
x = Symbol('x')
assert prop(x,8,3,4) == 6
assert prop(6,x,3,4) == 8
assert prop(6,8,x,4) == 3
assert prop(6,8,3,x) == 4

def bandpunkter(a,b): # Mellan två cirklar. a är större
    if a.radius == b.radius: return []
    if a.radius < b.radius: a,b=b,a
    mittlinje = Line(a.center,b.center)
    d = a.center.distance(b.center)

    res = []

    r1 = d * a.radius / (b.radius-a.radius)
    c1 = Circle(a.center,r1)
    z = intersection(mittlinje,c1)
    res.append(z[1])

    if d >= a.radius + b.radius:
        r2 = d * a.radius/b.radius / (1 + a.radius/b.radius)
        c2 = Circle(a.center,r2)
        res.append(intersection(mittlinje,c2)[1])
    return res

def dumpGeo(hash):
    res = []
    trans = {'Point2D':'p', 'Line':'l', 'Circle':'c', 'Triangle':'t'}
    for name in hash:
        obj = hash[name]
        klassnamn = obj.__class__.__name__
        if klassnamn in trans:
            s = trans[klassnamn]
            lst = []
            if s == "p": lst = [obj.x,obj.y]
            elif s == "l": lst = [obj.p1.x,obj.p1.y,obj.p2.x,obj.p2.y]
            elif s == "c": lst = [obj.center.x,obj.center.y,obj.radius]
            elif s == "t":
                a,b,c = obj.vertices
                lst = [a.x,a.y,b.x,b.y,c.x,c.y]
            if lst != []: res.append([name,[N(item) for item in lst]])
    f = open("lab\data.json", "w")
    f.write("{\n" + ",\n".join(['  "'+name+'":'+str(lst) for name,lst in res]) + "\n}")
    f.close()

class Calculator:
    def __init__(self):
        self.reset()

    def reset(self):
        self.start = time.time()
        self.counters = {}
        self.locals = {}
        self.droplist = []
        self.locals['O'] = Point2D(0,0)
        self.locals['X'] = Line(Point2D(0,0),Point2D(1,0))
        self.locals['Y'] = Line(Point2D(0,0),Point2D(0,1))
        self.history = [['Original',['O','X','Y']]]
        self.decs = 3  # 0 = sym, 1-oo = num
        self.dumpGeometry()

    def help(self):
        print "Exempel:"
        print "O        => Origo"
        print "X        => x-axeln"
        print "Y        => y-axeln"
        print "1 1      => Punkten p0"
        print "p0 p1    => Linjen l0"
        print "p0.distance(p1) => Distans"
        print "p0 l0    => Vinkelrät linje l1"
        print "p0 1     => Cirkel c0"
        print "p0 p1 p2 => Triangel t0"
        print "3 4 5    => Triangel t1"
        print "c0 p0    => Tangentlinjer l2 och l3"
        print "l0 l1    => Skärningspunkter 0,1 eller Linje"
        print "l0 c0    => Skärningspunkter 0,1 eller 2"
        print "l0 t0    => Skärningspunkter 0,1 eller 2"
        print "c0 c1    => Skärningspunkter 0,1,2 eller Cirkel. En eller två bandpunkter kan tillkomma"
        print "c0 t0    => Skärningspunkter 0,1,2,3,4,5 eller 6"
        print "t0 t1    => Skärningspunkter 0,1,2,3,4,5,6 eller Triangel"
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
        print
        print "pythagoras(x,4,5) => 3"
        print "pythagoras(3,x,5) => 4"
        print "pythagoras(3,4,x) => 5"
        print "vinkel(p0,p1,p2) => vinkel mellan p0 och p2 i radianer"
        print "bandpunkter(c0,c1) => Två punkter i samband med cirklar och remband"
        print
        print "0        => Exakt visning, t ex sqrt(2)"
        print "1-99     => Numerisk visning med angivet antal värdesiffror, t ex 1.41"
        print "undo     => Ångra senaste kommandot"
        print "clear    => Rensa allt"
        print "Starta index.html med P5 för att se grafik."
        print "För mer information, se http://docs.sympy.org"

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
        elif type == 'assert': return str(value)
        elif type == 'd':
            pass
        else:
            return 'Error in dumpObject'

    def dump(self):
        for cmd,names in self.history:
            print "  #",cmd
            for name in names:
                print "  ",name,'=', self.dumpObject(self.locals[name])

    def dumpGeometry(self):
        res = []
        for cmd,names in self.history:
            for name in names:
                if name in self.droplist: continue
                obj = self.locals[name]
                s = self.getSignature(obj)
                lst = []
                if s == "p": lst = [obj.x,obj.y]
                elif s == "l": lst = [obj.p1.x,obj.p1.y,obj.p2.x,obj.p2.y]
                elif s == "c": lst = [obj.center.x,obj.center.y,obj.radius]
                elif s == "t":
                    a,b,c = obj.vertices
                    lst = [a.x,a.y,b.x,b.y,c.x,c.y]
                if lst != []: res.append([name,[N(item) for item in lst]])
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
        elif s == "acos": return "a"
        elif s == "bool": return "assert"
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

    def exact(self,obj):
        if EXACT: return obj
        type = self.getSignature(obj)
        if type == 'n': return N(obj)
        if type == 'c': return Circle(Point(N(obj.center.x),N(obj.center.y)),N(obj.radius))
        if type == 'p': return Point(N(obj.x),N(obj.y))
        if type == 'l': return Line(Point(N(obj.p1.x),N(obj.p1.y)),Point(N(obj.p2.x),N(obj.p2.y)))
        return obj

    def exist(self,obj):
        t = self.getSignature(obj)
        for cmd,names in self.history:
            for name in names:
                v = self.locals[name]
                type = self.getSignature(v)
                if t == type:
                    if self.dumpObject(obj)==self.dumpObject(v):
                        return name
        return None

    def do(self,commands):
        # print commands
        arr = commands.split()
        if commands == '':
            self.dump()
            return ''
        elif commands == '?':
            self.help()
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
        elif arr[0] == 'drop':
            for name in arr[1:]:
                self.droplist.append(name)
            self.dumpGeometry()
            return ''

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
        elif signature in 'll cl lc tt ct tc lt tl'.split(): obj = intersection(a,b)
        elif signature == 'cc': obj = intersection(a,b) # Normala skärningspunkter

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
        res_names = []
        if isinstance(obj,list) or isinstance(obj,tuple):
            for o in obj:
                if self.exist(o) == None:
                    name = self.getName(o)
                    res_names.append(name)
                    self.locals[name] = self.exact(o)
                    result.append(name)
        elif isinstance(obj,dict):
            for o in obj.values():
                if self.exist(o) == None:
                    name = self.getName(o,"a")
                    res_names.append(name)
                    self.locals[name] = o
                    result.append(name)
        else:
            t = self.getSignature(obj)
            if t == 'l': obj = self.normalizeLine(obj)
            if t == 't': obj = self.normalizeTriangle(obj)
            name = self.exist(obj)
            if name != None:
                print '  ' + name
                return []

            name = self.getName(obj)
            res_names.append(name)
            self.locals[name] = self.exact(obj)
            result.append(name)
        s = "  " + "\n  ".join([name + " = " + self.dumpObject(self.locals[name]) for name in result])
        print s
        self.history.append([commands,res_names])
        self.dumpGeometry()
        #calc.ready()
        return s

    def run(self):
        print "Mata in ett ? eller ett kommando:"
        while True:
            commands = raw_input()
            try:
                self.do(commands)
            except Exception as e:
                print "  Error: " + e.message

    def ready(self):
        print "  " + str(round(time.time()-self.start,3)) + "s"

    def batch(self,lines):
        lines = lines.split('\n')
        for line in lines:
            commands = line.split('#')
            commands = commands[0].strip()
            if commands!='':
                self.do(commands)
        #self.ready()

def solve_problem():
    start = time.time()
    # stoppa in pythonkod här.
    dumpGeo(locals())
    print time.time()-start

if __name__ == "__main__":
    calc = Calculator()
    # solve_problem()
    calc.batch("""    # stoppa in kommandon här
    """)
    calc.run()
