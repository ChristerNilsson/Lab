int x=128;
int xvel=2;

void setup () {
  size(256, 256);
}

void draw () {
  background (255, 255, 0);
  fill(255, 0, 0);
  ellipse (x, 50, 50, 50);
  
x=x-xvel ; 
}