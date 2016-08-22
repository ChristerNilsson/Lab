// 044 klocka-object
// Ritar analoga klockor, objektorienterat

// - rita minut och timvisare som inte hoppar

function setup() { 
  createCanvas(600,600) 
  angleMode(DEGREES)
  stroke(0)
  klockor=[]
  klockor.push(new Klocka(1000,1000,5))
  klockor.push(new Klocka(400,400,0.8))
  klockor.push(new Klocka(100,100,0.3))
  klockor.push(new Klocka(200,100,0.1))
  klockor.push(new Klocka(400,100,0.05))
}

function Klocka (x,y,storlek) {
  this.x=x
  this.y=y
  this.storlek=storlek

  this.urtavla = function() {
    noFill()
    ellipse(0,0,440,440)
    for (i of _.range(60)) {
      strokeWeight(i%5==0 ? 3 : 1)
      line(i%5==0 ? 200 : 210,0,220,0)
      rotate(6)
    }
  }
  
  this.visare = function(tid,antal,längd,tjocklek) {
    push()
    rotate(map(tid,0,antal,0,360)-90)
    strokeWeight(tjocklek)
    line(-0.1*längd,0,längd,0)
    pop() 
  }
  
  this.rita = function() {
    push()
    translate(this.x,this.y)
    scale(this.storlek)
    this.urtavla()
    this.visare(second(),60,200,5)
    this.visare(minute()+second()/60.0,60,200,10)
    this.visare(hour()+minute()/60.0,12,150,10)
    pop()
  }
} 

function draw() { 
  background(200) 
  for (klocka of klockor) klocka.rita()
}