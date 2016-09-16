int x;
int xvel=3;

int y;
int yvel=5;

void setup() {
  size(256,256);
  x=width/2;
  y=width/2;
}

void draw() {
  background(0);
  fill(#F79807);
  ellipse(x,y,50,50);
  x=x+xvel;
  if (x>width-25) xvel=-xvel;
  if (x<0+25) xvel=-xvel;

  y=y+yvel;
  if (y>width-25) yvel=-yvel;
  if (y<0+25) yvel=-yvel;
}



int x;
int xvel=3;

int y;
int yvel=5;

void setup() {
  size(256,256);
  x=width/2;
  y=width/2;
}

void draw() {
  background(0);
  fill(#F79807);
  ellipse(x,y,50,50);
  x=x+xvel;
  if (x>width-25) xvel=-xvel;
  if (x<0+25) xvel=-xvel;

  y=y+yvel;
  if (y>width-25) yvel=-yvel;
  if (y<0+25) yvel=-yvel;
}