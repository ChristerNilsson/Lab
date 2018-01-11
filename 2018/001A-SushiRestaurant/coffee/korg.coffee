class Korg
	constructor : ->
		@table = null
		@branch = []
		@items = []
		@rulle = null

	add : (item) -> @items.push item

	update0 : (b,item,delta) ->
		item[1] += delta
		b.value = if item[1]==0 then "" else item[1]

	update1 : (rulle,b,items,key,delta) ->
		if items['R']-delta >= 0 
			items['R'] -= delta
			items[key] += delta
			rulle.value = if items['R']==0 then "" else items['R']
			b.value = if items[key]==0 then "" else items[key]

	traverse : (items=@items,level=0, br=[]) ->
		if false == goDeeper @branch,br then return 
		if level==0
			for item,i in items
				[id,antal,pris,title,children,@limit] = item
				@addTitle0 item,id,pris,title,-1,0,br.concat(i),antal
				if children then @traverse children,level+1,br.concat(i)
		else if level==1
			for key of items
				subantal = items[key]
				@addTitle1 items,key,'',0,sushi[key][1],-1,1,br.concat(i),subantal

	handleRow : (b1,b2,b3,id='',pris='') ->
		tr = document.createElement "tr"
		#td0 = document.createElement "td"
		td1 = document.createElement "td"
		td2 = document.createElement "td"
		td3 = document.createElement "td"

		#td0.style.cssText = "width:5%"
		td1.style.cssText = "width:100%"
		td2.style.cssText = "width:5%"
		td3.style.cssText = "width:5%"

		@table.appendChild tr
		#tr.appendChild td0
		tr.appendChild td1
		tr.appendChild td2
		tr.appendChild td3

		#div = document.createElement "div"
		#div.style.cssText = "font-size:70%"
		#if id != '' then div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-'
		#td0.appendChild div
		td1.appendChild b1
		td2.appendChild b2
		td3.appendChild b3

	addTitle0 : (item,id,pris,title,count,level,br,antal) ->
		if count>0 then scount = " (#{count})" else scount =""
		v = '........'.slice(0,4*level) + title + scount
		b1 = makeButton v
		b1.style.textAlign = 'left'
		b1.branch = br
		b1.onclick = => 
			@branch = calcBranch @branch, b1.branch
			updateTables()

		v = if antal==0 then "" else antal
		b2 = makeButton v, GREEN,BLACK 
		b2.onclick = => @update0 b2,item,+1

		b3 = makeButton "-", RED,BLACK
		b3.onclick = => if b2.value>0 then @update0 b2,item,-1

		@handleRow b1,b2,b3

	addTitle1 : (items,key,id,pris,title,count,level,br,antal) ->
		b1 = document.createElement "div"
		b1.innerHTML = title  
		b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:right"

		v = if antal==0 then "" else antal
		if _.size(items) == 9
			b2 = makeButton v,  GREEN,BLACK
			b3 = makeButton '-',RED,BLACK
		else
			b2 = makeDiv v
			b3 = makeDiv ''
		if key=='R' then @rulle = b2

		b2.onclick = => if _.size(items) == 9 then @update1 @rulle,b2,items,key,+1
		b3.onclick = => if _.size(items) == 9 and b2.value>0 then @update1 @rulle,b2,items,key,-1

		@handleRow b1,b2,b3,id,pris

	rensa : -> @items = []

	send : ->
		t = 0 # kr
		s = '' # full text
		u = '' # compact
		for [id,antal,pris,title,children] in @items
			if antal > 0
				ss =''
				if children and _.size(children)==9
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
