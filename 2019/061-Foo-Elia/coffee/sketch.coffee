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

head =  (            f = =>) => crap {}, f, document.head
body =  (            f = =>) => crap {}, f, document.body
title = (attributes, f = =>) => crap attributes, f, 'title'
h1 =    (attributes, f = =>) => crap attributes, f, 'h1'
h2 =    (attributes, f = =>) => crap attributes, f, 'h2'
h3 =    (attributes, f = =>) => crap attributes, f, 'h3'
ul =    (attributes, f = =>) => crap attributes, f, 'ul'
li =    (attributes, f = =>) => crap attributes, f, 'li'
img =   (attributes, f = =>) => crap attributes, f, 'img'
div =   (attributes, f = =>) => crap attributes, f, 'div'

###############################################################

books = [
	{title: 'The Kite Runner',     author: 'Khaled Hosseini',	language: 'English', cover: '3.jpg', },
	{title: 'Number the Stars',    author: 'lois Lowry',      language: 'English', cover: '4.jpg', },
	{title: 'Pride and Prejudice', author: 'Jane Austen',     language: 'English', cover: '5.jpg', },
	{title: 'The Outsiders',       author: 'S.E Hinton',      language: 'English', cover: '7.jpg', },
	{title: 'Little Women',        author: 'Louisa May',      language: 'English', cover: '8.jpg', },
]

lis = [] # Just to show how elements in a loop can be accessed afterwards.

head =>
	title {innerText: 'Elia Books'}
body =>
	h1 {innerText: 'My Must Read Books', style: 'background:red'}
	ul {style: 'background:yellow'}, =>
		for book in books
			lis.push li {style: 'background:gray'}, =>
				h2 {innerText: book.title, style: 'background:green; color:yellow'}
				h3 {innerText: 'Author: ' + book.author, style: 'background:orange'}
				h3 {innerText: 'Language: ' + book.language}
				img {src: book.cover, height: 42}

document.body.children[4].children[0].children[0].style.background = 'red'

lis[2].style.background = 'white'