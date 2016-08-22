const int unit = 200;  // ms
String alfabet = "so";
String tabell[] = {"...","---"};

void setup() {
  pinMode(13, OUTPUT);
}

void skicka(int on, int off) {
  digitalWrite(13, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(on*unit);               // wait for on millis
  digitalWrite(13, LOW);   // turn the LED off by making the voltage LOW
  delay(off*unit);              // wait for off millis    
}

void sendLetter(String dd) {
  for (int k=0; k<dd.length(); k++) {
    char d = dd[k];
    if (d == '.') skicka(1,1);
    if (d == '-') skicka(3,1);
  }  
  delay(3*unit);   
}

void sendSentence(String letters) {
  delay(10*unit);   
  for (int i=0; i<letters.length(); i++) {
    char letter = letters[i];
    if (letter == ' ') {
      delay(7*unit); 
    } else {
      int index = alfabet.indexOf(letter);
      sendLetter(tabell[index]);
    }
  }
}

void loop() {
  sendSentence("sos oss");
}
