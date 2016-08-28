class Ball {
  float x,y,r,xvel,yvel;
  color c;
  
  Ball(float x, float y, float r, float xvel, float yvel, color c) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.xvel = xvel;
    this.yvel = yvel;
    this.c = c;
  }    
  
  void draw() {
    fill(c);
    ellipse(this.x, this.y, 2*this.r, 2*this.r);
  }
  
  void update() {
    this.x += this.xvel;
    this.y += this.yvel;

    if (this.x < this.r) {
      gameOver=true;
      player2.score += 1;
    }
    if (this.x + this.r > width) {
      gameOver=true;
      player1.score += 1;
    }
    if (this.y < this.r) this.yvel = - this.yvel;
    if (this.y + this.r > height) this.yvel = - this.yvel;

    if (player1.touches(this)) this.xvel = -this.xvel;
    if (player2.touches(this)) this.xvel = -this.xvel;
  }
  
}