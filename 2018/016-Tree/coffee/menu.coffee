drop = (arr) -> arr.slice 0, arr.length-1

BLACK  = "#000"
WHITE  = "#FFF"
GREEN  = "#0F0"
RED    = "#F00"
YELLOW = "#FF0"

range = _.range

class Menu
	constructor : (@tree, id='meny') ->
		@table = document.getElementById id

		@traverse []
		#@traverse ['Europa']
		#@traverse ['Europa','Sverige']

	traverse : (branch) ->
		@table.innerHTML = ""
		node = @tree
		for key,i in branch
			node = node[key]
			if key in branch 
				arr = branch.slice 0,i
			else 
				arr = branch.concat key
			do (arr) => 
				@addTitle key,i, => @traverse arr

		keys = _.keys node
		for key in keys.sort()
			children = node[key]
			if key in branch
				arr = drop branch
			else if _.size(children) > 0
				arr = branch.concat key
			else
				arr = branch
			do (arr) => 
				@addTitle key,branch.length, => @traverse arr

	addTitle : (title,level,onclick) ->
		b = @makeButton title, BLACK,YELLOW, onclick
		b.style.textAlign = 'left'
		b.style.paddingLeft = 10*level + "px"
		tr = document.createElement "tr"
		@addCell tr,b,100
		@table.appendChild tr

	addCell : (tr,value,width) ->
		td = document.createElement "td"
		td.style.cssText = "width:#{width}%"
		td.appendChild value
		tr.appendChild td

	makeButton : (value,bg,sc,onclick) ->
		res = document.createElement "input"
		res.type = 'button'
		res.value = value 
		res.style.cssText = "font-size:100%; white-space:normal; width:100%;" 
		res.style.backgroundColor = bg 
		res.style.color = sc
		res.onclick = onclick
		res
