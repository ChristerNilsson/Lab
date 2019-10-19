#assert = chai.assert.deepEqual
fetch = require 'node-fetch'
#DOMParser = require 'dom-parser'
#parser = new DOMParser() # Initialize the DOM parser

PERSONS  = 'https://member.schack.se/ShowTournamentServlet?id=7470'

PERSON = 'https://member.schack.se/ShowTournamentParticipantResultServlet?partid='

fetch(PERSONS)
	.then (response) => response.text() # When the page is loaded convert it to text
	.then (html) => 
		lines = html.split '<td'
		lines = lines.filter (line) => line.includes 'listrighttext'
		lines = lines.filter (line) => line.includes "'7470'"
		for line in lines
			# ('7470','532026')" class
			p1 = line.indexOf("'7470'") + 8
			p2 = line.indexOf("')",p2)
			number = line.slice p1,p2
			numbers.push number
			console.log number
		getPersons numbers
	.catch (err) => console.log('Failed to fetch page: ', err)

getPersons = (numbers) =>
	console.log 'getPersons'
	persons = []
	for number in numbers.slice 0,2
		console.log number
		fetch(PERSON + number)		
			.then (response) => response.text() # When the page is loaded convert it to text
			.then (html) => 
				# relative;">2011</td>
				p1 = html.indexOf(">Födelseår</td>") + 1
				p2 = html.indexOf("relative",p1) + 1
				p3 = html.indexOf("relative",p2) + 11
				year =  html.slice p3,p3+4

				# Turneringsresultat för Felix Olofsson<h4 class=
				p1 = html.indexOf("Turneringsresultat för ") + 23
				p2 = html.indexOf("<h4 class=",p1)
				name = html.slice p1,p2
				persons.push [year,name]
	persons.sort()
	for [year,name] in persons
		console.log year,name