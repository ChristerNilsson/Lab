from board import Board

class Engine(object):

    def __init__(self,show):
        self.show = show

    def game(self,o,x,logfile):
        logfile.write(o.name + ' - ' + x.name + '\n\n')
        board = Board()
        board.clear()
        while True:
            marker = board.marker()
            if marker == 'O':
                player = o
                other = x
                other_marker = 'X'
            else:
                player = x
                other = o
                other_marker = 'O'
            m = player.move(board)
            if len(board.board[m]) > 5:
                logfile.write('Winner: ' + marker + '\n')
                return other.player + '-' + player.player
            else:
                board.move(m)
                logfile.write(board.display())
                winner = board.calc()
                if winner is True:
                    logfile.write('Winner: ' + other_marker + '\n')
                    return player.player + '-' + other.player
            if len(board.moves) == 42:
                logfile.write('Draw' + '\n')
                return "draw"