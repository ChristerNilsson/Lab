class Page

	constructor : (@columns, @init) -> 
		@table = getElem "table"
		@actions = {}

	addAction : (title, f) -> @actions[title] = f 

	action : (title) ->	@actions[title]()

	display : ->
		# actions
		if @columns==0 then @columns = _.size @actions 
		elem = getElem 'myActions'
		elem.innerHTML = ""
		div = null
		for title,i in _.keys @actions
			f = @actions[title]
			do (f) =>
				if i%@columns==0 then div = document.createElement "div"
				div.appendChild makeButton title, @columns, f
				if i%@columns==@columns-1 then elem.appendChild div
		elem.appendChild div

		@table.innerHTML = ""
		@init()
				
	addRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b
		@table.appendChild tr

storeData = (data) -> localStorage["007"] = JSON.stringify data
fetchData = -> JSON.parse if localStorage["007"] then localStorage["007"] else '[]'

isNumeric = (val) -> val == Number parseFloat val
getElem = (id) -> document.getElementById id

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

makeInput = (options,f) ->
	#title,value='',readonly=false
	b = document.createElement 'input'
	b.id = options.title
	if options.value then b.value = options.value
	b.placeholder = options.title
	if options.readonly then b.setAttribute "readonly", true
	if options.title=='name' then b.autofocus = true
	b.onclick = "this.setSelectionRange(0, this.value.length)"
	do (f) ->
		b.addEventListener "keyup", (event) ->
			if event.keyCode == 13 then f()
	b

makeButton = (title,n,f) ->
	b = document.createElement 'input'
	b.style.width = "#{Math.floor(100/n)}%"
	b.style.fontSize = "100%"
	b.style.fontFamily = 'monospace'
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
