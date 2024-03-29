// Generated by CoffeeScript 2.4.1
var Game, game, readline, rl;

Game = require('../../100-Guess-Library/game.js');

game = new Game(2);

readline = require('readline');

rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  prompt: " > "
});

console.log(`${game.low}-${game.high}`);

rl.prompt();

rl.on('line', (line) => {
  game.action(line);
  console.log(`${game.low}-${game.high}`);
  return rl.prompt();
}).on('close', () => {
  return process.exit(0);
});

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcaW5kZXguY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQSxJQUFBLElBQUEsRUFBQSxJQUFBLEVBQUEsUUFBQSxFQUFBOztBQUFBLElBQUEsR0FBTyxPQUFBLENBQVEsaUNBQVI7O0FBRVAsSUFBQSxHQUFPLElBQUksSUFBSixDQUFTLENBQVQ7O0FBRVAsUUFBQSxHQUFXLE9BQUEsQ0FBUSxVQUFSOztBQUNYLEVBQUEsR0FBSyxRQUFRLENBQUMsZUFBVCxDQUNIO0VBQUEsS0FBQSxFQUFPLE9BQU8sQ0FBQyxLQUFmO0VBQ0EsTUFBQSxFQUFRLE9BQU8sQ0FBQyxNQURoQjtFQUVBLE1BQUEsRUFBUTtBQUZSLENBREc7O0FBS0wsT0FBTyxDQUFDLEdBQVIsQ0FBWSxDQUFBLENBQUEsQ0FBRyxJQUFJLENBQUMsR0FBUixDQUFZLENBQVosQ0FBQSxDQUFlLElBQUksQ0FBQyxJQUFwQixDQUFBLENBQVo7O0FBQ0EsRUFBRSxDQUFDLE1BQUgsQ0FBQTs7QUFFQSxFQUFFLENBQUMsRUFBSCxDQUFNLE1BQU4sRUFBYyxDQUFDLElBQUQsQ0FBQSxHQUFBO0VBQ1osSUFBSSxDQUFDLE1BQUwsQ0FBWSxJQUFaO0VBQ0EsT0FBTyxDQUFDLEdBQVIsQ0FBWSxDQUFBLENBQUEsQ0FBRyxJQUFJLENBQUMsR0FBUixDQUFZLENBQVosQ0FBQSxDQUFlLElBQUksQ0FBQyxJQUFwQixDQUFBLENBQVo7U0FDQSxFQUFFLENBQUMsTUFBSCxDQUFBO0FBSFksQ0FBZCxDQUlBLENBQUMsRUFKRCxDQUlJLE9BSkosRUFJYSxDQUFBLENBQUEsR0FBQTtTQUFHLE9BQU8sQ0FBQyxJQUFSLENBQWEsQ0FBYjtBQUFILENBSmIiLCJzb3VyY2VzQ29udGVudCI6WyJHYW1lID0gcmVxdWlyZSAnLi4vLi4vMTAwLUd1ZXNzLUxpYnJhcnkvZ2FtZS5qcydcclxuXHJcbmdhbWUgPSBuZXcgR2FtZSAyXHJcblxyXG5yZWFkbGluZSA9IHJlcXVpcmUgJ3JlYWRsaW5lJ1xyXG5ybCA9IHJlYWRsaW5lLmNyZWF0ZUludGVyZmFjZVxyXG4gIGlucHV0OiBwcm9jZXNzLnN0ZGluLFxyXG4gIG91dHB1dDogcHJvY2Vzcy5zdGRvdXQsXHJcbiAgcHJvbXB0OiBcIiA+IFwiXHJcblxyXG5jb25zb2xlLmxvZyBcIiN7Z2FtZS5sb3d9LSN7Z2FtZS5oaWdofVwiXHJcbnJsLnByb21wdCgpXHJcblxyXG5ybC5vbiAnbGluZScsIChsaW5lKSA9PiBcclxuICBnYW1lLmFjdGlvbiBsaW5lXHJcbiAgY29uc29sZS5sb2cgXCIje2dhbWUubG93fS0je2dhbWUuaGlnaH1cIlxyXG4gIHJsLnByb21wdCgpXHJcbi5vbiAnY2xvc2UnLCA9PiBwcm9jZXNzLmV4aXQgMFxyXG4iXX0=
//# sourceURL=c:\Lab\2019\100B-Guess-cmd-readLine\coffee\index.coffee