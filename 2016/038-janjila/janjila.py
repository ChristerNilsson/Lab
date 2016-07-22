# -*- coding: utf-8 -*-
# An idea from Mickel Jörgensen

# todo Repetition då man slutar i egen kalaha
# todo Känn av vilket drag som ska utföras med mousePressed
# todo AI med Monte Carlo

import copy

desc = {'x':[],'y':[],'r':[],'c':[],'p':[],'m':[],'ackumulators':[],'owner':[]}

class Board:
    def __init__(self):
        self.reset()
    def reset(self):
        self.color = [] # 32 element
        self.stones = [] # 16 x 2 element
        self.pending = [] # 2 element
        self.hints = [] # 16 element
        self.turn = 0
        self.history = [] # Mycket lokal. innehåller bara senaste dragen. defgh
        self.undo = None
    def display(self):
        self.make_hints()
        res = []
        res.append(['x',desc['x']])
        res.append(['y',desc['y']])
        res.append(['r',desc['r']])
        res.append(['c',desc['c']])
        res.append(['m',desc['m']])
        res.append(['p',desc['p']])
        res.append(['color',self.color])
        res.append(['stones',self.stones])
        res.append(['hints',self.hints])
        res.append(['pending',self.pending])

        f = open("lab\data.json", "w")
        f.write("{\n" + ",\n".join(['  "'+name+'":'+str(lst) for name,lst in res]) + "\n}")
        f.flush()
        f.close()

    def make_hints(self):
        self.hints = [0]*len(self.stones)
        if self.history == []:
            for i in range(len(self.stones)):
                if i not in desc['ackumulators'] and self.turn%2==desc['owner'][i] and sum(self.stones[i])>0:
                    self.hints[i] = 1
        else:
            for im in range(len(desc['m'])):
                move = desc['m'][im]
                if self.history[-1] == move[0]:
                    if self.pending[self.color[im]] > 0:
                        self.hints[move[1]] = 1

    def movestep(self,a,b): # a,b i 0..15
        m = desc['m'].index([a,b]) # vilket nummer har draget?
        currentcolor = self.color[m]
        self.flipcolor(m)
        self.pending[currentcolor] -= 1
        self.stones[b][currentcolor] += 1

    def move(self,letter):
        index = 'ABCDEFGHIJKLMNOP'.index(letter.upper())
        self.history.append(index)
        if len(self.history) > 1:
            self.movestep(self.history[-2],self.history[-1])
            if sum(self.pending) == 0:
                if self.history[-1] != desc['ackumulators'][self.turn%2]:
                    self.turn += 1
                self.history = []
                self.undo = None
        else:
            self.undo = copy.deepcopy(self)
            self.pending = self.stones[self.history[0]]
            self.stones[self.history[0]] = [0,0]
    def flipcolor(self,m):
        self.color[m] = (self.color[m]+1) % len(desc['c'])

class Janjila:
    def __init__(self,filename):
        self.board = Board()
        self.construct(filename)
    def construct(self,filename):
        f = open(filename, 'r')
        lines= f.readlines()
        f.close()
        for line in lines:
            arr = line.split('#')
            commands = arr[0].strip()
            if commands == '': continue
            items = commands.split(' ')
            command = items[0]
            items = [int(item) for item in items[1:]]
            if command in ['x','y']:
                res = [0]
                for item in items:
                    res.append(res[-1]+item)
                desc[command] += res[1:]
            elif command in ['r','c']:
                desc[command].append(items)
            elif command in ['m']:
                desc[command].append(items[0:2])
                self.board.color.append(items[2])
            elif command in ['b','w']:
                desc['p'].append(items[0:2])
                desc['owner'].append(['b','w'].index(command))
                self.board.stones.append(items[2:])
            else:
                print "Barf!"
        for ip in range(len(desc['p'])):
            if sum(self.board.stones[ip])==0:
                desc['ackumulators'].append(ip)

    def run(self):
        while True:
            janjila.board.display()
            command = raw_input('Move:')
            if command == 'undo':
                if self.board.undo != None:
                    self.board = self.board.undo
                    self.board.undo = None
                    self.board.history = []
                else:
                    print "Undo ej möjligt."
            else:
                self.board.move(command)

#janjila = Janjila('janjila.txt')
janjila = Janjila('kalaha.txt')
janjila.run()

#janjila.board.move('defgh')
#janjila.board.move('lnbcef') # lnbceg är omöjlig

#janjila.board.move('defgh cdfgh ghjlnbc')
#janjila.board.move('lnbcef') # lnbceg är omöjlig
