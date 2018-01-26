drop = (arr) -> arr.slice 0, arr.length-1

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
		b = makeButton title, BLACK,YELLOW
		b.style.textAlign = 'left'
		b.style.paddingLeft = 10*level + "px"
		tr = document.createElement "tr"
		addCell tr,b,100
		@table.appendChild tr
		b