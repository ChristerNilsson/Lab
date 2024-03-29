'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

// Generated by CoffeeScript 2.0.3
var POTION, Place, SWORD, buy, inventory, messages, person, places;

POTION = 10;

SWORD = 50;

person = {};

//enemy = {}
places = {};

messages = [];

Place = function () {
  function Place(name1) {
    _classCallCheck(this, Place);

    this.name = name1;
    this.enemy = {};
  }

  _createClass(Place, [{
    key: 'enter',
    value: function enter() {
      person.location = this.name;
      inventory();
      this.createEnemy();
      button('Punch', function () {
        var hit;
        print('Punch', messages.length);
        if (0 === _.size(this.enemy)) {
          messages.push("You have no enemy here!");
          return;
        }
        if (1 === rand(1, 8)) {
          return messages.push("You tried to Punch it but you missed!");
        } else {
          hit = value + rand(1, 6);
          this.enemy.health -= hit;
          person.points += hit;
          return messages.push('You Punch the ' + this.enemy.name + '! ' + -hit);
        }
      });
      // if 1 == rand 1,3
      // 	@enemy = {}
      // 	Black "The #{@name} looks empty... for now. Check later."
      // else
      // 	@createEnemy()
      // 	@personAttacks()
      return link("Town", "Go back to Town");
    }
  }, {
    key: 'attack',
    value: function attack() {
      if (this.enemy.health <= 0) {
        return this.enemyDies();
      } else {
        //enemy = {}
        this.enemyAttacks();
        if (person.health <= 0) {
          return this.personDies();
        } else {
          return this.personAttacks();
        }
      }
    }
  }, {
    key: 'createEnemy',
    value: function createEnemy() {
      this.enemy = {};
      this.enemy.name = either(["Giant Spider", "Zombie", "Ghost", "Pizza Rat"]);
      this.enemy.health = 0.1 * person.points + rand(20, 40);
      this.enemy.punch = rand(1, 9);
      this.enemy.kick = 10 - this.enemy.punch;
      return messages.push('A ' + this.enemy.name + ' crawls out of the shadows!');
    }
  }, {
    key: 'enemyAttacks',
    value: function enemyAttacks() {
      this.enemy.hit = rand(1, 3) + rand(1, 3);
      person.health -= this.enemy.hit;
      return person.points -= this.enemy.hit;
    }

    //messages.push -> Red "The #{@enemy.name} attacks you! You lose #{@enemy.hit} points"

  }, {
    key: 'enemyDies',
    value: function enemyDies() {
      var reward;
      person.points += 10;
      reward = rand(25, 50);
      person.coins += reward;
      // messages.push -> 
      // 	Black "You have defeated the #{@enemy.name}. +10 points!"
      // 	Green "+#{reward} coins!" 
      // 	@enemy = {}
      return link("Continue");
    }
  }, {
    key: 'personDies',
    value: function personDies() {
      // messages.push ->
      // 	Red "You died!"
      // 	Black "Game over!"
      // 	Black "Final Score: #{person.points + person.coins}"
      return link("Continue");
    }
  }, {
    key: 'attack1',
    value: function attack1(txt, value) {
      return button(txt, function () {
        var hit;
        if (1 === rand(1, 8)) {
          return messages.push('You tried to ' + txt + ' it but you missed!');
        } else {
          hit = value + rand(1, 6);
          this.enemy.health -= hit;
          person.points += hit;
          return messages.push('You ' + txt + ' the ' + this.enemy.name + '! ' + -hit);
        }
      });
    }
  }, {
    key: 'personAttacks',
    value: function personAttacks() {
      this.attack1('Punch', this.enemy.punch + rand(1, 6));
      this.attack1('Kick', this.enemy.kick + rand(1, 6));
      if (person.sword > 0) {
        this.attack1('Slash', 10 + rand(1, 6) + rand(1, 6));
      }
      if (person.ax > 0) {
        return this.attack1('Ax', 10 + rand(1, 6) + rand(1, 6));
      }
    }
  }]);

  return Place;
}();

events.Start = function () {
  person.health = 10; //0
  person.sword = 0;
  person.ax = 0;
  person.coins = 100;
  person.points = 0;
  places['Castle'] = new Place('Castle');
  places['Graveyard'] = new Place('Graveyard');
  places['Farm'] = new Place('Farm');
  inventory();
  return link("Town");
};

events.Town = function () {
  inventory();
  Black("Where do you want to go?");
  link("Market");
  link("Castle");
  link("Graveyard");
  return link("Farm");
};

buy = function buy(name, price) {
  var count = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : price;

  person[name] += count;
  return person.coins -= price;
};

inventory = function inventory() {
  Black('You are at ' + page);
  Black('You have ' + person.coins + ' coins');
  Black('You have ' + person.health + ' health');
  Black('You have ' + person.sword + ' sword');
  return Black("");
};

// for message in messages
// 	message()
// messages = [] 
events.Market = function () {
  inventory();
  if (person.coins >= POTION) {
    button('Buy A Healing Potion For ' + POTION + ' Coins', function () {
      return buy('health', POTION);
    });
  }
  if (person.coins >= SWORD) {
    button('Buy A Sword For ' + SWORD + ' Coins', function () {
      return buy('sword', SWORD, 1);
    });
  }
  return link("Town", "Return to Town");
};

events.Castle = function () {
  return places.Castle.enter();
};

events.Graveyard = function () {
  return places.Graveyard.enter();
};

events.Farm = function () {
  return places.Farm.enter();
};

//place = (name) ->
events.Continue = function () {
  return goto(person.location);
};
//# sourceMappingURL=original2.js.map
