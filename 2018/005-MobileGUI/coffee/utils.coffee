isNumeric = (val) -> val == Number parseFloat val

hideCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'none'		

showCanvas = ->
	elem = document.getElementById 'myContainer'
	elem.style.display = 'block'

makeDiv = (value) ->
	b = document.createElement 'div'
	b.innerHTML = value
	b

makeInput = (title,value,readonly=false) ->
	b = document.createElement 'input'
	b.id = title
	b.value = value
	b.placeholder = title
	if readonly then b.setAttribute "readonly", true
	if title=='name' then b.autofocus = true
	b.onclick = "this.setSelectionRange(0, this.value.length)"
	b

makeButton = (title,n,f) ->
	b = document.createElement 'input'
	b.style.width = "#{Math.floor(100/n)}%"
	b.style.fontSize = "100%"
	b.style.webkitAppearance = "none"
	b.style.borderRadius = 0
	b.style.padding = 0
	b.type = 'button'
	b.value = title
	b.onclick = f
	b

addCell = (tr,value) ->
	td = document.createElement "td"
	td.appendChild value
	tr.appendChild td

getField = (name) ->
	element = document.getElementById name
	if element then element.value else null
