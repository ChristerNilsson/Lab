'use strict'

/** Class representing a game state. */
class State {

  constructor(playHistory, board, player) {
    this.playHistory = playHistory
    this.board = board
    this.player = player
  }

  isPlayer(player) {
    return (player === this.player)
  }

  hash() {
    return JSON.stringify(this.playHistory)
  }

  prettyBoard() {
    var s='\n'
    for (let i=0; i<6; i++) {
      for (let j=0; j<7; j++) {
        var item = this.board[i][j]
        s += "O.X"[item+1]+' '
        //print(s)
      }
      s += "\n"
    }
    return s
  }

  // Note: If hash uses board, multiple parents possible
}

// module.exports = State_C4
