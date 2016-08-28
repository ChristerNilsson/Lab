// Morse-exercise

const int LAMPA = 13;
const int PAUS = 500; // millisekunder

void setup() {
  pinMode(LAMPA, OUTPUT);
}

void loop() {
  digitalWrite(LAMPA, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(PAUS);                // wait for on millis
  digitalWrite(LAMPA, LOW);   // turn the LED off by making the voltage LOW
  delay(PAUS);                // wait for off millis    
}
