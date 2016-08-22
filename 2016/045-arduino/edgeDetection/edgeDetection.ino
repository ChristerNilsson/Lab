const int  buttonPin = 5;    // the pin that the pushbutton is attached to
const int ledPin = 13;       // the pin that the LED is attached to

int buttonPushCounter = 0;   // counter for the number of button presses
int buttonState = 0;         // current state of the button
int lastButtonState = 0;     // previous state of the button

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  buttonState = digitalRead(buttonPin);
  if (buttonState != lastButtonState) {
    if (buttonState == 1) {
      buttonPushCounter++;
      Serial.println(buttonPushCounter);
    }
    delay(1); // 0 ger studs 
  }
  lastButtonState = buttonState;
  
  if (buttonPushCounter % 4 == 0) {
    digitalWrite(ledPin, 1);
  } else {
    digitalWrite(ledPin, 0);
  }
}
