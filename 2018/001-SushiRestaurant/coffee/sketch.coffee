setup = ->

	body = document.getElementById "body"
	table = document.createElement "table"
	body.appendChild table
	for item in data
		do (item) ->
			[id,antal,pris,text] = item

			b1 = document.createElement "input"
			b1.type = 'button'
			b1.value = text
			b1.style = "white-space:normal; height:40px; width:300px; text-align:left"

			b2 = document.createElement "input"
			b2.type = 'button'
			b2.value = if antal==0 then "" else antal
			b2.id = id
			b2.style = 'font-size:32px; height:40px; width:50px'

			b1.onclick = () -> update b2,item,+1
			b2.onclick = () -> if b2.value > 0 then update b2,item,-1

			tr = document.createElement "tr"
			td0 = document.createElement "td"
			td1 = document.createElement "td"
			td2 = document.createElement "td"
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
	total.onclick = () -> clr()

	body.appendChild document.createElement "br"
	body.appendChild document.createElement "br"
	body.appendChild total

	send = document.createElement "input"
	send.type = 'button'
	send.value = 'Send'
	send.onclick = () -> 
		total = document.getElementById "total"
		if total.value == "0:-" then return
		window.location.href = encodeURI "mailto:janchrister.nilsson@gmail.com?&subject=Order to FU Restaurang&body=" + total.value 
		clr()

	body.appendChild document.createElement "br"
	body.appendChild send

clr = ->
	for item in data
		item[1] = 0
		button = document.getElementById item[0]
		button.value = ''
	total.value = "0:-"

update = (b,item,delta) ->
	item[1] += delta
	b.value = if item[1]==0 then "" else item[1]
	s = ''
	t = 0
	for [id,antal,pris,text] in data
		if antal == 1 
			s += id + ' '
		else if antal > 1
			s += id + 'x' + antal + ' '
		t += antal * pris
	total = document.getElementById "total"
	total.value = s + t + ':-'
