f = open("water.html",'w')

def p(x):
    f.write(x + '\n')

def line(x1,y1,x2,y2):
    f.write('  <line x1={0} y1={1} x2={2} y2={3} />\n'.format(x1+40,y1+40,x2+40,y2+40))

def text(x,y,msg):
    f.write('  <text x={0} y={1}>{2}</text>\n'.format(x+40,y+40,msg))

dx = 150
dy = 150

p('<!DOCTYPE html>')
p('<html>')

p(' <head>')
p('  <style>')
p('   line { stroke: #000000; stroke-width:2; }')
p('   text { fill: #000000; font-size: 25px; text-anchor: middle; }')
p('  </style>')
p(' </head>')

p(" <body>")
p('  <svg width="1100" height="600">')

for j in range(0,4):
    text(dx*(1.5-j*0.5) - 20, dy*j+5, 3-j)
    line(dx*(1.5-j*0.5), dy*j, dx*(1.5-j*0.5+5), dy*j)
    text(dx*(1.5-j*0.5) - 40, dy*j+5, "NDJ "[j])
    text(dx*(1.5-j*0.5+5) + 20, dy*j+5, " EKA "[j])

for i in range(0,6):
    text(dx*(5-i), 3*dy+20, 5-i)
    line(dx*(5-i + 1.5), 0, 5*dx-i*dx, 3*dy)
    text(dx*(5-i + 1.5), -5,"NHBLF "[5-i])
    text(dx*(5-i), 3*dy+40, " ICMGA"[5-i])

for i in range(0,5):
    for j in range(0,3):
        line(dx*(1.5+i-j*0.5), dy*j, dx*(1.5+i-j*0.5+0.5), dy*j+dy)

p ("  </svg>")
p (" </body>")
p ("</html>")

f.close()