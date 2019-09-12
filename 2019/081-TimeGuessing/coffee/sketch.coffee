{render, body, div, p, button, select, option, title} = teacup

LIMIT = 10 # %

startingTime = null 
duration = 1000 # ms

clear = -> t.innerText = '' for t in [text1,text2,text3]
myRound = (x,decs=0) -> Math.round(10**decs * x)/10**decs
pluralize = (n,word) -> n + ' ' + word + if n==1 then '' else 's'

toggle = ->
	if btn.innerText == 'Start'
		btn.innerText = 'Stop'
		startingTime = new Date
		clear()
	else
		btn.innerText = 'Start'
		stoppingTime = new Date
		diff = stoppingTime - startingTime - duration # ms
		text1.innerText = myRound((stoppingTime - startingTime)/1000, 2) + ' seconds'
		text2.innerText = myRound(diff/1000, 2) + ' seconds'

		percent = myRound 100*diff/duration
		text3.innerText = percent + '%'
		text3.style.color = 'yellow'
		if percent < -LIMIT then text3.style.color = 'red'
		if percent > +LIMIT then text3.style.color = 'green'

document.body.innerHTML = render ->
	style1 = 'width:100%; font-size:100px; text-align:center; text-align-last:center; background-color:black; color:white;'
	title 'Time Guessing'
	p style:'background-color:red', ->
		select style:style1, onchange:'duration = 1000 * parseInt(this.value); btn.focus()', ->
			for item in [1,2,3,4,5,6,7,8,9,10,20,30,40,50,60]
				option value:item, style:style1, pluralize(item,'second')
	p ->
		button '#btn', 'Start', style:style1, onclick:'toggle()', autofocus:true
	div '#text1', style:style1, 'duration'
	div '#text2', style:style1, 'difference'
	div '#text3', style:style1, '%'
