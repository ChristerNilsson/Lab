from sympy import *

H = 10

class Svg:


    def __init__(self):
        self.objects = {}
        self.f = open('svg.html','w')

    def close(self):
        self.draw()
        self.f.close()

    def append(self,obj,name,i=-1):
        if i!=-1:
            name = str(i)+ name
        self.objects[name] = obj

    def draw_name(self,x,y,name):
        self.f.write('<text x={0} y={1} font-size="0.25px" text-anchor="middle" alignment-baseline="middle" >{2}</text>\n'.format(x,y,name))

    def draw(self):
        self.f.write( '<svg  height="1000" width="1000" viewBox="-5 0 10 {0}">\n'.format(10))
        for name in self.objects.keys():
            obj = self.objects[name]
            klass = obj.__class__.__name__
            if klass == 'Circle':
                self.f.write( '<circle cx={0} cy={1} r={2} stroke="black" fill="none" stroke-width=0.01 />\n'.format(N(obj.center.x),H-N(obj.center.y),N(obj.radius)))
                self.draw_name(N(obj.center.x),H-N(obj.center.y),name)
            elif klass == 'Line':
                self.f.write( '<line x1={0} y1={1} x2={2} y2={3} stroke="black" stroke-width=0.01 />\n'.format(N(obj.p1.x), H-N(obj.p1.y), N(obj.p2.x), H-N(obj.p2.y)))
                x = (N(obj.p1.x) + N(obj.p2.x))/2.0
                y = H - (N(obj.p1.y) + N(obj.p2.y))/2.0
                self.draw_name(x,y,name)
            elif klass == 'Point2D':
                self.draw_name(N(obj.x),H-N(obj.y),name)
            elif klass == 'Triangle':
                a = obj.vertices[0]
                b = obj.vertices[1]
                c = obj.vertices[2]
                self.f.write( '<line x1={0} y1={1} x2={2} y2={3} stroke="black" stroke-width=0.01 />\n'.format(N(a.x), H-N(a.y), N(b.x), H-N(b.y)))
                self.f.write( '<line x1={0} y1={1} x2={2} y2={3} stroke="black" stroke-width=0.01 />\n'.format(N(b.x), H-N(b.y), N(c.x), H-N(c.y)))
                self.f.write( '<line x1={0} y1={1} x2={2} y2={3} stroke="black" stroke-width=0.01 />\n'.format(N(c.x), H-N(c.y), N(a.x), H-N(a.y)))

        self.f.write('</svg>\n')

        for name in sorted(self.objects.keys()):
            obj = self.objects[name]
            klass = obj.__class__.__name__
            if klass == 'Circle':
                self.f.write('<br>'+name+' '+ klass)
                self.f.write( '<br>&nbsp;x: {0} = {1}\n'.format(obj.center.x, N(obj.center.x)))
                self.f.write( '<br>&nbsp;y: {0} = {1}\n'.format(obj.center.y, N(obj.center.y)))
                self.f.write( '<br>&nbsp;r: {0} = {1}\n'.format(obj.radius, N(obj.radius)))
            elif klass == 'Line':
                self.f.write('<br>'+name + ' ' + klass)
                self.f.write( '<br>&nbsp;p1.x: {0} = {1}\n'.format(obj.p1.x, N(obj.p1.x)))
                self.f.write( '<br>&nbsp;p1.y: {0} = {1}\n'.format(obj.p1.y, N(obj.p1.y)))
                self.f.write( '<br>&nbsp;p2.x: {0} = {1}\n'.format(obj.p2.x, N(obj.p2.x)))
                self.f.write( '<br>&nbsp;p2.y: {0} = {1}\n'.format(obj.p2.y, N(obj.p2.y)))
            elif klass == 'Point2D':
                self.f.write('<br>'+name + ' '+ klass)
                self.f.write('<br>&nbsp;x: {0} = {1}\n'.format(obj.x, N(obj.x)))
                self.f.write('<br>&nbsp;y: {0} = {1}\n'.format(obj.y, N(obj.y)))
            elif klass == 'Triangle':
                a = obj.vertices[0]
                b = obj.vertices[1]
                c = obj.vertices[2]
                self.f.write('<br>'+name + ' '+ klass)
                self.f.write('<br>&nbsp;a.x: {0} = {1}\n'.format(a.x, N(a.x)))
                self.f.write('<br>&nbsp;a.y: {0} = {1}\n'.format(a.y, N(a.y)))
                self.f.write('<br>&nbsp;b.x: {0} = {1}\n'.format(b.x, N(b.x)))
                self.f.write('<br>&nbsp;b.y: {0} = {1}\n'.format(b.y, N(b.y)))
                self.f.write('<br>&nbsp;c.x: {0} = {1}\n'.format(c.x, N(c.x)))
                self.f.write('<br>&nbsp;c.y: {0} = {1}\n'.format(c.y, N(c.y)))
