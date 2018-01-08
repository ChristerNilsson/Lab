MAIL = "janchrister.nilsson@gmail.com"
SHOP = "4 FU Restaurang" 
CRLF = "\n"

# OBS: .cssText måste användas på iPhone 4s
window.onload = ->

	w = window.innerWidth

	body = document.getElementById "body"

	table = document.createElement "table"
	body.appendChild table
	for item in data
		item.push 0
		do (item) ->
			[id,pris,text,antal] = item

			b1 = document.createElement "input"
			b1.type = 'button'
			b1.value = text
			b1.style.cssText = "font-size:100%; white-space:normal; width:100%; text-align:left"

			b2 = document.createElement "input"
			b2.type = 'button'
			b2.value = if antal==0 then "" else antal
			b2.id = id
			b2.style.cssText = "font-size:100%; width:100%" # height:80px; 

			b1.onclick = -> update b2,item,+1
			b2.onclick = -> if b2.value > 0 then update b2,item,-1

			tr = document.createElement "tr"
			td0 = document.createElement "td"
			td1 = document.createElement "td"
			td2 = document.createElement "td"
			td0.style.cssText = "width:5%"
			td1.style.cssText = "width:85%"
			td2.style.cssText = "width:10%"
			table.appendChild tr
			tr.appendChild td0
			tr.appendChild td1
			tr.appendChild td2
			div = document.createElement "div"
			div.innerHTML = '<b>' + id + '</b><br>' + pris + ':-'
			td0.appendChild div
			td1.appendChild b1
			td2.appendChild b2

	total = document.createElement "input"
	total.type = 'button'
	total.id = 'total'
	total.value = "0:-"
	total.style.cssText = "font-size:200%; width:50%"
	total.onclick = -> clr()

	send = document.createElement "input"
	send.type = 'button'
	send.value = 'Skicka'
	send.style.cssText = "font-size:200%; width:50%"
	send.onclick = -> 
		total = document.getElementById "total"
		if total.value == "0:-" then return
		t = 0
		s = '' # full text
		u = '' # compact
		for [id,pris,text,antal] in data
			if antal > 0 
				s += antal + ' x ' + id + ". " + text + CRLF
				if antal == 1 
					u += id + CRLF
				else
					u += antal + 'x' + id + CRLF
			t += antal * pris
		if s.length > 500 then s = u 

		output = encodeURI "mailto:#{MAIL}?&subject=Order till #{SHOP}&body=" + s + CRLF + "Totalt " + t + " kr."
		window.location.href = output
		#console.log output
		clr()

	body.appendChild send
	body.appendChild total

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
