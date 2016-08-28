const int unit = 500;

void ass(String a, String b) {
  if (a!=b) {
    Serial.print("Problem: ");
    Serial.print(a);
    Serial.print(" is not equal to ");
    Serial.println(b);
    Serial.flush();
    abort();
  }
}

String letter(char ch) {
  if (ch=='s') return "...";
  if (ch=='o') return "00";
}

String sentence(String s) {
  String res = "00";
  return res;
}

void skicka(int on, int off) {
  Serial.println(on);
  digitalWrite(13, HIGH);  // turn the LED on (HIGH is the voltage level)
  delay(on*unit);          // wait for on millis
  digitalWrite(13, LOW);   // turn the LED off by making the voltage LOW
  delay(off*unit);         // wait for off millis    
}

void sendString(String message) {
  for (int i=0; i<message.length(); i++) {
    char d = message[i];
    if (d == '.') skicka(1,1);
    if (d == '-') skicka(3,1);
    if (d == ' ') delay(3*unit);
  }  
  delay(7*unit);   
}

void setup() {
  pinMode(13,OUTPUT);
  Serial.begin(9600);
  ass(letter('s'),"...");
  ass(letter('o'),"---");
  ass(sentence("sos"),"... --- ... ");
  Serial.println("Ready!");
}

void loop() {
  sendString(sentence("sos"));
}
