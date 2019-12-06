SIZE = 0

col = [255,0,0]
d = [-1,1,0]
counter = 0
xoff = 0

rows = """
      cccc     
    cccccccc   
   cccccccccc  
  cwwccccwwccc 
  wwwwccwwwwcc 
  bbwwccbbwwcc 
 cbbwwccbbwwccc
 ccwwccccwwcccc
 cccccccccccccc
 cccccccccccccc
 cccccccccccccc
 cccccccccccccc
 cccccccccccccc
 cc ccc  ccc cc
 c   cc  cc   c
 """.split '\n'

console.log rows

setup = =>
	createCanvas windowWidth,windowHeight
	SIZE = windowHeight/15
	xoff = (width-height)/2
	console.log xoff
	sc()

draw = =>
	bg 0
	for row,j in rows
		for letter,i in row
			if letter == ' ' then noFill()
			else if letter == 'c' then fill col
			else if letter == 'b' then fill 0
			else fill 255
			rect xoff+SIZE*i,SIZE*j,SIZE,SIZE
	if frameCount%2 == 0
		counter++
		if counter % 257 == 256
			for i in range 3
				d[i] = if col[i] > 128 then _.random -1,0 else _.random 0,1
		else col[i] += d[i] for i in range 3
