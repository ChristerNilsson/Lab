#include <string.h>

const int aPin = 2;            
const int bPin = 3;            
const int cPin = 4;    
const int mPin = 5;

const int N = 200;
char buffer[N]; 

int a,b,c;
int bst; // button_state: 2 to 5

class Button {
  int pin;
  int state;
  public: Button(int _pin) { 
    pin = _pin;
    pinMode(pin, INPUT);    
    state = digitalRead(pin);   
  }
  public: bool pressed() {
    int val = digitalRead(pin); // read input value 
    if (val != state) { // the button state has changed!
      if (val == HIGH) {state = val; return true;}
    }
    state = val; // save the new state  
    return false;
  }
};

Button button_a = Button(aPin);
Button button_b = Button(bPin);
Button button_c = Button(cPin);
Button button_m = Button(mPin);

void new_game() {
  while (a==b || b==c || a==c) {
    a = random(5,15);
    b = random(5,15);
    c = random(5,15);
  }
  bst = mPin;
}

String winner() {
  if (a > (b ^ c)) { a=b^c; return "computer a";}
  if (b > (a ^ c)) { b=a^c; return "computer b";}
  if (c > (a ^ b)) { c=a^b; return "computer c";}
  return "";
}

String move(){
  String ret = winner();
  if (ret != "") {
    if (a+b+c==0) { new_game(); return "Computer wins"; }
    return ret;
  }
  // losing...
  if (a>0) { a-=1; return "computer a";}
  if (b>0) { b-=1; return "computer b";}
  if (c>0) { c-=1; return "computer c";}    
  new_game();
  return "Computer loses";
}

void setup() {
  Serial.begin(9600);
  randomSeed(analogRead(0));
  new_game();
  show("your turn");
}

void show(String s) {
  Serial.println(String(a) + " " + String(b) + " " + String(c) + " " + s);
}

void loop() {  
  if (button_a.pressed() && (bst==aPin || bst==mPin) && a>0) {bst=aPin; a-=1; show("human a");}
  if (button_b.pressed() && (bst==bPin || bst==mPin) && b>0) {bst=bPin; b-=1; show("human b");}
  if (button_c.pressed() && (bst==cPin || bst==mPin) && c>0) {bst=cPin; c-=1; show("human c");}
  if (button_m.pressed() && (bst!=mPin))                     {bst=mPin; show(move());}
}
