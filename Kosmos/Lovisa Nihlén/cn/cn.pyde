deadline = 0

def setup():
    size(1024,1024)
    

def draw():
    global deadline
    background(0)
    if millis() > deadline:
        saveFrame()
        deadline += 500
        print deadline,frameCount