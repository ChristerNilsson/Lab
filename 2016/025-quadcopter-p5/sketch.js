// Christers 3D quadcopter design
// todo: Colors

function setup() {
  createCanvas(1000, 1000, WEBGL);
}

function draw() {
  background(128);
  x1 = -100
  x2 = 100
  z1 = -100
  z2 = 100
  size = 100

  rotateZ(mouseX/200)
  rotateY(mouseY/200)
  ellipsoid(size/2,size,size/4)
  translate(0,0,-50)
  propeller(x1,z1,size,frameCount)
  propeller(x1,z2,size,-frameCount)
  propeller(x2,z1,size,-frameCount)
  propeller(x2,z2,size,frameCount)
  rotateY(-mouseY/200)
  rotateZ(-mouseX/200)
}

function propeller(x,z,size,fc) {
  translate(x,z);
  rotateX(PI/2)
  rotateZ(PI/2)
  
  rotateX(fc/5)
  cylinder(0.1*size, 0.9*size)
  rotateX(-fc/5)
  
  rotateZ(-PI/2)
  rotateX(-PI/2)
  translate(-x,-z)
}