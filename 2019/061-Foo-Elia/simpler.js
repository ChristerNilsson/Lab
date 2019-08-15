'use strict'

const stack = []

function createAndAppend(typ, parent, attributes = {}) {
  const elem = document.createElement(typ)
  parent.appendChild(elem)
	for (const key in attributes) elem[key] = attributes[key]
	return elem
}

function crap (attributes, f, typ) {
	if (typeof typ == 'string') 
		stack.push(createAndAppend(typ, _.last(stack), attributes))
	else
		stack.push(typ)
	if (f) f()
	return stack.pop()
}

const head = (f) => crap({}, f, document.head)
const body = (f) => crap({}, f, document.body)

const title = (attributes = {}, f) => crap(attributes, f, 'title')
const h1 =    (attributes = {}, f) => crap(attributes, f, 'h1')
const h2 =    (attributes = {}, f) => crap(attributes, f, 'h2')
const h3 =    (attributes = {}, f) => crap(attributes, f, 'h3')
const ul =    (attributes = {}, f) => crap(attributes, f, 'ul')
const li =    (attributes = {}, f) => crap(attributes, f, 'li' )
const img =   (attributes = {}, f) => crap(attributes, f, 'img')
const div =   (attributes = {}, f) => crap(attributes, f, 'div')

/////////////////////////////////////////////////

const books = [
  {title: 'The Kite Runner',     author: 'Khaled Hosseini',	language: 'English', cover: '3.jpg', },
  {title: 'Number the Stars',    author: 'lois Lowry',      language: 'English', cover: '4.jpg', },
  {title: 'Pride and Prejudice', author: 'Jane Austen',     language: 'English', cover: '5.jpg', },
  {title: 'The Outsiders',       author: 'S.E Hinton',      language: 'English', cover: '7.jpg', },
  {title: 'Little Women',        author: 'Louisa May',      language: 'English', cover: '8.jpg', },
]

head( () => {
	title({innerText: 'Elia Books'});
});
body( () => {
	h1({innerText: 'My Must Read Books'});
	ul({}, () => { 
		for (const book of books) {
			li({}, () => {
				h2({innerText: book.title});
				h3({innerText: 'Author: ' + book.author});
				h3({innerText: 'Language: ' + book.language});
				img({src: book.cover, height: 42});
			});
		};
	});
});
