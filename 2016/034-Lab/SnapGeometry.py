from sympy import * # Point,Line,Circle,Triangle,intersection,S

N_WORDS = "Integer int Float Pow Mul Add Pi Half".split()

def check(a,b=''):
    res = snap.do(a)
    if res != b:
        print res
        print b
        assert False

class Snap:

    def __init__(self):
        self.counters = {}
        self.locals = {}
        self.history = []

    def getSignature(self,obj):
        s = obj.__class__.__name__
        if s in N_WORDS: s = 'n'
        elif s == "Triangle": s = "t"
        elif s == "Point2D": s = "p"
        elif s == "Circle": s = "c"
        elif s == "Line": s = "l"
        elif s == "dict": s = "d"
        return s

    def dump(self):
        print
        for cmd,names in self.history:
            print cmd
            for name in names:
                print "  ",name,'=',self.locals[name]

    def dumpGeometry(self):
        print
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
        print "{"
        print ",\n".join(['  "'+name+'":'+str(lst) for name,lst in res])
        print "}"

    def getName(self,obj,type=''):
        if type == '': type = self.getSignature(obj)
        if type not in self.counters: self.counters[type] = -1
        self.counters[type] += 1
        return type + str(self.counters[type])

    def do(self,s):
        arr = s.split()
        res = []
        signature = ""
        for cmd in arr:
            obj = eval(cmd,None,self.locals)
            res.append(obj)
            signature += self.getSignature(obj)

        if len(res)>0: a = res[0]
        if len(res)>1: b = res[1]
        if len(res)>2: c = res[2]

        if signature == 'nn':   obj = Point(a,b)
        elif signature == 'd': obj = a
        elif signature == 'pp': obj = Line(a,b)
        elif signature == 'pn': obj = Circle(a,b)
        elif signature == 'np': obj = Circle(b,a)
        elif signature == 'cc': obj = intersection(a,b)
        elif signature == 'ppp': obj = Triangle(a,b,c)

        result = ""
        names = []
        if isinstance(obj,list):
            for o in obj:
                name = self.getName(o)
                names.append(name)
                self.locals[name] = o
                result += name + "=" + str(o) + " "
        elif isinstance(obj,dict):
            for o in obj.values():
                name = self.getName(o,'a')
                names.append(name)
                self.locals[name] = o
                result += name + "=" + str(o) + " "
        else:
            name = self.getName(obj)
            names.append(name)
            self.locals[name] = obj
            result += name + "=" + str(obj) + " "
        self.history.append([s,names])
        return result.strip()

snap = Snap()

check('-5 0','p0=Point2D(-5, 0)')
check('5 0','p1=Point2D(5, 0)')
check('p0 10','c0=Circle(Point2D(-5, 0), 10)')
check('p1 10','c1=Circle(Point2D(5, 0), 10)')
check('c0 c1','p2=Point2D(0, 5*sqrt(3)) p3=Point2D(0, -5*sqrt(3))')
check('p0 p1 p2','t0=Triangle(Point2D(-5, 0), Point2D(5, 0), Point2D(0, 5*sqrt(3)))')
check('p0 5','c2=Circle(Point2D(-5, 0), 5)')
check('t0.area-c2.area*3/6','n0=-25*pi/2 + 25*sqrt(3)')
check('c0.circumference','n1=20*pi')
check('t0.perimeter','n2=30')
check('t0.angles','a0=pi/3 a1=pi/3 a2=pi/3')

snap.dump()

snap.dumpGeometry()