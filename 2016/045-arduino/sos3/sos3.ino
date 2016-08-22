const int unit = 200;  // ms
//                012345678901234567890123456789
String alfabet = "  etianmsurwdkgohvf l pjbxcyzq";

void setup() {
  pinMode(13, OUTPUT);
}

void skicka(int on, int off) {
  digitalWrite(13, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(on*unit);          // wait for on millis
  digitalWrite(13, LOW);   // turn the LED off by making the voltage LOW
  delay(off*unit);         // wait for off millis    
}

void sendLetter(String dd) {
  for (unsigned int k=0; k<dd.length(); k++) {
    char d = dd[k];
    if (d == '.') skicka(1,1);
    if (d == '-') skicka(3,1);
  }  
  delay(3*unit);   
}

String getLetter(char letter) {
  int i = alfabet.indexOf(letter);
  String result = "";
  while (i>1) {
    result = ".-"[i%2] + result;  
    i /= 2; 
  }
  return result;
}

void sendSentence(String letters) {
  delay(10*unit);   
  for (unsigned int i=0; i<letters.length(); i++) {
    char letter = letters[i];
    if (letter == ' ') {
      delay(7*unit); 
    } else {
      String dd = getLetter(letter);
      sendLetter(dd);
    }
  }
}

void loop() {
  sendSentence("kosmos");
}
