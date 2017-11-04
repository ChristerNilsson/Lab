state = [0,0,0]

setup = -> createCanvas windowWidth,windowHeight

lamp = (tänd, r,g,b, x,y) ->
	if tänd then fc r,g,b else fc 0
	circle x,y,50   

stoppljus = (index, red,redyellow,green,yellow,period, x) ->
	t = frameCount % period

	if t==red then state[index] = 0
	if t==redyellow then state[index] = 1
	if t==green then state[index] = 2
	if t==yellow then state[index] = 3

	lamp state[index] in [0,1], 1,0,0, x,100 # Red   
	lamp state[index] in [1,3], 1,1,0, x,200 # Yellow   
	lamp state[index] in [2],   0,1,0, x,300 # Green

draw = -> 
	stoppljus 0, 0,180,210,390,420, 100
	stoppljus 1, 0,120,150,270,300, 210
	stoppljus 2, 0,250,260,270,280, 320