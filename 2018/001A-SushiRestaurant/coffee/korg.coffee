class Korg
	constructor : ->
		@table = null
		@branch = []
		@items = []
		@targets = {}

	rensa : -> @table.innerHTML = ""		

	add : (item) -> @items.push item

	update0 : (b,item,delta) ->
		item[1] += delta
		b.value = item[1] 

	update1 : (b,items,source,delta,mapping) ->
		target = mapping[source]
		if items[target]-delta >= 0 
			items[target] -= delta
			items[source] += delta
			@targets[target].innerHTML = items[target] 
			b.value = items[source] 

	traverse : (mapping=null,items=@items,level=0, br=[]) ->
		if false == goDeeper @branch,br then return 
		if level==0
			for item,i in items
				[id,antal,pris,title,children,mapping1] = item
				@addTitle0 item,id,pris,title,br.concat(i),antal
				if children then @traverse mapping1,children,level+1,br.concat(i)
		else if level==1
			for key of items
				@addTitle1 items,key,sushi[key][1],br.concat(i),mapping

	handleRow : (b1,b2,b3) ->
		tr = document.createElement "tr"
		td1 = document.createElement "td"
		td2 = document.createElement "td"
		td3 = document.createElement "td"

		td1.style.cssText = "width:100%"
		td2.style.cssText = "width:5%"
		td3.style.cssText = "width:5%"

		@table.appendChild tr
		tr.appendChild td1
		tr.appendChild td2
		tr.appendChild td3

		td1.appendChild b1
		td2.appendChild b2
		td3.appendChild b3

	addTitle0 : (item,id,pris,title,br,antal) ->
		b1 = makeButton "#{id}. #{title} #{pris}kr" 
		b1.style.textAlign = 'left'
		b1.branch = br
		b1.onclick = => 
			@branch = calcBranch @branch, b1.branch
			updateTables()

		b2 = makeButton antal, GREEN,BLACK 
		b2.onclick = => @update0 b2,item,+1

		b3 = makeButton "-", RED,BLACK
		b3.onclick = => if b2.value > 0 then @update0 b2,item,-1

		@handleRow b1,b2,b3

	addTitle1 : (items,key,title,br,mapping) ->
		antal = items[key]
		b1 = document.createElement "div"
		b1.innerHTML = title  
		b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:right"

		if mapping and key of mapping
			b2 = makeButton antal,  GREEN,BLACK
			b3 = makeButton '-',RED,BLACK
		else
			b2 = makeDiv antal
			b3 = makeDiv ''
			@targets[key] = b2

		b2.onclick = => if mapping then @update1 b2,items,key,+1,mapping
		b3.onclick = => if mapping and b2.value>0 then @update1 b2,items,key,-1,mapping

		@handleRow b1,b2,b3

	clear : -> @items = []

	send : ->
		t = 0 # kr
		s = '' # full text
		u = '' # compact
		for [id,antal,pris,title,children] in @items
			if antal > 0
				ss =''
				if children 
					for key of children
						subantal = children[key]
						if subantal == 1
							ss += ' ' + key
						else if subantal > 1
							ss += ' ' + subantal + key
				s += antal + ' x ' + id + ". " + title + ss + CRLF
				t += antal * pris
				if antal == 1 
					u += id + ss + CRLF
				else
					u += antal + 'x' + id + ss + CRLF

		if t==0 then return 

		console.log t
		console.log s
		console.log u
		output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + CRLF + t + " kr"
		if output.length > 2000 
			output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + u + CRLF + t + " kr"
		console.log output.length
		console.log output 
		window.open output,'_blank'
