class Human(object):
    def __init__(self, name):
        self.name = name

    def move(self, board):
        s = raw_input('What is your move, ' + self.name + ': ')
        x = 'abcdefgh'.index(s[0])
        y = int(s[1])-1
        return (x,y)
