/* 
 DESCRIPTION
 ====================
 Simple example of the Bounce library that switches the debug LED when a button is pressed.
 */
// Include the Bounce2 library found here :
// https://github.com/thomasfredericks/Bounce-Arduino-Wiring
#include <Bounce2.h>

#define BUTTON_PIN 2

Bounce debouncer = Bounce(); 
int antal=0;

void setup() {
  pinMode(BUTTON_PIN,INPUT_PULLUP);
  debouncer.attach(BUTTON_PIN);
  debouncer.interval(5); // interval in ms
  Serial.begin(9600);
}

void loop() {
  debouncer.update();
  int value = debouncer.read();
  if (value==1) {
    antal+=1;
    Serial.println(antal);
  }
}
