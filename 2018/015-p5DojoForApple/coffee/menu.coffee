class Menu
	constructor : (@items, @table=null, @branch=[]) ->
	rensa : -> @table.innerHTML = ""
	clear : -> @branch = []

	traverse : (items=@items, level=0, br=[]) ->
		if false == goDeeper @branch,br then return

		if level == 0
			for key,i in _.keys items
				if i == @branch[level] or @branch.length == level
					@addTitle key, level, i, br.concat i
				children = items[key]
				@traverse children, level+1, br.concat i

		if level == 1
			for key,i in _.keys items
				if i == @branch[level] or @branch.length == level
					@addTitle key, level, i, br.concat i
				children = keywords[key].split ' '
				@traverse children, level+1, br.concat i

		if level == 2
			for item in items
				@addTitle item, level, i, br

	handleRow : (b) ->
		tr = document.createElement "tr"
		addCell tr,b,100
		@table.appendChild tr

	addTitle : (title,level,i,br) ->
		if level == 2 then b1 = makeButton title, BLACK,YELLOW
		else if @branch[level] == i then b1 = makeButton title, WHITE, BLACK
		else b1 = makeButton title, BLACK, WHITE
		b1.style.textAlign = 'left'
		b1.branch = br
		b1.style.paddingLeft = 10*level + "px"

		b1.onclick = => 
			if level in [0,1] then @branch = calcBranch @branch, b1.branch
			updateTables()

		@handleRow b1
