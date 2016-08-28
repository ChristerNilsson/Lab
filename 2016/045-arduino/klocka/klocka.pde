// klocka 

import processing.serial.*;
import cc.arduino.Arduino;
Arduino arduino;

int SIZE = 250;

void setup() { 
  size(600,600); 
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  rectMode(CENTER);
  noStroke();
  textSize(36);
}

void urtavla() {
  fill(255);
  ellipse(0, 0, 2*SIZE+10, 2*SIZE+10);
  fill(0);
  for (int i=0; i<60; i++) {
    if (i%5==0) {
      rect(SIZE-25, 0, 40, 10);
    } else {
      rect(SIZE-5, 0, 5, 1);
    }
    rotate(radians(6));
  }
}

void visare(float v, int w, int l, color c) {
  pushMatrix();
  rotate(radians(v-90));
  translate(l/2,0);
  fill(c);
  rect(0, 0, l, w);
  popMatrix();
}

void draw() { 
  background(0);
  translate(width/2, height/2);
  
  float pot0 = arduino.analogRead(1);  // 0-1023
  int v = 2*int(0.5+map(pot0,0,1023,180,0));
  rotate(radians(v));
  
  urtavla();

  float pot1 = arduino.analogRead(0);  // 0-1023
  int alpha = int(map(pot1,0,1023,255,0));
  
  fill(0);
  text(alpha,100,100);
  text(v,100,0);

  visare(hour()*30, 12, SIZE-70, color(255,0,0,alpha));
  visare(minute()*6, 9, SIZE,    color(0,255,0,alpha));
  visare(second()*6, 6, SIZE,    color(0,0,255,alpha));
}