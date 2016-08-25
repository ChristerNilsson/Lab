// Joystick

// Jesus-koppling:
//   Svart = GND
//   Röd = 5V
//   Grön = A0
//   Gul = A1
//   Orange = ignore

const int PinX = 0;               
const int PinY = 1;  
             
int x = 0;                  
int y = 0;                 

void setup() {
  Serial.begin(9600);
}

void loop() {
  x = analogRead(PinX);
  delay(100);
  y = analogRead(PinY);
  Serial.print(x); Serial.print(' '); Serial.println(y);
}
