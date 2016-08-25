// Potentiometer
// Jesus-koppling:
//   Svart = GND
//   Röd = 5V
//   Gul = A0

const int PinX = 0;               
             
int x = 0;                  

void setup() {
  Serial.begin(9600);
}

void loop() {
  x = analogRead(PinX);
  delay(100);
  Serial.println(x);
}
