assert = chai.assert.deepEqual
print = () ->
	console.log arguments[0]
	arguments[0]

createAndAppend = (type, parent, attributes = {}) =>
	elem = document.createElement type
	parent.appendChild elem
	elem[key] = value for key,value of attributes
	elem

stack = []

crap = (attributes, f, type) =>
	if typeof type == 'object' then stack.push type
	else stack.push createAndAppend type, _.last(stack), attributes
	f()
	stack.pop()

head =   (            f = =>) => crap {}, f, document.head
body =   (            f = =>) => crap {}, f, document.body
title =  (attributes, f = =>) => crap attributes, f, 'title'
h1 =     (attributes, f = =>) => crap attributes, f, 'h1'
h2 =     (attributes, f = =>) => crap attributes, f, 'h2'
h3 =     (attributes, f = =>) => crap attributes, f, 'h3'
ul =     (attributes, f = =>) => crap attributes, f, 'ul'
li =     (attributes, f = =>) => crap attributes, f, 'li'
img =    (attributes, f = =>) => crap attributes, f, 'img'
div =    (attributes, f = =>) => crap attributes, f, 'div'
chkBox = (attributes, f = =>) => 
	attributes.type = 'checkbox'
	crap attributes, f, 'input'
br     = (attributes, , f = =>) => crap attributes, f, 'br'

# saves space in defining an object array
fmt = (titles,data,sep='|') => print data.map (lst) => _.object titles.split(sep), lst.split sep
