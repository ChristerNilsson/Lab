import time

persons = []
ticking = -1
start = time.time()

class Person:
    def __init__(self,id,name):
        self.id = id
        self.name=name
        self.friend = None
        self.time = 0
        self.inQueue = False
        self.decoration = ""
    def friendName(self):
        if self.friend: return self.friend.name
        return ""

def display():
    for person in persons:
        print person.id, '{:>10}'.format(person.name) + ' {:<10}'.format(person.friendName()), "%.2f" % person.time, person.decoration

def decorate():
    queue = [person for person in persons if person.inQueue]
    arr = sorted(queue, key=lambda person: person.time)
    for person in persons:
        person.decoration = ""
    for i in range(len(arr)):
        person = arr[i]
        person.decoration = i+1
    if ticking >= 0:
        persons[ticking].decoration = "*"

def debitera(id):
    seconds = time.time() - start
    if persons[id].friend==None:
        persons[id].time += seconds
    else:
        persons[id].time += seconds/2
        persons[id].friend.time += seconds/2

persons.append(Person(0,"Adam"))
persons.append(Person(1,"Bertil"))
persons.append(Person(2,"Cesar"))
persons.append(Person(3,"David"))
persons.append(Person(4,"Erik"))
persons.append(Person(5,"Filip"))

persons[0].friend = persons[2]
persons[2].friend = persons[0]
persons[0].time = 13.5
persons[1].time = 12.2
persons[2].time = 6.5
persons[3].time = 18.9
persons[4].time = 17
persons[5].time = 0

persons[1].inQueue = True
persons[5].inQueue = True
#persons[1].friend = persons[2]
#persons[2].friend = persons[1]
ticking = -1

while True:
    decorate()
    display()
    cmd = raw_input("Command:")
    if len(cmd) == 1: # ticking on/off
        id1 = "abcdef".index(cmd[0])
        if ticking == -1:
            start = time.time()
            ticking = id1
            persons[ticking].inQueue=False
        elif ticking == id1: # samma person, stoppa
            debitera(id1)
            start = 0
            ticking = -1
        elif ticking != -1: # olika personer
            debitera(ticking)
            start = time.time()
            ticking = id1
            persons[ticking].inQueue=False

    elif len(cmd) == 2:
        id1 = "abcdef".index(cmd[0])
        id2 = "abcdef".index(cmd[1])
        if id1 == id2:
            persons[id1].inQueue = not persons[id1].inQueue
        else:
            if persons[id1].friend == None and persons[id1].friend == None:
                persons[id1].friend = persons[id2]
                persons[id2].friend = persons[id1]
            else:
                friend =  persons[id1].friend
                friend.friend = None
                persons[id1].friend=None
