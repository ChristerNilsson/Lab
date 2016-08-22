#include "arduino.h"
#include "Button.h"

Button::Button(int pin) {
  this->pin=pin;
  pinMode(pin, INPUT);
}
int Button::getValue() {
  int state = digitalRead(this->pin);
  int result = 0;
  if (state != this->lastState) {
    if (state == 1) result=1;
    delay(10); // 0 ger studs 
  }
  this->lastState = state;
  return result;  
};

