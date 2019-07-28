'use strict'

let pages

Util.fetchJSON('http://api.texttv.nu/api/get/106-187?app=apiexempelsidan')
	.then( result => {
		pages = result.filter(page => page.title.length > 0)
		pages.sort((a,b) => b.date_updated_unix - a.date_updated_unix)
		showPages()
	})

const input = Util.createAndAppend('input',document.body)
input.onkeyup = () => showPages(input.value)
const divList = Util.createAndAppend('div',document.body)

function displayPage(time,page) {
	const p = Util.createAndAppend('p',divList)
	p.innerText =  time + ' ' + page.num + ' '
	const a = Util.createAndAppend('a',p)
	a.href = page.permalink
	a.innerText = page.title
	a.target = '_blank'
}

const unixTime2sv = (seconds) => new Date(seconds * 1000).toLocaleString('sv')
const showPage = (page) => displayPage(unixTime2sv(page.date_updated_unix),page)	

function showPages(pattern='') {
	pattern = pattern.toLowerCase()
	divList.innerHTML = ''
	for (const page of pages) {
		if (page.title.toLowerCase().includes(pattern)) showPage(page)
	}
}
