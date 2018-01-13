class Menu
	constructor : (@items, @table=null, @branch=[0]) ->
	rensa : -> @table.innerHTML = ""
	clear : -> @branch = [0]

	traverse : (items=@items, level=0, br=[]) ->
		if false == goDeeper @branch,br then return 
		if level in [0,1]
			for item,i in items
				[title,children...] = item
				if level==0
					@addTitle null,'',0,title,children.length,level,br.concat(i),i
				else
					count = 0
					for x in children
						count += x.length
					@addTitle null,'',0,title,count,level,br.concat(i),i
				@traverse children, level+1, br.concat(i) 
		if level == 2
			for item in items
				for x in item
					@addTitle x,x[0],x[2],x[3],sum(x[4]),level,br,i

	handleRow : (b1,b2) ->
		tr = document.createElement "tr"
		if not b2 then b2 = makeDiv ''
		addCell tr,b1,100
		addCell tr,b2,10
		@table.appendChild tr

	addTitle : (item,id,pris,title,count,level,br,i) ->
		if count>0 and level>1 then scount = " (#{count})" else scount =""
		v = title + scount 
		if id!='' then v = "#{id}. #{v}" 
		if level == 2 
			b1 = makeButton v, YELLOW, BLACK
			b2 = makeDiv pris + "kr"
			b2.style.textAlign = 'right'
		else if @branch[level] == i
			b1 = makeButton v, WHITE, BLACK
			b2 = makeDiv ''
		else
			b1 = makeButton v, BLACK, WHITE
			b2 = makeDiv ''
		b1.style.textAlign = 'left'
		b1.branch = br
		b1.style.paddingLeft = 10*level + "px"

		b1.onclick = => 
			if level in [0,1]
				@branch = calcBranch @branch, b1.branch
			if level == 2
				newitem = _.clone item
				newitem[4] = _.clone item[4]
				korg.add newitem
				@branch = [0]
			updateTables()

		@handleRow b1,b2
