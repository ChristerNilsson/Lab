data = 
	'1' : [0,60,"Dagens sushi 7 bitar 3lax räka ägg 2rullar"]
	'2' : [0,75,'Liten sushi 9 bitar: 4lax räka ägg 3rullar']
	'6A' : [0,75,'Lax Avokado Rullar: 3lax 3avokado 3rullar']
	'6B' : [0,100,'Lax Avokado Rullar: 4lax 4avokado 4rullar']
	'20A' : [0,110,'Lycka special 10 bitar: Lax']
	'20B' : [0,120,'Lycka special 10 bitar: Spice tonfisk roll']
	'20C' : [0,125,'Lycka special 10 bitar: Lax avokado']
	'60A' : [0,90, 'Bento: 2lax räka ägg 4dumpl 2vårrullar ris']
	'60B' : [0,105,'Bento: 2lax räka ägg 4dumpl 2vårrullar 2kycklingspett ris']
	'60C' : [0,115,'Bento: 2lax räka ägg 4dumpl 2vårrullar yakiniku ris']
	'60D' : [0,130,'Bento: 2lax räka ägg 2vårrullar 2kycklingspett yakiniku ris']
	'60E' : [0,145,'Bento: 2lax räka ägg 4dumpl 2vårrullar 2kycklingspett 3fritScampi ris']

setup = ->
	body = document.getElementById "body"
	for id,item of data
		do (item) ->
			[antal,pris,t1] = item

			b1 = document.createElement "input"
			b1.type = 'button'
			b1.value = id + '. ' + t1 + ' ' + pris + 'kr'
			b1.style = "white-space: normal; height: 40px; width:300px; text-align:left"

			b2 = document.createElement "input"
			b2.type = 'button'
			b2.value = antal
			b2.style = ""

			body.appendChild document.createElement "br"
			body.appendChild b2
			body.appendChild b1

			b1.onclick = () -> update b2,item,+1
			b2.onclick = () -> if b2.value > 0 then update b2,item,-1

	total = document.createElement "input"
	total.type = 'button'
	total.id = 'total'
	total.value = 0
	body.appendChild document.createElement "br"
	body.appendChild document.createElement "br"
	body.appendChild total

	send = document.createElement "input"
	send.type = 'button'
	send.value = 'Send'
	send.onclick = () -> print 'send',total.value
	body.appendChild document.createElement "br"
	body.appendChild send

update = (b,item,delta) ->
	b.value = item[0] += delta
	s = ''
	t = 0
	for id,item of data
		[antal,pris,t1,t2] = item
		if antal == 1 
			s += id + ' '
		else if antal > 1
			s += antal + 'x' + id + ' '
		t += antal * pris
	total = document.getElementById "total"
	total.value = s + t + 'kr'

#mousePressed = ->
	#window.location.href = "sms:+46707496800&body=message" # iOS ok!
	##window.location.href = "sms://+46707496800?&body=message" # iOS ok
	#window.location = "sms://+46707496800" # 
