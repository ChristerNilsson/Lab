class Area:
    
    def __init__(self,x,y,w,h,name):
        self.x=x
        self.y=y
        self.w=w
        self.h=h
        self.name=name
        textSize(24)
        fill(0)
        text(name, self.x + self.w+20, self.y+30)

    def coords(self):
        fill(204)
        noStroke()
        rect(self.x,self.y,self.w,self.h)
        stroke(0)
        strokeWeight(1)
        with pushMatrix():
            translate(self.x,self.y)
            for x in range(0,self.w+1,20): line(x,0,x,self.h)      
            for y in range(0,self.h+1,20): line(0,y,self.w,y)
                  
    def save(self,filename):
        image = get(self.x,self.y,self.w+1,self.h+1) 
        image.save("data\\" + filename)
    
    def myget(self):
        self.image = get(self.x,self.y,self.w,self.h)
        return self.image

    def myset(self,img):
        set(self.x,self.y,img)