hideCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'		

showCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

# makeDiv = (title) ->
# 	b = document.createElement 'div'
# 	b.innerHTML = title
# 	b

makeInput = (title,value) ->
	b = document.createElement 'input'
	b.id = title
	b.value = value 
	b.placeholder = title
	b

makeButton = (title,f) ->
	b = document.createElement 'input'
	b.type = 'button'
	b.value = title
	b.onclick = f
	b

addCell = (tr,value) ->
	td = document.createElement "td"
	td.appendChild value
	tr.appendChild td

getField = (name) ->
	element = document.getElementById(name)
	if element then element.value else null

