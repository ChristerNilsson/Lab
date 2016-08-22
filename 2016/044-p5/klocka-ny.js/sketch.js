function setup() {
  createCanvas(1000,1000)
  background(255,0,0)
  angleMode(DEGREES)
}

function draw() {
  translate(width/2,height/2)
  ellipse(0,0,1000,1000)
  vinkel = map(second(),0,60,0,360)
  console.log(vinkel)
  rotate(vinkel-90)
  strokeWeight(5)
  line(0,0,400,0)
}