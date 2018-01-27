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
			b = @addTitle key,i
			do (arr) => b.onclick = => @traverse arr

		keys = _.keys node
		for key in keys.sort()
			children = node[key]
			if key in branch
				arr = drop branch
			else if _.size(children) > 0
				arr = branch.concat key
			else
				arr = branch
			b = @addTitle key,branch.length
			do (arr) => b.onclick = => @traverse arr

	addTitle : (title,level) ->
		b = @makeButton title, BLACK,YELLOW
		b.style.textAlign = 'left'
		b.style.paddingLeft = 10*level + "px"
		tr = document.createElement "tr"
		@addCell tr,b,100
		@table.appendChild tr
		b

	addCell : (tr,value,width) ->
		td = document.createElement "td"
		td.style.cssText = "width:#{width}%"
		td.appendChild value
		tr.appendChild td

	makeButton : (value,bg,sc) ->
		res = document.createElement "input"
		res.type = 'button'
		res.value = value 
		res.style.cssText = "font-size:100%; white-space:normal; width:100%;" 
		res.style.backgroundColor = bg 
		res.style.color = sc
		res

