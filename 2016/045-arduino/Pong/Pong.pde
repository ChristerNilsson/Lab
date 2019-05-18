// https://www.youtube.com/watch?v=SsZmuEEHcbU (4 videos) engelsk text, ej objektorienterad
// Shiffman 8.1 https://www.youtube.com/watch?v=YcbcfkLzgvs
// Shiffman 8.2 https://www.youtube.com/watch?v=lmgcMPRa1qw
// Shiffman 8.3 https://www.youtube.com/watch?v=XwfOVFelLoo

import processing.serial.*;
import cc.arduino.Arduino;
Arduino arduino;

Ball ball;
Player player1,player2;
boolean gameOver;

void setup() {
  size(600,600);
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  player1 = new Player(      10,height/2,10,100,1,color(255,0,0));
  player2 = new Player(width-20,height/2,10,100,0,color(0,0,255));
  gameOver = true;
  textSize(24);
}

void draw() {
  background(0,255,0);
  if (gameOver == true) {
    gameOver = false;
    float vinkel = random(-45,45);
    float speed = random(3,5);
    float xvel = speed * cos(radians(vinkel));
    float yvel = speed * sin(radians(vinkel));
    ball = new Ball(width/2,height/2,10,xvel,yvel,color(255,255,0));
  } else {    
    ball.draw();
    ball.update();
  }
  player1.draw();
  player2.draw();
  player1.update();
  player2.update();
}