import sys
from Area import Area 

EXT = ".png"

class Assert:
    
    def __init__(self):
        self.equal = True
        self.images = {}
        self.result = {}
        self.area1 = Area(5,5,200,200,"Your Area")
        self.area2 = Area(5,210,200,200,"Correct")
        self.area3 = Area(5,415,200,200,"Difference")

    def check(self,filename): # missing ext
        if self.equal == True:
            self.filename = filename
            if filename in self.images:
                img = self.images[filename]
            else:
                img = loadImage(filename + EXT)
            a = self.area2
            if img == None:
                fill(204)
                #noStroke()
                stroke(0)
                rect(a.x,a.y,a.w,a.h)
            else: 
                self.images[filename] = img
                image(img, a.x, a.y)
                
        fill(204)
        stroke(0)
        strokeWeight(1)
        rect(225,100,150,50)   
        fill(0)
        if 5 < mouseX < 205 and (mouseY-5) % 205 < 200 :
            textSize(16)
            textAlign(CENTER,BOTTOM)
            text("x="+str(mouseX-5),300,125)
            text("y="+str((mouseY-5)%205),300,145)
                
        return self
        
    def __enter__(self):
        return self
    
    def __exit__(self, type, value, tb):
        if self.filename not in self.result:
            count = self.compare()
            resetMatrix()
            rectMode(CORNER)
            fill(255)
            stroke(255)
            textAlign(CENTER,BOTTOM)
            textSize(16)
            fill(204)
            strokeWeight(1)
            rect(225,300,150,50)
            rect(225,500,150,50)
            fill(0)
            text(self.filename,300,335)
            if count==0:
                fill(0,128,0)
            else:
                fill(255,0,0)
            text(str(count) + " pixel errors",300,535)
            self.result[self.filename] = count==0
        else:
            resetMatrix()
            rectMode(CORNER)
        
    def split(self,c):
        r = c & 0xFF 
        c = c >> 8; g = c & 0xFF 
        c = c >> 8; b = c & 0xFF
        return [r,g,b]
    
    def compare(self):
        count = 0
        
        img1 = self.area1.myget()
        img2 = self.area2.myget()
        img3 = self.area3.myget()
        
        for i in range(200):
            for j in range(200):
                r1,g1,b1 = self.split(img1.get(i,j))
                r2,g2,b2 = self.split(img2.get(i,j))
                c = color(r1^r2, g1^g2, b1^b2)
                img3.set(i,j,c) 
                if c != color(0): count += 1
        self.area3.myset(img3)        
        self.equal = count==0
        if self.equal == False: self.filename2 = self.filename
        if count > 0: print count,self.filename2
        return count
   
    def ok(self):
        if self.equal: 
            self.area1.coords()
            translate(self.area1.x,self.area1.y)
            #self.area2.coords()
            #self.area3.coords()
        return self.equal
    
    def keyPressed(self):
        if key == "!": 
            self.area1.save(self.filename2 + EXT)!

            