// KontaktSensor

// Jesus-koppling
// Svart = GND
// Röd = 5V
// Grön = 2
// Gul = 3

// Utdata:
// 0 0 Båda
// 0 1 Vänster
// 1 0 Höger
// 1 1 Ingen kontakt

void setup() {
  pinMode(2,INPUT);
  pinMode(3,INPUT);
  Serial.begin(9600);
}

void loop() {
  Serial.print(digitalRead(2));
  Serial.print(' ');
  Serial.println(digitalRead(3));
  delay(100);
}
