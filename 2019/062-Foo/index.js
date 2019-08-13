'use strict' 

function createAndAppend(parent, typ, attributes = {}) { 
	const elem = document.createElement(typ)
	parent.appendChild(elem)
	for (const key in attributes) elem[key] = attributes[key]
	return elem
}

function addPages(pages) {
	console.log(pages)
	const links = createAndAppend(document.body,'div')

	// pages.sort((a, b) => b.date_updated_unix - a.date_updated_unix)	
	pages.sort((a, b) => a.title.localeCompare(b.title))
	
	pages.filter(page => page.title != '')
	     .forEach(page => {

		const ms = page.date_updated_unix * 1000
		const date = new Date(ms)
		const sv = date.toLocaleString('sv')

		const div = createAndAppend(links,'div', {innerText: page.num + ' ' + sv + ' '})
		createAndAppend(div, 'a', {innerText: page.title, href : page.permalink,target : '_blank'})
	})
	console.log(links)
}

const xhr = new XMLHttpRequest()
xhr.open('GET', 'https://api.texttv.nu/api/get/106-187')
xhr.onload = (evt) => addPages(JSON.parse(evt.currentTarget.response)) 
xhr.send()
