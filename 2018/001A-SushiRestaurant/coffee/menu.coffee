class Menu
	constructor : ->
		@table = null
		@branch = [] 
		@items = []

	traverse : (items=@items, level=0, br=[]) ->
		#console.log 'meny.traverse',items,level,br
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
					@addTitle x,x[0],x[2],x[3],calc(x[4]),level,br,i

	addTitle : (item,id,pris,title,count,level,br,i) ->
		if count>0 then scount = " (#{count})" else scount =""
		v = '........'.slice(0,4*level) + title + scount
		if @branch[level] == i
			b1 = makeButton v, "#FFFFFF", "#000000"
		else
			b1 = makeButton v, "#000000", "#FFFFFF"
		b1.style.textAlign = 'left'
		b1.branch = br

		b1.onclick = => 
			if level in [0,1]
				@branch = calcBranch @branch, b1.branch
			else if level == 2
				newitem = _.clone item
				newitem[4] = _.clone item[4]
				korg.add newitem
			updateTables()

		tr = document.createElement "tr"
		td0 = document.createElement "td"
		td1 = document.createElement "td"
		td0.style.cssText = "width:5%"
		td1.style.cssText = "width:85%"
		@table.appendChild tr
		tr.appendChild td0
		tr.appendChild td1
		div = document.createElement "div"
		div.style.cssText = "font-size:70%"
		if id != '' 
			div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-'
		td0.appendChild div
		td1.appendChild b1

