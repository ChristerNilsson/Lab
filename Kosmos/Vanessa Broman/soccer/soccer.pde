int x=0;
int xvel=10;

void setup() {
  size(256, 255);
}

void draw() {
  background(255, 255, 0);
  fill(#3CC7F0);
  ellipse(50, 50, 50,);
  fill(#F21111);
  ellipse(x, 50, 50, 50);
  x=x+xvel;
}