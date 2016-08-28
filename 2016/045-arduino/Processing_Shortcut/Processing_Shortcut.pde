import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

void setup() {
  size(1000, 1000);
  arduino = new Arduino(this, Arduino.list()[2], 57600);
}

void draw() {
  //background(128);
  stroke(0);
  float x = arduino.analogRead(0);
  float y = arduino.analogRead(1);
  translate(width/2,height/2);
  x = map(x,0,1023,400,-400);
  y = map(y,0,1023,400,-400);
  ellipse(x,y,16,16);
}