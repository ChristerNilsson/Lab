class Player {
  float x,y,w,h;
  int pin;
  int score;
  color c;
  Player(float x, float y, float w, float h, int pin, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.pin = pin;
    this.c = c;
  }    
  
  void draw() {
    fill(c);
    rect(this.x, this.y, this.w, this.h);
    fill(0);
    text(this.score,this.x,30);
  }
  
  void update() {
    float y = arduino.analogRead(this.pin);  // 0-1023
    this.y = int(map(y,0,1023,0,height-this.h));
  }
  
  boolean touches(Ball ball) {
    if (ball.x + ball.r < this.x) return false;
    if (ball.x - ball.r > this.x + this.w) return false;
    if (ball.y - ball.r < this.y) return false;
    if (ball.y + ball.r > this.y + this.h) return false;
    return true; 
  }
  
}