MAIL = "janchrister.nilsson@gmail.com"
SHOP = "FU Restaurang" 
CRLF = "\n"
#CRLF = "<br/>"

body = null
table = null
branch = [0] # motsvarar Meny samt Korg, dvs 2 rader i Table

# iOS visar inga radbrytningar.

# OBS: .cssText måste användas på iPhone 4s

addTitle = (id,pris,title,count,level,br) ->
	b1 = document.createElement "input"
	b1.type = 'button'
	if count>0 then scount = " (#{count})" else scount =""
	b1.value = '........'.slice(0,4*level) + title + scount
	b1.branch = br
	b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:left"
	
	#b1.onclick = -> update b2,item,+1
	b1.onclick = -> 
		branch = b1.branch.concat []
		table.remove()
		table = document.createElement "table"
		body.appendChild table

		console.log 'New branch',branch 
		traverse data,0

	# b2 = document.createElement "input"
	# b2.type = 'button'
	# b2.value = if antal==0 then "" else antal
	# b2.id = id
	# b2.style.cssText = "font-size:100%; width:100%" # height:80px; 
	# b2.onclick = -> if b2.value > 0 then update b2,item,-1

	tr = document.createElement "tr"
	td0 = document.createElement "td"
	td1 = document.createElement "td"
#	td2 = document.createElement "td"
	td0.style.cssText = "width:5%"
	td1.style.cssText = "width:85%"
#	td2.style.cssText = "width:10%"
	table.appendChild tr
	tr.appendChild td0
	tr.appendChild td1
#	tr.appendChild td2
	div = document.createElement "div"
	div.style.cssText = "font-size:70%"
	if id != '' 
		div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-'
	td0.appendChild div
	td1.appendChild b1
#	td2.appendChild b2

calc = (hash) ->
	res = 0
	for key of hash
		res += hash[key]
	res 

goDeeper = (a,b) ->
	for i in range Math.min a.length,b.length
		if a[i]!=b[i] then return false 
	a.length >= b.length
assert true,  goDeeper [],[]
assert true,  goDeeper [0],[0]
assert true,  goDeeper [0,0],[0,0]
assert true,  goDeeper [0],[]
assert true,  goDeeper [0,0],[0]
assert false, goDeeper [],[0]
assert false, goDeeper [0],[0,0]
assert false, goDeeper [0],[1]
assert false, goDeeper [1],[0]
assert false, goDeeper [0,0],[0,1]
assert false, goDeeper [1,0],[0]

traverse = (items, level=0, br=[]) ->
	if false == goDeeper branch,br then return 
	if level in [0,1]
		for item,i in items
			do (item) ->
				[title,children...] = item
				if level==0
					addTitle '',0,title,children.length,level,br.concat i
				else
					count = 0
					for x in children
						count += x.length
					addTitle '',0,title,count,level,br.concat i
				traverse children, level+1, br.concat i 
	if level == 2
		for item in items
			for x in item
				addTitle x[0],x[1],x[2],calc(x[3]),level

window.onload = ->

	w = window.innerWidth

	body = document.getElementById "body"

	table = document.createElement "table"
	body.appendChild table

	closed = {} # innehåller menyer som är stängda

	traverse data

	# total = document.createElement "input"
	# total.type = 'button'
	# total.id = 'total'
	# total.value = "0:-"
	# total.style.cssText = "font-size:200%; width:50%"
	# total.onclick = -> clr()

	# send = document.createElement "input"
	# send.type = 'button'
	# send.value = 'Skicka'
	# send.style.cssText = "font-size:200%; width:50%"
	# send.onclick = -> 
	# 	total = document.getElementById "total"
	# 	if total.value == "0:-" then return
	# 	t = 0
	# 	s = '' # full text
	# 	u = '' # compact
	# 	for [id,pris,text,antal] in data
	# 		if antal > 0 
	# 			s += antal + ' x ' + id + ". " + text + CRLF
	# 			if antal == 1 
	# 				u += id + CRLF
	# 			else
	# 				u += antal + 'x' + id + CRLF
	# 		t += antal * pris
	# 	if s.length > 500 then s = u 

	# 	output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + CRLF + "Totalt " + t + " kr."
	# 	window.location.href = output
	# 	#console.log output
	# 	clr()

	# body.appendChild send
	# body.appendChild total

clr = ->
	for item in data
		item[3] = 0
		button = document.getElementById item[0]
		button.value = ''
	total.value = "0:-"

update = (b,item,delta) ->
	item[3] += delta
	b.value = if item[3]==0 then "" else item[3]
	t = 0
	t += antal * pris for [id,pris,text,antal] in data	
	total = document.getElementById "total"
	total.value = t + ':-'
