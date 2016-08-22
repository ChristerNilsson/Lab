// Ritar en analog klocka i 3D

function setup() { 
  createCanvas(600,600,WEBGL) 
}

function urtavla() {
  torus(400,10)
  for (var i of _.range(60)) {
    push()
    if (i%5==0) {
      translate(0,380)
      cylinder(5, 20, 30)
    } else {
      translate(0,390)
      cylinder(3, 10, 30)
    }
    pop()
    rotateZ(PI/30)
  }
}

function visare(tid,antal,längd,tjocklek,z) {
  push()
  rotateZ(map(tid,0,antal,0,TWO_PI))
  translate(0,längd*0.8,z)
  box(tjocklek,längd,2)
  pop() 
}

function draw() { 
  background(200) 
  rotateX(mouseY/height*PI)
  rotateY(mouseX/width*PI)
  urtavla()
  rotateX(PI)
  visare(second(),              60,200, 5,-10)
  visare(minute()+second()/60.0,60,200,10,0)
  visare(hour()+minute()/60.0,  12,160,10,10)
}