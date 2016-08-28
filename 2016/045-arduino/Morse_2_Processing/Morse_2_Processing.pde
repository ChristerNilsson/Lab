// Morse 2

import processing.serial.*;
import cc.arduino.Arduino;
Arduino uno;

int unit = 300; // ms

String alfabet = "so";
String[] tabell = {"...","---"};

void setup() { 
  size(600,600); 
  uno = new Arduino(this, Arduino.list()[2], 57600);
}

void dot() {
  uno.digitalWrite(13,1);
  delay(unit);
  uno.digitalWrite(13,0);
  delay(unit);
}

void dash() {
  uno.digitalWrite(13,1);
  delay(3*unit);
  uno.digitalWrite(13,0);
  delay(unit);
}

void sendLetter(String symbols) {
  for (int i=0; i<symbols.length(); i++) {
    char symbol = symbols.charAt(i);
    if (symbol=='-') dash();
    if (symbol=='.') dot();
  }
  delay(3*unit);
}

void sendSentence(String sentence) {
  for (int i=0; i<sentence.length(); i++) {
    char letter = sentence.charAt(i);
    int index = alfabet.indexOf(letter);
    sendLetter(tabell[index]);
  }
}

void draw() {
  sendSentence("sos");
}