{render, div, p, button, select, option, title} = teacup

startingTime = null 
duration = 1000 # ms

selectDuration = (obj) -> 
	duration = 1000 * parseInt obj.value
	clear()

clear = ->
	text1.innerText = ''
	text2.innerText = ''
	text3.innerText = ''

myRound = (x,decs) -> Math.round(10**decs * x)/10**decs

toggle = ->
	if btn.innerText == 'Start'
		btn.innerText = 'Stop'
		startingTime = new Date()
		clear()
	else
		btn.innerText = 'Start'
		stoppingTime = new Date()
		delta = myRound stoppingTime - startingTime - duration, 2
		text1.innerText = myRound((stoppingTime - startingTime)/1000, 2) + ' seconds'
		text2.innerText = myRound(delta/1000,2) + ' seconds'
		text3.innerText = Math.round(100*delta/duration)+'%'

pluralize = (n,word) -> n + ' ' + word + if n==1 then '' else 's'

document.body.innerHTML = render ->
	style1 = 'width:100%; font-size:100px; text-align:center; text-align-last:center'
	title 'Time Guessing'
	p ->
		select style:style1, onchange:'selectDuration(this)', ->
			for item in [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60]
				option value:item, style:style1, pluralize(item,'second')
	p ->
		button '#btn', 'Start', style:style1, onclick:'toggle()'
	div '#text1', style:style1, 'duration'
	div '#text2', style:style1, 'difference'
	div '#text3', style:style1, '%'
