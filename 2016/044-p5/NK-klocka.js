function setup() { 
  createCanvas(600,600,WEBGL) 
  setupBee()
}

function urtavla() {
  texture(pgz)
  sphere(15)
  torus(300,10,60)
  for (var i=0; i<60; i++) {
    push()
    texture(pgz)
    if (i%5==0) {
      fwd(240)
      //låda(20,5,5)
      cyl(20,5)
    } else {
      fwd(260)
      //låda(10,2,2)
      cyl(10,2)
    }
    pop()
    yaw(6)
  }
}

function visare(vinkel,tjocklek,längd) {
  push()
  yaw(vinkel-90)
  fwd(-längd*0.2)
  texture(pgx)
  //låda(längd*1.2,tjocklek,2)
  cyl(längd*1.2,tjocklek)
  pop()
}

function draw() { 
  pitch(mouseX*0.2)
  roll(mouseY*0.2-180)
  origin()
  //pitch(frameCount)
  visare(second()*6,3,125)
  visare((minute()+second()/60) * 6,9,125)
  visare((hour()+minute()/60)*30,12,90)
  urtavla()
}
