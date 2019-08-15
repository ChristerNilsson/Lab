createAndAppend = (typ, parent, attributes = {}) =>
	elem = document.createElement typ
	parent.appendChild elem
	elem[key] = value for key,value of attributes 
	elem

stack = []

crap = (attributes, f, typ) =>
	if typeof typ == 'string' 
		stack.push createAndAppend typ, _.last(stack), attributes
	else
		stack.push typ
	f()
	stack.pop()

head = (f) => crap {}, f, document.head
body = (f) => crap {}, f, document.body

title = (attributes = {}, f = =>) => crap attributes, f, 'title'
h1 =    (attributes = {}, f = =>) => crap attributes, f, 'h1'
h2 =    (attributes = {}, f = =>) => crap attributes, f, 'h2'
h3 =    (attributes = {}, f = =>) => crap attributes, f, 'h3'
ul =    (attributes = {}, f = =>) => crap attributes, f, 'ul'
li =    (attributes = {}, f = =>) => crap attributes, f, 'li' 
img =   (attributes = {}, f = =>) => crap attributes, f, 'img'
div =   (attributes = {}, f = =>) => crap attributes, f, 'div'

###############################################################

books = [
  {title: 'The Kite Runner',     author: 'Khaled Hosseini',	language: 'English', cover: '3.jpg', },
  {title: 'Number the Stars',    author: 'lois Lowry',      language: 'English', cover: '4.jpg', },
  {title: 'Pride and Prejudice', author: 'Jane Austen',     language: 'English', cover: '5.jpg', },
  {title: 'The Outsiders',       author: 'S.E Hinton',      language: 'English', cover: '7.jpg', },
  {title: 'Little Women',        author: 'Louisa May',      language: 'English', cover: '8.jpg', },
]
 
head -> title {innerText: 'Elia Books'}
body -> 
	h1 {innerText: 'My Must Read Books'}
	ul {}, -> for book in books
		li {}, ->
			h2 {innerText: book.title}
			h3 {innerText: 'XAuthor: ' + book.author}
			h3 {innerText: 'Language: ' + book.language}
			img {src: book.cover, height: 42}
