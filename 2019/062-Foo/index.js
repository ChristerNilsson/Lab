'use strict' 

function createAndAppend(parent, typ, attributes = {}) { 
	const elem = document.createElement(typ)
	parent.appendChild(elem)
	for (const key in attributes) elem[key] = attributes[key]
	return elem
}

const links = createAndAppend(document.body,'div')

const xhr = new XMLHttpRequest()
xhr.open('GET', 'https://api.texttv.nu/api/get/106-187')
xhr.onload = (evt) => addPages(JSON.parse(evt.currentTarget.response)) 
xhr.send()

function addPages(pages) {
  pages.sort((a, b) => b.date_updated_unix - a.date_updated_unix)	
	pages.filter(page => page.title != '')
	     .forEach(page => {

		const ms = page.date_updated_unix * 1000
		const date = new Date(ms)
		const s = date.toLocaleString('sv')

		const div = createAndAppend(links,'div', {innerText: page.num + ' ' + s + ' '})
		const a   = createAndAppend(div,  'a',   {innerText: page.title, href : page.permalink,target : '_blank'})
  })
}
