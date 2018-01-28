BLACK  = "#000"
WHITE  = "#FFF"
YELLOW = "#FF0"

class Tree
	constructor : (@tree, id='tree') ->
		@div = document.getElementById id
		@traverse []

	traverse : (branch) ->
		@div.innerHTML = ""
		node = @tree
		for key,i in branch
			node = node[key]
			if key in branch then	arr = branch.slice 0,i
			else arr = branch.concat key
			do (arr) => @button key, i, WHITE, BLACK, => @traverse arr

		keys = Object.keys node
		for key in keys.sort()
			children = node[key]
			if key in branch then arr = branch.slice 0, branch.length-1
			else if Object.keys(children).length > 0 then arr = branch.concat key
			else arr = branch
			do (arr) => @button key, branch.length, BLACK, YELLOW, => @traverse arr

	button : (value,level,bg,sc,onclick) ->
		res = document.createElement "input"
		res.type = 'button'
		res.value = value 
		res.style.width = "100%" 
		res.style.backgroundColor = bg 
		res.style.color = sc
		res.style.textAlign = 'left'
		res.style.paddingLeft = 10*level + "px"
		res.onclick = onclick
		@div.appendChild res
