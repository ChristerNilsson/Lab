class Korg
	constructor : ->
		@table = null
		@branch = []
		@items = []
		@targets = {}

	rensa : -> @table.innerHTML = ""
	add : (item) -> @items.push item

	updateTotal : ->
		[count,total] = @total()
		send.innerHTML = "Order (#{count} meal#{if count==1 then '' else 's'}, #{total}kr)"	

	update0 : (b,item,delta) ->
		if item[1] + delta < 0 then return 
		item[1] += delta
		b.value = pretty item[1], item[2] 
		@updateTotal()

	update1 : (b,items,source,dir,mapping,delta) ->
		deltaValue = dir
		if delta and delta[source] then deltaValue = dir * delta[source]
		target = mapping[source]
		if items[target]-deltaValue >= 0 
			items[target] -= deltaValue
			items[source] += deltaValue
			@targets[target].innerHTML = items[target] 
			b.value = items[source] 

	traverse : (items=@items, mapping=null, passive=null, delta=null, level=0, br=[]) ->
		if false == goDeeper @branch,br then return 
		if level == 0
			for item,i in items
				[id,antal,pris,title,children,mapping1,passive1,delta1] = item
				@addTitle0 item,id,pris,title,br.concat(i),antal,children
				if children then @traverse children,mapping1,passive1,delta1,level+1,br.concat(i)
		else if level==1
			for key of items
				@addTitle1 items,key,klartext[key][1],br.concat(i),mapping,passive,delta

	handleRow : (b1,b2,b3) ->
		tr = document.createElement "tr"
		addCell tr,b1,100
		addCell tr,b2,5
		addCell tr,b3,5
		@table.appendChild tr

	addTitle0 : (item,id,pris,title,br,antal,children) ->
		if children
			b1 = makeButton "#{id}. #{title}" 
			b1.style.textAlign = 'left'
			b1.branch = br
			b1.onclick = => 
				@branch = calcBranch @branch, b1.branch
				updateTables()

		else
			b1 = document.createElement "div"
			b1.innerHTML = "#{id}. #{title}"  
			b1.style.cssText = "font-size:100%; white-space:normal; width:100%;"

		b2 = makeButton pretty(antal,pris), GREEN,BLACK 
		b2.onclick = => @update0 b2,item,+1

		b3 = makeButton "Del", RED,BLACK
		b3.onclick = => @update0 b2,item,-1

		@handleRow b1,b2,b3

	addTitle1 : (items,key,title,br,mapping,passive,delta) ->
		antal = items[key]
		b1 = document.createElement "div"
		b1.innerHTML = title  
		b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:right"

		if passive 
			if key in passive
				b2 = makeDiv antal
				b3 = makeDiv ''
				@targets[key] = b2
			else
				b2 = makeButton antal, GREEN,BLACK
				b3 = makeButton 'Del',RED,BLACK
		else
			b2 = makeDiv antal
			b3 = makeDiv ''

		b2.style.textAlign = "center"

		b2.onclick = => @update1 b2,items,key,+1,mapping,delta
		b3.onclick = => if b2.value>0 then @update1 b2,items,key,-1,mapping,delta

		@handleRow b1,b2,b3

	total : ->
		res = 0
		count = 0
		for [id,antal,pris] in @items
			res += antal * pris
			if id not in nonMeals then count += antal
		[count,res] 

	clear : -> 
		newitems = @items.filter (e) -> e[1] != 0
		if newitems.length == @items.length
			@items = [] # alla tas bort
		else
			@items = newitems # alla med antal==0 tas bort

	send : ->
		t = 0 # kr
		s = '' # full text
		u = '' # compact
		for [id,antal,pris,title,children] in @items
			if antal > 0
				sarr = []
				if children 
					for key of children
						subantal = children[key]
						if subantal == 1
							sarr.push key
						else if subantal > 1
							sarr.push subantal + key
				if sarr.length > 0 then ss=' ('+sarr.join(' ')+')' else ss='' 
				t += antal * pris
				s += (if antal>1 then antal + ' x ' else '') + id + ". " + title + ss + CRLF
				u += (if antal>1 then antal + 'x' else '') + id + ss + CRLF

		if t == 0 then return 

		output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + CRLF + t + " kr"
		if output.length > 2000 
			output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + u + CRLF + t + " kr"
		window.open output,'_blank'
