void ass(int a, int b) {
  if (a!=b) {
    Serial.print("Problem: ");
    Serial.print(a);
    Serial.print(" != ");
    Serial.println(b);
  }
}

int f(int x) { return x;}
int g(int x) { return -x;}
int h(int x) { return x+1;}
int i(int x) { return 2*x;}
int j(int x) { return x/2;}
int k(int x) { return x%2;}

void setup() {
  Serial.begin(9600);
  ass(2+3,5);

  ass(f(2),2);
  ass(f(-2),-2);
  
  ass(g(2),-2);
  ass(g(-2),2);

  ass(h(2),3);
  ass(h(12),13);

  ass(i(2),4);
  ass(i(3),6);

  ass(j(10),5);
  ass(j(8),4);

  ass(k(1),1);
  ass(k(2),0);
  ass(k(3),1);

  Serial.println("Ready!");
}

void loop() {

}
