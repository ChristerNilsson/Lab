{render, h1, button, select, option} = teacup

startingTime = null 
duration = 1000 # ms

selectDuration = (obj) -> 
	duration = 1000 * parseInt obj.value
	clear()

start = ->	 
	startingTime = new Date()
	clear()

clear = ->
	text1.innerText = ''
	text2.innerText = ''
	text3.innerText = ''

stopp = ->
	stoppingTime = new Date()
	delta = stoppingTime - startingTime - duration
	text1.innerText = (stoppingTime - startingTime)/1000 + ' seconds'
	text2.innerText = delta/1000 + ' seconds'
	text3.innerText = Math.round(100*delta/duration)+'%'

pluralize = (n,word) -> n + ' ' + word + if n==1 then '' else 's'

document.body.innerHTML = render ->
	style1 = 'width:100%; font-size:100px; text-align:center; text-align-last:center'
	select style:style1, onchange:'selectDuration(this)', ->
		for item in [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60]
			option value:item, pluralize(item,'second'), style:style1
	button 'Start', onclick:'start()', style:style1
	button 'Stop',  onclick:'stopp()', style:style1
	h1 '#text1', style:style1, 'duration'
	h1 '#text2', style:style1, 'difference'
	h1 '#text3', style:style1, '%'
