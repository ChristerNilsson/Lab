// Morse 1

import processing.serial.*;
import cc.arduino.Arduino;
Arduino arduino;

void setup() { 
  size(600,600); 
  arduino = new Arduino(this, Arduino.list()[2], 57600);
}

void draw() {
  arduino.digitalWrite(13,1);
  delay(1000);
  arduino.digitalWrite(13,0);
  delay(1000);
}