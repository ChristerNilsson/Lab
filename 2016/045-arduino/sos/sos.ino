void setup() {
  pinMode(13, OUTPUT);
}

void skicka(int on, int off) {
  digitalWrite(13, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(on);               // wait for on millis
  digitalWrite(13, LOW);   // turn the LED off by making the voltage LOW
  delay(off);              // wait for off millis    
}

void dash() { skicka(500,500);}
void dot() { skicka(200,500);}
void pause() { delay(1000);}

void s() { dot(); dot(); dot(); pause();}
void o() { dash(); dash(); dash(); pause();}

void loop() {
  s(); o(); s();
  delay(2000);
}
