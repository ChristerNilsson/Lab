'use strict'
function wrap(parent,typ) { // createAndAppend
	const elem = document.createElement(typ)
	parent.appendChild(elem)
	return elem
}

const links = wrap(document.body,'div')
const link  = wrap(document.body,'div')

const xhr = new XMLHttpRequest()
xhr.open('GET', 'https://api.texttv.nu/api/get/106-187')
xhr.onload = evt => addPages(JSON.parse(evt.currentTarget.response))
xhr.send()

function addPages(pages) {
	pages.sort((a,b) => b.date_updated_unix - a.date_updated_unix)
	pages.filter(page => page.title).forEach(page => {
		const a = wrap(wrap(links,'div'),'a')
		a.href = '#'
		a.textContent = `${page.num} - ${page.title}`
		a.onclick = () => link.innerHTML = '<br>' + page.content
  })
}
