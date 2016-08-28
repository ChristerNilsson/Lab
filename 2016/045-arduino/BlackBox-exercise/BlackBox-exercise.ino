void ass(int a, int b) {
  if (a!=b) {
    Serial.print("Problem: ");
    Serial.print(a);
    Serial.print(" is not equal to ");
    Serial.println(b);
    Serial.flush();
    abort();
  }
}

int f(int x) {return 00;}
int g(int x) {return 00;}
int h(int x) {return 00;}
int i(int x) {return 00;}
int j(int x) {return 00;}
int k(int x) {return 00;}

void setup() {
  Serial.begin(9600);
  
  ass(2+3,4);

  Serial.println("f");
  ass(f(2),2);
  ass(f(-2),-2);
  
  Serial.println("g");
  ass(g(2),-2);
  ass(g(-2),2);

  Serial.println("h");
  ass(h(2),3);
  ass(h(12),13);

  Serial.println("i");
  ass(i(2),4);
  ass(i(3),6);

  Serial.println("j");
  ass(j(10),5);
  ass(j(8),4);

  Serial.println("k");
  ass(k(1),1);
  ass(k(2),0);
  ass(k(3),1);

  Serial.println("Ready!");
}

void loop() {}
