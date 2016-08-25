// Matrix_3x3

// Jesus-koppling
// Lila = 5
// Grön = 6
// Grå = 7

// Brun 8
// Gul 9
// Orange = 10

int idx = 0; 
unsigned long last;
byte leds[3][3];
byte rr[] = {8,9,10};  
byte cc[] = {5,6,7};     

byte patterns[][3] = {
  {0, 1, 1},
  {1, 0, 0},
  {1, 0, 0},

  {0, 0, 1},
  {0, 1, 1},
  {0, 0, 1},

  {0, 1, 1},
  {1, 0, 0},
  {0, 0, 0},
};

void setup() {
  last = millis();
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);

  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);

  for (int r = 0; r < 3; r++) digitalWrite(rr[r], LOW);
  for (int c = 0; c < 3; c++) digitalWrite(cc[c], HIGH);
}

void setLeds(byte patterns[][3], int idx) {
  for (int r = 0; r < 3; r++) {
    for (int c = 0; c < 3; c++) {
      leds[r][c] = patterns[r + idx][c];
    }
  }
}

void draw() {
  for (int r=0; r<3; r++) {
    digitalWrite(rr[r], HIGH);
    for (int c=0; c<3; c++) {
      digitalWrite(cc[c], 1 - leds[r][c]);
    }
    delayMicroseconds(1000);
    digitalWrite(rr[r], LOW);
  }
}

void loop() {
  if (millis() - last > 1000) {
    idx = idx+3;
    if (idx == 9) idx=0;
    last = millis();
  }
  setLeds(patterns, idx);
  draw();
}
