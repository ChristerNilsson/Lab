// Ritar en analog klocka

// - rita minut och timvisare som rör sig jämnt

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

function visare(tid,antal,längd,tjocklek) {
  push()
  rotate(map(tid,0,antal,0,360)-90)
  strokeWeight(tjocklek)
  line(-10,0,längd,0)
  pop() 
}

function draw() { 
  background(200) 
  translate(width/2,height/2)
  urtavla()
  visare(second(),60,200,1)
  visare(minute()+second()/60.0,60,200,5)
  visare(hour()+minute()/60.0,12,150,5)
}
