# kalaha med MonteCarlo
import random
import time

class Kalaha:

    def __init__(self,size):
        self.reset(size)
        self.board = []
        self.turn = 0  # or 7

    def factor(self):
        return 2 * self.turn / 7 - 1
        #return 1 if self.turn==0 else -1

    def reset(self,size):
        self.board = [size] * 14
        self.board[6] = 0
        self.board[13] = 0
        self.turn = 0
        return self.board

    def display(self):
        print self.board[7:][::-1]
        print "  ",self.board[0:7]

    def choice(self, iPit): # returns one position iPit = 0..5
        pos = iPit + self.turn
        count = self.board[pos]
        if count == 0:
            return False
        self.board[pos] = 0
        pos += 1
        while count > 0:
            if pos != 13 - self.turn:
                self.board[pos] += 1
                count -= 1
            pos += 1
            pos %= 14
        return True

    def repetition(self,i):
        return (i + self.board[i+self.turn]) % 13 == 6

    def flip(self):
        self.turn = 7 - self.turn

    def move(self, i):
        if self.board[i+self.turn] == 0:
            return False
        if self.repetition(i):
            self.choice(i)
        else:
            self.choice(i)
            self.flip()
        return True

    def randomMove(self): # ej repetitioner.
        a = [index for index in range(6) if self.board[index+self.turn] > 0]
        if len(a) == 0:
            return False
        c = random.sample(a,1)[0]
        #print c
        #self.display()
        if (c + self.board[c+self.turn]) % 13 == 6:
            self.choice(c)
        else:
            self.choice(c)
            self.flip()
        return True
           # self.randomMove()

    def randomThread(self):
        while self.randomMove():
            continue
        return self.board[6]-self.board[13]

    def copy(self):
        obj = Kalaha(0)
        obj.board = self.board[:]
        obj.turn = self.turn
        return obj

    def monteCarlo(self,n):
        lst = [0] * 6
        copy = self.copy()

        for i in range(6):
            if copy.choice(i):
                for j in range(n):
                    score = copy.randomThread()
                    #lst[i] += score
                    #copy.display()
                    if score > 0:
                        lst[i] += 1
                    elif score < 0:
                        lst[i] -= 1
                    copy = self.copy()
            else:
                lst[i] = 999999
        return lst

    def score(self):
        return self.board[6] - self.board[13]

    def getLegalMoves(self):
        return []

    def minimax(self, level):
        if level == 0:
            return [self.score(), -1]
        bestval = [-999999,-1]
        for iMove in range(6):
            cpy = self.copy()
            #cpy.display()
            if cpy.move(iMove):
                val = self.factor() * cpy.minimax(level-1)
                if val >= bestval[0]:
                    bestval = [val,iMove]
        return bestval

    # def moves(self):
    #     lst = []
    #     a = [index for index in range(6) if self.board[index+self.turn] > 0]
    #     copy = Kalaha(0)
    #     for i in a:
    #         if (i + self.board[i+self.turn]) % 13 == 6:
    #             copy.board = self.board[:]
    #             copy.choice(i)
    #             lst.append([i]+copy.moves())
    #         else:
    #             lst.append([i])
    #     return lst

    def bestIndex(self,lst):
        mini=0
        for i in range(len(lst)):
            if lst[mini]>lst[i]:
                mini=i
        return mini
        #return min((v, i) for i, v in enumerate(lst))[1]

    def run(self):
        self.reset(4)
        #self.board = [6,5,4,3,2,1,0,6,5,4,3,2,1,0]
        self.turn = 7
        #self.display()
        while True:
            # Fi flyttar
            start = time.time()
            while self.turn == 7:
                #lst = self.monteCarlo(2000)
                iMove = self.minimax(8)[1]
                if iMove == -1:
                    print "Game over"
                    return
                self.move(iMove)
                self.display()
            print time.time()-start
            # Vi flyttar
            while self.turn == 0:
                self.move(input(':'))
                self.display()


    def test(self):
        assert self.reset(4) == [4, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0]
        assert self.bestIndex([5,4,1,2,7,0]) == 5
        assert self.bestIndex([184, 191, 178, 136, 148, 127]) == 5

        self.reset(4)
        #assert self.choice(0) == [0,5,5,5,5,4,0,4,4,4,4,4,4,0]
        #self.reset(4)
        #assert self.choice(2) == [4,4,0,5,5,5,1,4,4,4,4,4,4,0]
        #self.reset(4)
       # self.board = [6,5,4,3,2,1,0,4,4,4,4,4,4,0]
       # print self.moves() #== [[0],[1],[2,0],[2,1],[2,3],[2,4],[2,5],[3],[4],[5]]
       # print len(self.moves())
        #print self.randomThread()
        #print self.monteCarlo(1000)


kalaha = Kalaha(4)
kalaha.test()
kalaha.reset(4)
kalaha.turn = 7
kalaha.randomMove()
#kalaha.display()
kalaha.run()