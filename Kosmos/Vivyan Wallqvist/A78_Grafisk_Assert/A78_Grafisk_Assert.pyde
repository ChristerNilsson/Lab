from Assert import Assert

def setup():
    size(400,620)
    global ass
    ass = Assert()
    
def draw():
    
    # Du behöver använda:
        
    # - color kan anges med ett, tre eller fyra tal
    #     ett:  0=svart, 255=vitt
    #     tre:  r,g,b. 0-255
    #     fyra: r,g,b,alpha. 0=helt genomskinlig 255=helt ogenomskinlig         
        
    # - stroke(color) (penna)
    # - noStroke()
    # - strokeWeight(n)

    # - fill(color)   (pensel)
    # - noFill()
            
    # - point(x,y)
    # - line(x1,y1,x2,y2)
    # - ellipse(x,y,w,h)
    # - rect(x,y,w,h)
    # - triangle(x1,y1,x2,y2,x3,y3)
    # - quad(x1,y1,x2,y2,x3,y3,x4,y4)
    # - arc(x,y,w,h,start,stopp,PIE)
    
    # - translate(x,y)         
    # - rotate(vinkel)
    # - radians(grader)
    # - rectMode(CENTER)
    
    # - textAlign(CENTER,CENTER)
    # - textSize(n)
    # - text("Python",x,y)
    
    # Byt ut "pass" nedan mot lämplig kod.
    # Noll pixlar fel = Du har gjort helt rätt!

    with ass.check("blackPoint"):
        if ass.ok():
            point(150,10)

    with ass.check("horizontalLine"): 
        if ass.ok():
            pass 

    with ass.check("verticalLine"): 
        if ass.ok():
            pass 
            
    with ass.check("yellowLine"): 
        if ass.ok():
            pass 

    with ass.check("whiteEmptyCircle"): 
        if ass.ok():
            pass 

    with ass.check("greenEllipse"): 
        if ass.ok():
            pass 

    with ass.check("greenRect"): 
        if ass.ok():
            pass 

    with ass.check("redRect"):
        if ass.ok():
            pass 

    with ass.check("whiteTriangle"):
        if ass.ok():
            pass 
            
    with ass.check("yellowQuad"):
        if ass.ok():
            pass 
            
    with ass.check("rotatedRect"):
        if ass.ok():
            pass 
        
    with ass.check("rotatedEllipse"):
        if ass.ok():
            pass 

    with ass.check("twoDiscsA"):
        if ass.ok():
            pass 

    with ass.check("twoDiscsB"):
        if ass.ok():
            pass 
            
    with ass.check("twoDiscsC"):
        if ass.ok():
            pass 
            
    with ass.check("twoDiscsD"):
        if ass.ok():
            pass 

    with ass.check("twoDiscsE"):
        if ass.ok():
            pass 

    with ass.check("twoDiscsF"):
        if ass.ok():
            pass 
            
    with ass.check("twoDiscsG"):
        if ass.ok():
            pass 

    with ass.check("twoDiscsH"):
        if ass.ok():
            pass 

    with ass.check("cross"):
        if ass.ok():
            pass 
                        
    with ass.check("textPython"):
        if ass.ok():
            pass 

    with ass.check("pacMan"):
        if ass.ok():
            pass 
            
    with ass.check("squareHole"):
        if ass.ok():
            pass 
            
    with ass.check("chessBoard"):
        if ass.ok():
            pass 
            
def keyPressed():
    ass.keyPressed()