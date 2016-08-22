// Fraktal matta baserad på fibonaccital

//var arrlen = [10946,6765,4181,2584,1597,987,610,377,233,144,89,55,34,21,13,8,5,3,2,1,1]
var arrlen = [144,89,55,34,21,13,8,5,3,2,1,1]
var xo=0
var yo=0
var points = {}
var factor=1

function mytranslate(dx,dy) {
  xo = round(xo+dx)
  yo = round(yo+dy)
  translate(dx,dy)
}

function setpoint(angle, size) {
  x = round(xo + size*cos(angle*HALF_PI))
  y = round(yo + size*sin(angle*HALF_PI))
  key = x.toString() + "," + y.toString()
  if (!(key in points)) points[key] = [x,y,0]
  points[key][2] |= Math.pow(2,angle)      //för binära flaggor
}

function generation(size) {
  for (key in points) {
    var point = points[key]  // [x,y,flags]
    mytranslate(point[0]-xo, point[1]-yo)
    for (var i = 0; i < 4; i++) {
      if (factor%2==1) translate(0,-1)
      if ((point[2] & 1<<i) == 0) {
        line(0,0,-factor*size,0)
        setpoint((i+2)%4, factor*size)
        setpoint(i, 0)
      }
      rotate(HALF_PI)
    }
  }
  console.log(Object.keys(points).length)
}

function setup() {
  createCanvas(1280,1280)
  background(255)
  strokeWeight(factor)
  stroke(0)
  mytranslate(width/2,height/2)
  points["640,640"] = [xo,yo,0]
  for (var g=0; g<5; g++) {
    console.log("Generation " + (g+1).toString() + ": ")
    generation(arrlen[g])  // 13
  }
}