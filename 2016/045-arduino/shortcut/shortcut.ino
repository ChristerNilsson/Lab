// shortcut 
// 3.3V GND 
// Använd färdiga pushbuttons med motstånd

#include "Button.h"

Button btn1 = Button(3);
Button btn2 = Button(4);
Button btn3 = Button(5);

int a; 
int b;
int antal;

void setup() {
  Serial.begin(9600);
  randomSeed(analogRead(0));
  start();
}

void start() {
  a = random(1,20); 
  b = random(1,20);
  antal = 0;
  Serial.println(String(a) + " to " + String(b));  
}

void loop() {
  int plus2 = btn1.getValue();
  int dbl   = btn2.getValue();
  int half  = btn3.getValue();
  int newa=a;
  if (plus2==1) newa = a+2;
  if (dbl==1) newa = a*2;
  if (half==1 && a%2==0) newa = a/2;
  if (newa != a) {
    a = newa;
    antal++;
    Serial.println(String(a) + " to " + String(b));
    if (a==b) {
      Serial.println("You used " + String(antal) + " operations");      
      start();
    }
  }
}
