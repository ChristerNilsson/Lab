let pages

Util.fetchJSON('http://api.texttv.nu/api/get/105-187?app=apiexempelsidan')
	.then( result => {
		pages = result
		pages.sort((a,b) => b.date_updated_unix - a.date_updated_unix)
		pages = pages.filter(page => page.title.length > 0)
		showPages('')
	})
						 
input = Util.createAndAppend('input',document.body)
input.onkeyup = () => showPages(input.value)
divList = Util.createAndAppend('div',document.body)

function displayPage(time,page) {
	p = Util.createAndAppend('p',divList)
	p.innerText =  time + ' ' + page.num + ' '
	a = Util.createAndAppend('a',p)
	a.href = page.permalink
	a.innerText = page.title
	a.target = '_blank'
}

function unixTime2sv(seconds) {
	milliseconds = seconds * 1000
	d = new Date(milliseconds)
	return d.toLocaleString('sv')
}

function showPage(page) {
	displayPage(unixTime2sv(page.date_updated_unix),page)	
}

function showPages(pattern) {
	pattern = pattern.toLowerCase()
	divList.innerHTML = ''
	for (page of pages) {
		if (page.title.toLowerCase().includes(pattern)) showPage(page)
	}
}
