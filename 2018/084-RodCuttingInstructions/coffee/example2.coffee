indexen = [1,2,3,4,5,6,7,8,9,10]
v = [1,5,8,9,0,0,0,0,0,0]
c = [0,0,0,0,0,0,0,0,0,0]

parts = []

g1 = null
g2 = null

fixa = (i,value,i1,i2) ->
	x = i+1.5
	g1.add new Text indexen[i],x,0,"i=#{i+1}"
	g1.add new Text v[i],x,1,"v[#{i+1}] = #{v[i]}"
	g1.add new Text v[i],x,4+5,"Kopiera ner v[#{i+1}]"
	for j in range i
		k = i-j-1
		g1.add new Text v[j],j+1.5,1,"Summera v[#{j+1}] = #{v[j]} ..."
		g1.add new Text c[k],k+1.5,2,"... och c[#{k+1}] = #{c[k]}"
		g1.add new Text v[j]+c[k],x,j+5+5,"#{v[j]} + #{c[k]} = #{v[j]+c[k]}"
	g1.add new Text value,x,2,"Bit med längd #{i+1} delas i #{i1+1} och #{i2+1}"
	c[i] = value

fix2 = (x,e,f,g,h) ->
	parts.push [e,f,g,h]
	g2.add new Text e,x+0.5,0,"Bit med längd #{x} värd #{v[x-1]} delas ej"
	g2.add new Text f,x+0.5,1,"Bit med längd #{x} värd #{v[x-1]} delas ej"
	g2.add new Text g,x+0.5,2,"Bit med längd #{x} värd #{v[x-1]} delas ej"
	g2.add new Text h,x+0.5,3,"Bit med längd #{x} värd #{v[x-1]} delas ej"

fix3 = (x,i,j) ->
	e = parts[i][0] + parts[j][0]
	f = parts[i][1] + parts[j][1]
	g = parts[i][2] + parts[j][2]
	h = parts[i][3] + parts[j][3]
	parts.push [e,f,g,h]

	g2.add new Text e,x+0.5,0,"Bit med längd #{x} värd #{v[x-1]} delas i #{i+1} och #{j+1}"
	g2.add new Text f,x+0.5,1,"Bit med längd #{x} värd #{v[x-1]} delas i #{i+1} och #{j+1}"
	g2.add new Text g,x+0.5,2,"Bit med längd #{x} värd #{v[x-1]} delas i #{i+1} och #{j+1}"
	g2.add new Text h,x+0.5,3,"Bit med längd #{x} värd #{v[x-1]} delas i #{i+1} och #{j+1}"

makeCommands = ->

	g1 = new Grid 2, 1, 4,1, 11, 3,true,'Rod Cutting: Använd piltangenterna eller mushjulet'
	g2 = new Grid 2, 5, 4,1, 11, 4,true,'Parts'
	g2.add new Text v[0],0.5,0,"parts[1][1]"
	g2.add new Text v[1],0.5,1,"parts[1][2]"
	g2.add new Text v[2],0.5,2,"parts[1][3]"
	g2.add new Text v[3],0.5,3,"parts[1][4]"

	g1.add new Text 'i',0.5,0,"indexraden (samma som storlek)"
	g1.add new Text 'v',0.5,1,"värderaden (priset för en bit med en viss storlek)"
	g1.add new Text 'c',0.5,2,"c-raden (det korrigerade värdet, efter uppdelning)"

	fixa 0,1
	fix2 1,1,0,0,0

	fixa 1,5
	fix2 2,0,1,0,0

	fixa 2,8
	fix2 3,0,0,1,0

	fixa 3,10,1,1
	fix3 4,1,1

	fixa 4,13,1,2
	fix3 5,1,2

	fixa 5,16,2,2
	fix3 6,2,2

	fixa 6,18,1,4
	fix3 7,1,4

	fixa 7,21,1,5
	fix3 8,1,5

	fixa 8,24,2,5
	fix3 9,2,5

	fixa 9,26,1,7
	fix3 10,1,7
