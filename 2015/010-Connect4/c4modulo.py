class Modulo(object):
    def __init__(self, name):
        self.name = name

    def move(self, board):
        return len(board.moves) % 7
