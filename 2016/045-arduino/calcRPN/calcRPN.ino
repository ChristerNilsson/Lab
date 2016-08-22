#include <string.h>

const int aPin = 2;            
const int bPin = 3;            
const int cPin = 4;    
const int mPin = 5;

const int N = 200;
char buffer[N]; 

int a,b,c;

class Stack {
  int stack[10];
  int top = -1;
  public: void push(int value) {stack[++top] = value;}
  public: int pop() {return stack[top--];}
  public: int last() {return stack[top];}
  public: void clear() {top=-1;}
  public: String show() {
    String s = ""; 
    for (int i=0; i<=top; i++) {
      s += String(stack[i]);
      if (i<top) s += ","; 
    }
    return "[" + s + "]";
  }
  public: void eval(char *commands0) {
    String original = String(commands0);
    eval1(commands0);
    Serial.println(original + " -> " + show());
  }
  
  void eval1(char *commands0) {
    char commands[N];
    strcpy(commands,commands0);
    char* command = strtok(commands, " ");
    while (command != 0) {
      //Serial.println(command);
      if (strcmp(command,"+")==0) {push(pop() + pop());} 
      else if (strcmp(command,"xor")==0) {push(pop() ^ pop());} 
      else if (strcmp(command,"-")==0) {int x = pop();int y = pop();push(y-x);}
      else if (strcmp(command,"clr")==0) {clear(); }
      else if (strcmp(command,"dup")==0) {push(last()); }
      
      else if (strcmp(command,"a")==0) {push(a);}
      else if (strcmp(command,"b")==0) {push(b);}
      else if (strcmp(command,"c")==0) {push(c);}
      else if (strcmp(command,"@a")==0) {a = pop();}
      else if (strcmp(command,"@b")==0) {b = pop();}
      else if (strcmp(command,"@c")==0) {c = pop();}
      else if (strcmp(command,"abc")==0) {eval1("a b c");}
      else if (strcmp(command,"@abc")==0) {eval1("@c @b @a abc");}
      else if (strcmp(command,"move")==0) {move();}
      
      else {push(String(command).toInt()); }
      command = strtok(0, " ");
    }
  }
  bool winner() {
    if (a > (b ^ c)) { a=b^c; return true;}
    if (b > (a ^ c)) { b=a^c; return true;}
    if (c > (a ^ b)) { c=a^b; return true;}
    return false;
  }
  void new_game() {
    a = random(5,15);
    b = random(5,15);
    c = random(5,15);
  }
  void move(){
    if (winner()) {
      if (a+b+c==0) { Serial.println("Computer wins"); new_game(); return; }
      return;
    }
    // losing...
    if (a>0) { a-=1; return;}
    if (b>0) { b-=1; return;}
    if (c>0) { c-=1; return;}    
    Serial.println("Computer loses");
    new_game();
  }
};

Stack stack;

class Button {
  int pin;
  char * action;
  int state;
  public: Button(int _pin, char * _action) { 
    pin = _pin;
    action=_action;
    pinMode(pin, INPUT);    
    state = digitalRead(pin);   
  }
  public: void listen() {
    int val = digitalRead(pin);      // read input value 
    if (val != state) {         // the button state has changed!
      if (val == HIGH) stack.eval(action);
    }
    state = val;                 // save the new state  
  }
};

Button button_a = Button(aPin, "clr a 1 - @a abc");
Button button_b = Button(bPin, "clr b 1 - @b abc");
Button button_c = Button(cPin, "clr c 1 - @c abc");
Button button_m = Button(mPin, "clr move abc");

void setup() {
  Serial.begin(9600);
  stack.eval("6 8 9 @abc");
}

void loop() {
  
  button_a.listen();
  button_b.listen();
  button_c.listen();
  button_m.listen();

  while (Serial.available() > 0) {
    Serial.readBytesUntil('\n', buffer, N);
    stack.eval(buffer);    
    for (int i=0; i<N; i++) buffer[i] = '\0';    
  }
}

