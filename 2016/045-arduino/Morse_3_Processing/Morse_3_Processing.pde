// Morse

import processing.sound.*;

int unit = 300;
//                012345678901234567890123456789
String alfabet = "  etianmsurwdkgohvf l pjbxcyzq";
SinOsc osc;

void wait(int n) { delay(n*unit); }
void symbol(int n) {
  osc.amp(0.5);  wait(n); 
  osc.amp(0);    wait(1); 
}
void dot()  { symbol(1); }
void dash() { symbol(3); }

String getLetter(char letter) {
  int i = alfabet.indexOf(letter);
  String result = "";
  while (i>1) {
    result = ".-".charAt(i%2) + result;
    i = i/2;
  }
  return result;
}

void sendLetter(String dd) {
  for (int i=0; i<dd.length(); i++) {
    char d = dd.charAt(i);
    if (d == '.') dot();
    if (d == '-') dash();
  }  
  wait(3);   
}

void sendSentence(String letters) {
  wait(10);
  for (int i=0; i<letters.length(); i++) {
    char letter = letters.charAt(i);
    if (letter == ' ') {
      wait(7);
    } else {
      String dd = getLetter(letter);
      sendLetter(dd);
    }
  }
}

void setup() { 
  size(600,600); 
  osc = new SinOsc(this);
  osc.play();
  osc.amp(0);
}

void draw() { 
  sendSentence("sos");
}