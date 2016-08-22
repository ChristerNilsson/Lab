// klocka-smooth.js

function setup() { 
  createCanvas(600,600) 
  angleMode(DEGREES)
  stroke(0)
  //scale(0.5)
}

function urtavla() {
  noFill()
  ellipse(0,0,440,440)
  for (var i of _.range(60)) {
    strokeWeight(i%5==0 ? 3 : 1)
    line(i%5==0 ? 210 : 200,0,220,0)
    rotate(6)
  }
}

function visare(tid,antal,längd,tjocklek,färg) {
  push()
  rotate(map(tid,0,antal,0,360)-90)
  strokeWeight(tjocklek)
  stroke(färg)
  line(-10,0,längd,0)
  pop() 
}

function draw() { 
  background(200) 
  translate(width/2,height/2)
  urtavla()
  var d = new Date()
  var millisecond = d.getMilliseconds()
  var second = d.getSeconds()
  var minute = d.getMinutes()
  var hour = d.getHours()
  visare(hour+minute/60.0,         12, 150,15,color(0,0,255,128))
  visare(minute+second/60.0,       60, 200,15,color(0,255,0,128))
  visare(second+millisecond/1000.0,60, 210,10,color(255,0,0,0))
}