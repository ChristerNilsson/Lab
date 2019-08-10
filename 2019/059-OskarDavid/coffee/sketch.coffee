hist = null 

MIN = 1
MAX = 100

setup = ->
	hist = []
	document.body.style.fontSize = "75px"
	init()

a = null
b = null
addbutton = null
mulbutton = null
divbutton = null
randbutton = null
undo = null

create = (typ,w,content,color="#000",fontSize='75px') ->
	elem = document.createElement typ
	document.body.appendChild elem
	elem.style.width = w
	elem.textContent = content
	elem.style.color =  color
	elem.style.float = 'left'
	elem.style.textAlign = 'center'
	elem.style.fontSize = fontSize
	elem 

a = create 'div','50%','3','#F00'

b = create 'div','50%',4
b.style.color =  "#0F0"

addbutton = create 'button',"33.33%",'+2'
addbutton.onclick = -> 
	hist.push a.textContent
	a.textContent = 2 + parseInt a.textContent
	if a.textContent == b.textContent 
		a.style.color = '#0F0'

mulbutton = create 'button',"33.33%",'*2'
mulbutton.onclick = -> 
	hist.push a.textContent
	a.textContent = 2 * parseInt a.textContent
	if a.textContent == b.textContent then a.style.color = '#0F0'

divbutton = create 'button',"33.33%",'/2'
divbutton.onclick = -> 
	n = parseInt a.textContent
	if n%2 == 0 
		hist.push a.textContent
		a.textContent = n / 2
	if a.textContent == b.textContent then a.style.color = '#0F0'

getNumber = (c,d) -> Math.floor c + Math.random() * (d-c+1)

init = ->
	a.style.color = "#F00"
	hist = []
	a.textContent = getNumber MIN,MAX
	b.textContent = getNumber MIN,MAX
	while a.textContent == b.textContent
		init()

randbutton = create 'button',"50%","Randomize","#000","60px"
randbutton.onclick = -> init()

undo = create 'button',"50%","Undo","#000", "5px"
undo.onclick = -> 
	if hist.length > 0
		a.textContent = hist.pop()

keyPressed = ->
	console.log keyCode
	if keyCode == 87 then	undo.onclick()
	if keyCode == 65 then addbutton.onclick()
	if keyCode == 83 then mulbutton.onclick()
	if keyCode == 68 then divbutton.onclick()
	if keyCode == 13 then randbutton.onclick()
