class Human(object):
    def __init__(self, name):
        self.name = name

    def move(self, board):
        return input('What is your move, ' + self.name + ': ')
