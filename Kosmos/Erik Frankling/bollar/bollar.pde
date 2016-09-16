int y=0;
int yh=7;
int x=0;
int xh=10;
void setup()
{
  size(256,256);
  x=50;
  y=50;
}

void draw()
{
  background(#5103FC);
  fill(#FC0303);
  ellipse(x,y,50,50);
  
  fill(#03FC3A);
  ellipse(x,y,50,50);
  
  x=x+xh;
  y=y+yh;
  
  if (x-25<0) xh=-xh;
  else if (x+25>width) xh=-xh;
  
  if (y-25<0) yh=-yh;
  else if (y+25>width) yh=-yh;
}