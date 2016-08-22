// 043-phyllotaxis
// Ritar en solros mha fibonacci
// https://www.youtube.com/watch?v=KWoJgHFYWxY
// 137.5 = 0.618 * 0.618 * 360
var n = 0
var c = 6
var phi = 137.5077640500378546463487

function setup() {
  createCanvas(1000,1000)
  background(0)
  angleMode(DEGREES)
}

function draw() {
  frameRate(mouseX)
  var a = n*phi
  var r = c*sqrt(n)
  var x = r*cos(a) + width/2
  var y = r*sin(a) + height/2
  ellipse(x,y,10,10)
  n++
}

function mousePressed() {
  background(0)
  n=0
}