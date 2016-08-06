// 044 klocka-lista
// Ritar flera analoga klockor

function setup() { 
  createCanvas(600,600) 
  angleMode(DEGREES)
  stroke(0)
  klockor=[]
  klockor.push([1000,1000,5])
  klockor.push([400,400,0.8])
  klockor.push([100,100,0.3])
  klockor.push([200,100,0.1])
  klockor.push([400,100,0.05])
}

function urtavla() {
  noFill()
  ellipse(0,0,440,440)
  for (i of _.range(60)) {
    strokeWeight(i%5==0 ? 3 : 1)
    line(i%5==0 ? 200 : 210,0,220,0)
    rotate(6)
  }
}
  
function visare(tid,antal,längd,tjocklek) {
  push()
  rotate(map(tid,0,antal,0,360)-90)
  strokeWeight(tjocklek)
  line(-0.1*längd,0,längd,0)
  pop() 
}
  
function rita(klocka) {
  var x = klocka[0]
  var y = klocka[1]
  var storlek = klocka[2]
  push()
  translate(x,y)
  scale(storlek)
  this.urtavla()
  this.visare(second(),60,200,5)
  this.visare(minute()+second()/60.0,60,200,10)
  this.visare(hour()+minute()/60.0,12,150,10)
  pop()
}

function draw() { 
  background(200) 
  for (klocka of klockor) rita(klocka)
}