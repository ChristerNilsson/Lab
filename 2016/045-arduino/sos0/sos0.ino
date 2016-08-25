int unit = 500;  // ms

void setup() {
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, 1);  // s .
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // s ..
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // s ...
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  delay(3*unit);

  digitalWrite(13, 1);  // o -
  delay(3*unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // o --
  delay(3*unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // o ---
  delay(3*unit);            
  digitalWrite(13, 0);  
  delay(unit);           
  
  delay(3*unit);
  
  digitalWrite(13, 1);  // s .
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // s ..
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  digitalWrite(13, 1);  // s ...
  delay(unit);            
  digitalWrite(13, 0);  
  delay(unit);           

  delay(7*unit);
}
