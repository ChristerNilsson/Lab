// VridPotentiometer
// Jesus-koppling:
//   Svart = GND
//   Röd = 5V
//   Gray = A0
//   Red = 9
//   Green = 10 
//   Blue = 11

const int PinX = 0;               
const int Red = 9;
const int Green = 10;
const int Blue = 11;
             
int x = 0;                  

void setup() {
  Serial.begin(9600);
  pinMode(Red,OUTPUT);
  pinMode(Green,OUTPUT);
  pinMode(Blue,OUTPUT);
}

void loop() {
  x = analogRead(PinX);
  delay(100);
  int currentColorValueRed = map(x, 200, 750, 255, 0);
  Serial.print(x);  // Varierar mellan 180 och 680 cirka.
  Serial.print(' ');  
  Serial.println(currentColorValueRed);  
  analogWrite(Red, currentColorValueRed);
  //analogWrite(Red, 10);
}
