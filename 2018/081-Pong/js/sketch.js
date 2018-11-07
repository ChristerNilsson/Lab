'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var Game, HEIGHT, PADDLE_SPEED, WIDTH, draw, game, keyPressed, setup;

PADDLE_SPEED = 200;

WIDTH = 432;

HEIGHT = 243;

game = null;

Game = function () {
  function Game() {
    _classCallCheck(this, Game);

    this.player1 = new Player(1, 5, 10, 5, 20, 87, 83);
    this.player2 = new Player(2, WIDTH - 5, HEIGHT - 10, 5, 20, UP_ARROW, DOWN_ARROW);
    this.ball = new Ball(WIDTH / 2, HEIGHT / 2, 4, 4);
    this.gameState = 'start';
    this.servingPlayer = 1;
    this.winningPlayer = 0;
  }

  _createClass(Game, [{
    key: 'draw',
    value: function draw() {
      scale(4);
      bg(0.25);
      this.update(1 / 60);
      textAlign(CENTER, CENTER);
      textSize(12);
      fc(1);
      sc();
      if (this.gameState === 'start') {
        this.text2(12, 'Welcome to Pong!', 'Press Enter to begin!');
      }
      if (this.gameState === 'serve') {
        this.text2(12, 'Player ' + this.servingPlayer + '\'s serve!', 'Press Enter to serve!');
      }
      if (this.gameState === 'done') {
        this.text2(16, 'Player ' + this.winningPlayer + ' wins!', 'Press Enter to restart!');
      }
      this.displayScore();
      this.player1.render();
      this.player2.render();
      return this.ball.render();
    }
  }, {
    key: 'text2',
    value: function text2(textsize, t1, t2) {
      textSize(textsize);
      text(t1, WIDTH / 2, 10);
      return text(t2, WIDTH / 2, 2 * textsize);
    }
  }, {
    key: 'displayScore',
    value: function displayScore() {
      textSize(20);
      text(this.player1.score, WIDTH / 2 - 40, HEIGHT / 3);
      return text(this.player2.score, WIDTH / 2 + 40, HEIGHT / 3);
    }
  }, {
    key: 'update',
    value: function update(dt) {
      if (this.gameState === 'serve') {
        this.ball.dy = random(-50, 50);
        if (this.servingPlayer === 1) {
          this.ball.dx = random(140, 200);
        } else {
          this.ball.dx = -random(140, 200);
        }
      } else if (this.gameState === 'play') {
        this.player1.checkCollision(this.ball, 5);
        this.player2.checkCollision(this.ball, -4);
        if (this.ball.y <= 0) {
          this.ball.bounce(0);
        }
        if (this.ball.y >= HEIGHT - 4) {
          this.ball.bounce(HEIGHT - 4);
        }
        if (this.ball.x > WIDTH) {
          this.player1.incr(1);
        }
        if (this.ball.x < 0) {
          this.player2.incr(2);
        }
      }
      this.player1.handleKey();
      this.player2.handleKey();
      if (this.gameState === 'play') {
        this.ball.update(dt);
      }
      this.player1.update(dt);
      return this.player2.update(dt);
    }
  }, {
    key: 'keyPressed',
    value: function keyPressed() {
      if (keyCode === ENTER || keyCode === RETURN) {
        if (this.gameState === 'start') {
          return this.gameState = 'serve';
        } else if (this.gameState === 'serve') {
          return this.gameState = 'play';
        } else if (this.gameState === 'done') {
          this.gameState = 'serve';
          this.ball.reset();
          this.player1.score = 0;
          this.player2.score = 0;
          return this.servingPlayer = 3 - this.winningPlayer;
        }
      }
    }
  }]);

  return Game;
}();

setup = function setup() {
  createCanvas(4 * WIDTH, 4 * HEIGHT);
  rectMode(CENTER);
  return game = new Game();
};

keyPressed = function keyPressed() {
  return game.keyPressed();
};

draw = function draw() {
  return game.draw();
};
//# sourceMappingURL=sketch.js.map
