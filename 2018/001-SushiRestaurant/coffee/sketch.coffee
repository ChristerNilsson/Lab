setup = ->

	w = windowWidth

	body = document.getElementById "body"
	table = document.createElement "table"
	body.appendChild table
	for item in data
		do (item) ->
			[id,antal,pris,text] = item

			b1 = document.createElement "input"
			b1.type = 'button'
			b1.value = text
			b1.style = "font-size:20px; white-space:normal; height:80px; width:100%; text-align:left"

			b2 = document.createElement "input"
			b2.type = 'button'
			b2.value = if antal==0 then "" else antal
			b2.id = id
			b2.style = "font-size:40px; height:80px; width:100%"

			b1.onclick = () -> update b2,item,+1
			b2.onclick = () -> if b2.value > 0 then update b2,item,-1

			tr = document.createElement "tr"
			td0 = document.createElement "td"
			td1 = document.createElement "td"
			td2 = document.createElement "td"
			td0.style = "width:5%"
			td1.style = "width:85%"
			td2.style = "width:10%"
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
	total.style = "font-size:40px; height:80px; width:45%"
	total.onclick = () -> clr()

	send = document.createElement "input"
	send.type = 'button'
	send.value = 'Skicka'
	send.style = "font-size:40px; height:80px; width:45%"
	send.onclick = () -> 
		total = document.getElementById "total"
		if total.value == "0:-" then return
		t = 0
		s = ''
		for [id,antal,pris,text] in data
			if antal > 0 
				s += antal + ' x ' + id + ". " + text + "\n"
			t += antal * pris
		window.location.href = encodeURI "mailto:janchrister.nilsson@gmail.com?&subject=Order till FU Restaurang&body=" + s + "\nTotalt " + t + " kr." 
		print window.location.href
		clr()

	body.appendChild document.createElement "br"
	body.appendChild document.createElement "br"
	body.appendChild send
	body.appendChild total

clr = ->
	for item in data
		item[1] = 0
		button = document.getElementById item[0]
		button.value = ''
	total.value = "0:-"

update = (b,item,delta) ->
	item[1] += delta
	b.value = if item[1]==0 then "" else item[1]
	t = 0
	t += antal * pris for [id,antal,pris,text] in data	
	total = document.getElementById "total"
	total.value = t + ':-'
