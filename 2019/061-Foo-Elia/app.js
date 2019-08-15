'use strict'

const books = [
  {title: 'The Kite Runner',     author: 'Khaled Hosseini',	language: 'English', cover: '3.jpg', },
  {title: 'Number the Stars',    author: 'lois Lowry',      language: 'English', cover: '4.jpg', },
  {title: 'Pride and Prejudice', author: 'Jane Austen',     language: 'English', cover: '5.jpg', },
  {title: 'The Outsiders',       author: 'S.E Hinton',      language: 'English', cover: '7.jpg', },
  {title: 'Little Women',        author: 'Louisa May',      language: 'English', cover: '8.jpg', },
]

function createAndAppend(typ, parent, attributes = {}) {
  const elem = document.createElement(typ)
  parent.appendChild(elem)
	for (const key in attributes) elem[key] = attributes[key]
	return elem
}

document.body.onload = () => {
	createAndAppend('title',document.head, {innerText: 'Elia Books'})
  createAndAppend('h1', document.body, {innerText: 'My Must Read Books'});
	const ul = createAndAppend('ul',document.body)
	for (const book of books) {
    const li = createAndAppend('li', ul)
    createAndAppend('h2', li, {innerText: book.title})
		createAndAppend('h3', li, {innerText: `Author: ${book.author}`})
		createAndAppend('h3', li, {innerText: `Language: ${book.language}`})
		createAndAppend('img', li, {src : book.cover, height:84})
  }
}

