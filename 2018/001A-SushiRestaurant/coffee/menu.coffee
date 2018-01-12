class Menu
	constructor : (@items, @table=null, @branch=[0]) ->
	rensa : -> @table.innerHTML = ""
	clear : -> @branch = [0]

	traverse : (items=@items, level=0, br=[]) ->
		# for item,i in items
		# 	b1 = document.createElement "div"
		# 	b1.innerHTML = i
		# 	@handleRow b1
		# return

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

	handleRow : (b1) ->
		tr = document.createElement "tr"
		td1 = document.createElement "td"
		td1.style.cssText = "width:100%"
		@table.appendChild tr
		tr.appendChild td1
		td1.appendChild b1

	addTitle : (item,id,pris,title,count,level,br,i) ->
		#b1 = document.createElement "div"
		#b1.innerHTML = title

		if count>0 then scount = " (#{count})" else scount =""
		v = title + scount 
		if id!='' then v = "#{id}. #{v} #{pris}kr" 
		if level == 2 
			b1 = makeButton v, YELLOW, BLACK
		else if @branch[level] == i
			b1 = makeButton v, WHITE, BLACK
		else
			b1 = makeButton v, BLACK, WHITE
		b1.style.textAlign = 'left'
		b1.branch = br

		#b1.style.position = 'relative' 
		#b1.style.left = 15*level + 'px' 

		b1.onclick = => 
			if level in [0,1]
				@branch = calcBranch @branch, b1.branch
			if level == 2
				newitem = _.clone item
				newitem[4] = _.clone item[4]
				korg.add newitem
				@branch = [0]
			updateTables()

		@handleRow b1
