class Random(object):
    def __init__(self, name):
        self.name = name

    def move(self, board):
        return board.rand()