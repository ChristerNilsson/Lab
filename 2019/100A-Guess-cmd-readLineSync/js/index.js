// Generated by CoffeeScript 2.4.1
var Game, game, question;

({question} = require('readline-sync'));

Game = require('../../100-Guess-Library/game.js');

game = new Game(2);

while (true) {
  game.action(question(`${game.low}-${game.high} > `));
}

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcaW5kZXguY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBLElBQUEsRUFBQSxJQUFBLEVBQUE7O0FBQUEsQ0FBQSxDQUFFLFFBQUYsQ0FBQSxHQUFlLE9BQUEsQ0FBUSxlQUFSLENBQWY7O0FBQ0EsSUFBQSxHQUFPLE9BQUEsQ0FBUSxpQ0FBUjs7QUFFUCxJQUFBLEdBQU8sSUFBSSxJQUFKLENBQVMsQ0FBVDs7QUFFUCxPQUFNLElBQU47RUFDQyxJQUFJLENBQUMsTUFBTCxDQUFZLFFBQUEsQ0FBUyxDQUFBLENBQUEsQ0FBRyxJQUFJLENBQUMsR0FBUixDQUFZLENBQVosQ0FBQSxDQUFlLElBQUksQ0FBQyxJQUFwQixDQUF5QixHQUF6QixDQUFULENBQVo7QUFERCIsInNvdXJjZXNDb250ZW50IjpbInsgcXVlc3Rpb24gfSA9IHJlcXVpcmUgJ3JlYWRsaW5lLXN5bmMnXHJcbkdhbWUgPSByZXF1aXJlICcuLi8uLi8xMDAtR3Vlc3MtTGlicmFyeS9nYW1lLmpzJ1xyXG5cclxuZ2FtZSA9IG5ldyBHYW1lIDJcclxuXHJcbndoaWxlIHRydWUgXHJcblx0Z2FtZS5hY3Rpb24gcXVlc3Rpb24gXCIje2dhbWUubG93fS0je2dhbWUuaGlnaH0gPiBcIlxyXG4iXX0=
//# sourceURL=c:\Lab\2019\100A-Guess-cmd-readLineSync\coffee\index.coffee