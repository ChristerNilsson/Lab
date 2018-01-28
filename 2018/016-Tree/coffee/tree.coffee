class Tree
	constructor : (@tree, id='tree') ->
		@div = document.getElementById id
		@traverse []

	traverse : (branch) ->
		#console.clear()
		#console.log branch
		@div.innerHTML = ''
		node = @tree
		for key,i in branch
			node = node[key]
			if key in branch then	branch1 = branch.slice 0,i
			else branch1 = branch.concat key
			@button key, i, 0, branch1

		for key in Object.keys(node).sort()
			children = node[key]
			if key in branch then branch1 = branch.slice 0, branch.length-1
			else if Object.keys(children).length > 0 then branch1 = branch.concat key
			else branch1 = branch
			@button key, branch.length, 1, branch1

	button : (key,level,color,branch) ->
		#console.log key,level,color,branch
		res = document.createElement 'input'
		res.type = 'button'
		res.value = key 
		res.style.width = '100%' 
		res.style.backgroundColor = '#FFF #000'.split(' ')[color]
		res.style.color           = '#000 #FFF'.split(' ')[color]
		res.style.textAlign = 'left'
		res.style.paddingLeft = 10*level + 'px'
		res.onclick = => @traverse branch
		@div.appendChild res
