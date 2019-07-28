'use strict'
const links = createAndAppend(document.body,'div')
const link  = createAndAppend(document.body,'div')

const xhr = new XMLHttpRequest()
xhr.open('GET', 'http://api.texttv.nu/api/get/106-187')
xhr.onload = evt => addPagesListToDOM(JSON.parse(evt.currentTarget.response))
xhr.send()

function addPagesListToDOM(pages) {
	pages.sort((a,b) => b.date_updated_unix - a.date_updated_unix)
	pages.filter(page => page.title)
	     .forEach(page => {
			const listItem = createAndAppend(links,'div') 
			const a = createAndAppend(listItem,'a')
			a.href = '#'
			a.textContent = `${page.num} - ${page.title}`
			a.onclick = () => link.innerHTML = '<br>' + page.content
  })
}

function createAndAppend(parent,typ) {
	const elem = document.createElement(typ)
	parent.appendChild(elem)
	return elem
}