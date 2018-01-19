panel = ['','','']
page = null
state = 0

goto = (p) -> p.display()

op = (key) -> 
	panel[state] += key
	goto page

op1 = (key) ->
	panel[1] = key
	state = 2
	goto page

op2 = ->
	x = parseInt panel[0]
	operator = panel[1]
	y = parseInt panel[2]
	if operator=='+' then res = x+y
	if operator=='-' then res = x-y
	if operator=='*' then res = x*y
	if operator=='/' then res = x/y
	panel = [res,'','']
	state = 0
	goto page

op3 = ->
	panel = ['','','']
	state = 0
	goto page

setup = ->

	page = new Page 4, -> @addRow makeDiv panel[state]

	page.addAction '1', -> op '1'
	page.addAction '2', -> op '2'
	page.addAction '3', -> op '3'
	page.addAction '+', -> op1 '+'

	page.addAction '4', -> op '4'
	page.addAction '5', -> op '5'
	page.addAction '6', -> op '6'
	page.addAction '-', -> op1 '-'

	page.addAction '7', -> op '7'
	page.addAction '8', -> op '8'
	page.addAction '9', -> op '9'
	page.addAction '*', -> op1 '*'

	page.addAction 'C', -> op3()
	page.addAction '0', -> op '0'
	page.addAction '=', -> op2() 
	page.addAction '/', -> op1 '/'

	goto page
