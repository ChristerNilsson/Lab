// Trafikljus
// Använd färdigt sådant med motstånd. 3.3V GND
// R 9 sek
// RY 1 sek
// G 9 sek
// Y 1 sek

int redled = 3;
int yelled = 4;
int grnled = 5;

void setup() {
  pinMode (3, OUTPUT);
  pinMode (4, OUTPUT);
  pinMode (5, OUTPUT);
}

void loop() {
  digitalWrite (redled, 1);
  delay(9000);
   
  digitalWrite (yelled, 1); 
  delay (1000); 
  
  digitalWrite (redled, 0);   
  digitalWrite (yelled, 0);   
  digitalWrite (grnled, 1);
  delay (9000);

  digitalWrite (grnled, 0);
  digitalWrite (yelled, 1);
  delay (1000);
  digitalWrite (yelled, 0);
}
