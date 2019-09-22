{ question } = require 'readline'
Game = require '../../100-Guess-Library/game.js'

game = new Game 2

readline = require 'readline'
rl = readline.createInterface
  input: process.stdin,
  output: process.stdout,
  prompt: " > "

console.log "#{game.low}-#{game.high}"
rl.prompt()

rl.on 'line', (line) => 
  game.action line
  console.log "#{game.low}-#{game.high}"
  rl.prompt()
.on 'close', => process.exit 0
