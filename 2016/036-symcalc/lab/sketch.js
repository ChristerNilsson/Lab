WIDTH = 700
HEIGHT = 700

function f(x) {
  return map(x,xmin,xmax,0,WIDTH)
}

function g(y) {
  return map(y,ymax,ymin,0,HEIGHT)
}

function h(r) {
  return map(r,0,xmax-xmin,0,WIDTH)
}

function init_xmin_xmax_ymin_ymax() {
  // calculate xmin, xmax, ymin, ymax
  xmin=0
  xmax=0
  ymin=0
  ymax=0
  
  for (var key in data) {
    var value = data[key]
    if (value.type=='P') {
      xmin=min(xmin,(value.x))
      xmax=max(xmax,(value.x))
      ymin=min(ymin,(value.y))
      ymax=max(ymax,(value.y))
    }
  }
  
  var n = Object.keys(data).length
  
  var dx = xmax-xmin
  var dy = ymax-ymin
  var d = max(dx,dy) * 1.1
  if (d == 0) d=1
  var cx = (xmin+xmax)/2.0
  var cy = (ymin+ymax)/2.0
  xmin = cx-d/2.0
  xmax = cx+d/2.0
  ymin = cy-d/2.0
  ymax = cy+d/2.0
}

function setup() {
  createCanvas(WIDTH,HEIGHT) 
  textSize(16)
  mymouse = new p5.Vector(0,0)
  init_xmin_xmax_ymin_ymax()
}

function cirkel(name,o) {  // RED
  var x=f(o.x)
  var y=g(o.y)
  var r = h(o.radius)
  strokeWeight(2); stroke(255,0,0); noFill(); ellipse(x,y,2*r,2*r)
  noStroke(); fill(255,0,0); textAlign(LEFT,BOTTOM); text(name, x, y-abs(r))
}

function triangel(name,o) {  // WHITE
  var x1=f(o.x1), y1=g(o.y1)
  var x2=f(o.x2), y2=g(o.y2)
  var x3=f(o.x3), y3=g(o.y3)
  strokeWeight(2); stroke(255); noFill(); triangle(x1,y1,x2,y2,x3,y3)
  noStroke(); fill(255); textAlign(LEFT,BOTTOM); text(name, (x1+x2+x3)/3, (y1+y2+y3)/3)
}

function punkt(name,x,y) { // GREEN
  var x=f(x), y=g(y)
  if (name!='') {
    strokeWeight(4); stroke(0,255,0); noFill(); point(x,y)
    noStroke(); fill(0,255,0); textAlign(RIGHT,TOP); text(name, x, y)
  }
  return [x,y,name]
}

function linje(name,o) { // YELLOW
  var x1=f(o.x1), y1=g(o.y1)
  var x2=f(o.x2), y2=g(o.y2)
  var dx = 10*(x2-x1)
  var dy = 10*(y2-y1)
  strokeWeight(2); stroke(255,255,0); line(x1-dx,y1-dy,x1+dx,y1+dy)
  noStroke(); fill(255,255,0); textAlign(RIGHT,BOTTOM); text(name, (x1+x2)/2, (y1+y2)/2)
}

function coordx(name,p1,p2,thick) { // BLACK
  var x1=p1[0], y1=p1[1] 
  var x2=p2[0], y2=p2[1]
  if (thick) {
    strokeWeight(3) 
  } else {
    strokeWeight(1)
  }
  stroke(0); line(x1,y1,x2,y2)
  noStroke(); fill(0); textAlign(RIGHT,BOTTOM); text(name, x1, height)  // g(y0)
}

function coordy(name,p1,p2,thick) { // BLACK
  var x1=p1[0], y1=p1[1] 
  var x2=p2[0], y2=p2[1]
  if (thick) {
    strokeWeight(3) 
  } else {
    strokeWeight(1)
  }
  stroke(0); line(x1,y1,x2,y2)
  noStroke(); fill(0); textAlign(LEFT,BOTTOM); text(name, 0, y1)  // f(x0)
}

function coords(c,d) { // c är centrum, d är max-min
   var avst = 100000
   while (avst > d) {
       var dec = round(Math.log10(avst)*100)/100  // orsak till loopen: sträng här
       while (dec < 0.0) dec += 1
       dec = dec.toString()
       var last = avst
       if (dec.indexOf('.7') != -1) {
         avst /= 2.5
       } else {
         avst /= 2.0
       } 
   }
   var delta = last/10 ///2
   var s = delta.toString()
   decimals = 0
   if (delta < 1) decimals = s.length-2
   var closest = (round(c/delta)*delta) //.toFixed(6)
   return [closest,delta]
}

function calc_coord() {
  
  // decide delta and where to print axis labels.
  cx = (xmin+xmax)/2
  cy = (ymin+ymax)/2
  var d = xmax-xmin
  
  var lst = coords(cx,d)
  x0 = lst[0]
  var dx = lst[1]
  while (x0 > xmin) x0 -= dx
  x0 += dx

  lst = coords(cy,d)
  y0 = lst[0]
  var dy = lst[1]
  while (y0 > ymin) y0 -= dy
  y0 += dy
  
  delta = dx
}

function coordinates() {
  var x=x0
  while (x<xmax) {
    var flag = x < delta/2 && x > -delta/2
    coordx(x.toFixed(decimals), punkt('',x,ymin), punkt('',x,ymax),flag)
    x+=delta
  }
  var y=y0
  while (y<ymax) {
    var flag = y < delta/2 && y > -delta/2
    coordy(' '+y.toFixed(decimals), punkt('',xmin,y), punkt('',xmax,y),flag)
    y+=delta
  }
}

function draw() {
  mydraw()
}

function mydraw() {
  background(128)
  scale(1)
  strokeWeight(1); 
  calc_coord(); 
  coordinates(); 
  strokeWeight(2)
  for (name in data) {
    var o = data[name]
    if (o.type == 'L') linje(name,o)
    if (o.type == 'T') triangel(name,o)
    if (o.type == 'C') cirkel(name,o)
  }
  for (name in data) {
    var o = data[name]
    if (o.type == 'P') punkt(name,o.x,o.y)
  }
}

function mouseWheel(event) {
  var x = map(winMouseX,0,WIDTH,xmin,xmax)
  var y = map(winMouseY,HEIGHT,0,ymin,ymax)
  var factor = 1-event.delta*0.001
  xmin = x - (x-xmin) * factor
  xmax = x - (x-xmax) * factor
  ymin = y - (y-ymin) * factor
  ymax = y - (y-ymax) * factor
}

function mousePressed(event) {
  mymouse.set(winMouseX, winMouseY)
  xmin0=xmin
  xmax0=xmax
  ymin0=ymin
  ymax0=ymax
}

function keyPressed(event) {
  mydraw()
}

function mouseDragged(event) {
  var dx = map(mymouse.x - winMouseX,0,WIDTH,0,xmax0-xmin0)
  var dy = map(mymouse.y - winMouseY,0,HEIGHT,0,ymax0-ymin0)
  xmin = xmin0 + dx
  xmax = xmax0 + dx
  ymin = ymin0 - dy
  ymax = ymax0 - dy
}
