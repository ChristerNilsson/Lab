// Jesus-anpassat
// Todo: Lagra fonterna binärt istället.
// Todo: Skapa alla siffror och bokstäver.
// Se även https://waime.wordpress.com/2015/04/07/ping-pong-8x8-led-display-with-max7219/

int idx = 0; 
unsigned long last;
byte leds[7][5];
byte rr[] = {2,3,12,5,10,9,8};  // Letade upp dessa
byte cc[] = {13,11,4,7,6};      // Letade upp dessa

byte patterns[][5] = {
  {0, 1, 1, 1, 0},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {1, 0, 0, 0, 1},
  {0, 1, 1, 1, 0},

  {0, 0, 1, 0, 0},
  {0, 1, 1, 0, 0},
  {0, 0, 1, 0, 0},
  {0, 0, 1, 0, 0},
  {0, 0, 1, 0, 0},
  {0, 0, 1, 0, 0},
  {0, 1, 1, 1, 0},

  {0, 1, 1, 1, 0},
  {1, 0, 0, 0, 1},
  {0, 0, 0, 0, 1},
  {0, 0, 0, 1, 0},
  {0, 0, 1, 0, 0},
  {0, 1, 0, 0, 0},
  {1, 1, 1, 1, 1},
};

void setup() {
  last = millis();
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);

  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);

  for (int r = 0; r < 7; r++) digitalWrite(rr[r], LOW);
  for (int c = 0; c < 5; c++) digitalWrite(cc[c], HIGH);
}

void setLeds(byte patterns[][5], int idx) {
  for (int r = 0; r < 7; r++) {
    for (int c = 0; c < 5; c++) {
      leds[r][c] = patterns[r + idx][c];
    }
  }
}

void draw() {
  for (int r=0; r<7; r++) {
    digitalWrite(rr[r], HIGH);
    for (int c=0; c<5; c++) {
      digitalWrite(cc[c], 1 - leds[r][c]);
    }
    delayMicroseconds(1000);
    digitalWrite(rr[r], LOW);
  }
}

void loop() {
  if (millis() - last > 1000) {
    idx = idx+7;
    if (idx == 21) idx=0;
    last = millis();
  }
  setLeds(patterns, idx);
  draw();
}
