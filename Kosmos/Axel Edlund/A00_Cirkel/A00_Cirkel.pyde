
def setup():
    size(256,256)

def draw():
    #background (255,0,0)
    fill (mouseX,frameCount%256,00000)
    ellipse (128,128,mouseX,frameCount%256)
    