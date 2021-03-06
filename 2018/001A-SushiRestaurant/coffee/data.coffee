SHOP = "Bagarmossen Sushi o Café" 
MAIL = "janchrister.nilsson@gmail.com"

klartext = # förberett för pris som ej används just nu.
	R: [10,"Rulle"]
	A: [10,"Avokado"]
	E: [10,"Ägg"]
	F: [10,"Tonfisk"]
	K: [10,"Krabba"]
	L: [10,"Lax"]
	M: [10,"Mussla"]
	P: [10,"Räka"]
	T: [10,"Tofu"]
	DK: [10,"Dumpling:Kyckling"]
	DV: [10,"Dumpling:Vegetarisk"]
	KS: [10,"Kycklingspett:Sojasås"]
	KJ: [10,"Kycklingspett:Jordnötssås"]

nonMeals = 'SG EM KC RC'.split ' '

# Anger uppräkning:nedräkning. T ex A:R innebär att om Avokado++ så Rulle--
mapping = {A:'R', E:'R', F:'R', K:'R', L:'R', M:'R', P:'R', T:'R', DV:'DK', KS:'KJ'} 

# Saknas passive blir alla readonly. Finns passive så kontrolleras i denna lista.
passive = 'L P E DK KJ'.split ' '

# Antal bitar man kan stega med. Default = 1. T ex kan man inte ha två olika kycklingspett i en Bentolåda.
delta   = {KS:2} 

# [id antal pris title children mapping passive delta]
menuItems = [
	[
		'Meny'
		[
			'Sushi'
			[
				['1',1,60, 'Dagens', { R:2, L:3, P:1, E:1 } ]
				['2',1,75,'Liten', { R:3, L:4, P:1, E:1 } ]
				['3',1,90,'Mellan', { R:4, L:4, P:1, E:1, F:1 } ]
				['4',1,105,'Stor', { R:4, L:4, P:2, E:1, F:1, A:1 } ]
				['5',1,125,'Moriawase', { R:4, L:5, P:2, E:1, F:1, A:1, M:1 } ]
				['6A',1,75,'Lax Avokado Rullar', { R:3, L:3, A:3 } ]
				['6B',1,100,'Lax Avokado Rullar', { R:4, L:4, A:4 } ]
				['7',1,100,'Lax', { L:10 } ]
				['8',1,120,'Lax teriyaki', { L:10 } ]
				['9',1,90,'Lax & avokado', { L:5, A:4 } ]
				['10',1,95,'Lax & räkor', { L:5, P:4 } ]
				['11',1,90,'Mamma', { P:2, T:2, E:2, K:2, A:2 } ]
				['12',1,85,'Vegetarisk', { R:4, A:2, T:2, E:2 } ]
				['13',1,245,'Familje 10 rullar + 20 bitar',     { R:20, A:0, E:0, F:0, K:0, L:0, M:0, P:0, T:0 }, mapping, ['R'] ]
				['14',1,105,'Liten sashimi 12 bitar' ]
				['15',1,145,'Stor sashimi 18 bitar' ]
				['16',1,80,'California roll: krabbstick gurka avokado majonnäs sesamfrö']
				['17',1,80,'Vegetarisk roll']
				['18',1,95,'Yakiniku roll']
				['19',1,80,'Fotomaki roll: lax krabbstick gurka ägg avokado sesamfrö']
				['20A',1,110,'Lycka special 10 bitar: Lax']
				['20B',1,120,'Lycka special 10 bitar: Spice tonfisk roll']
				['20C',1,125,'Lycka special 10 bitar: Lax avokado']
			]
		]
		[
			'Kyckling'
			[
				['21',1,75,'Yakitori: 5 kycklingspett med sojasås']
				['22',1,75,'Satay Gay: 5 kycklingspett med jordnötssås (x)']
				['23',1,75,'Kycklingfilé med röd curry och cocosmjölk (xx)']
				['24',1,75,'Wokad kycklingfilé med grönsaker och ostronsås']
				['25',1,80,'Friterad kycklingfilé med sötsur sås']
				['26',1,85,'Fu kyckling']
				['27',1,85,'Wokad kycklingfilé med cashewnötter']
				['28',1,85,'Wokad kycklingfilé Sze Chuan (xx)']
				['29',1,85,'Mamma kyckling: Torrfriterad kycklingfilé med pekingsås (xx)']
				['30',1,85,'Gong Bao Kyckling (xxx)']
			]
		]
		[	
			'Anka'
			[
				['31',1,110,'Krispig anka: friterad anka med pekingsås']
				['32',1,110,'Anka: Sze Chuan (xx)']
			]
		]
		[
			'Biff'
			[
				['33',1,90,'Yakiniku: Stekt entrecote skivor med sojasås']
				['34',1,90,'Wokad biff med bambuskott']
				['35',1,90,'Wokad biff med ingefära och purjolök']
				['36',1,90,'Wokad biff med grönsaker och svartpepparsås (xx)']
				['37',1,95,'Biff Sze Chuan (xx)']
			]
		]
		[
			'Skaldjur'
			[
				['38',1,90,'Lax Teriyaki: Grillad lax med teriyakisås']
				['39A',1,100,'Friterad Scampi med sötsur sås']
				['39B',1,100,'Friterad Scampi med chilisås']
				['40',1,100,'Räkor med röd curry och cocosmjölk (xx)']
				['41',1,100,'Wokad scampi med blandade färska grönsaker']
				['42',1,105,'Gong Bao Scampi (xxx)']
				['43',1,105,'Scampi Sze Chuan (xx)']
			]
		]
		[
			'Fläsk'
			[
				['44',1,90,'Yu Xiang Rou Si (xx)']
				['45',1,100,'Friterat revbensspjäll på kantonesiskt vis']
			]
		]
		[
			'Vegetarisk'
			[
				['46',1,65,'Vårrullar 8 bitar med ris']
				['47',1,75,'Wokade grönsaker']
				['48',1,85,'Wokade grönsaker med tofu']
				['49',1,85,'Friterad tofu med grönsaker och vitlök i svart bönsås (xx)']
			]
		]
		[
			'Nudlar och Ris'
			[
				['50',1,80,'Nudlar med grönsaker']
				['51',1,85,'Nudlar med kyckling grönsaker']
				['52',1,90,'Nudlar med biff grönsaker']
				['53',1,75,'Stekt ris med grönsaker']
				['54',1,90,'Nasi goreng: stekt ris med kyckling biff ägg curry (x)']
				['55A',1,90,'Dumplings 10 kyckling ris']
				['55B',1,90,'Dumplings 10 vegetarisk ris']
				['56A',1,110,'Bibimbap: Biff']
				['56B',1,110,'Bibimbap: Räkor']
				['56C',1,110,'Bibimbap: Vegetarisk']
				['57',1,90,'Sushi Satay: 5 sushi 3 kycklingspett med jordnötssås', { R:5, A:0, E:0, F:0, K:0, L:0, M:0, P:0, T:0 }, mapping, ['R']] 
				['58',1,90,'Sushi Yakiniku: 5 sushi yakiniku', { R:5, A:0, E:0, F:0, K:0, L:0, M:0, P:0, T:0 }, mapping, ['R']] 
				['59',1,90,'Sushi Yakitori: 5 sushi 3 kycklingspett med sojasås', { R:5, A:0, E:0, F:0, K:0, L:0, M:0, P:0, T:0 }, mapping, ['R']] 
				['60A',1,90, 'Bento: ris 4 sushi 2 vårrullar 4 dumpling', {L:2, P:1, E:1, DK:2, DV:2}, mapping, passive]
				['60B',1,105,'Bento: ris 4 sushi 2 vårrullar 4 dumpling 2 kycklingspett',{L:2, P:1, E:1, DK:2, DV:2, KJ:2, KS:0}, mapping, passive, delta]
				['60C',1,115,'Bento: ris 4 sushi 2 vårrullar 4 dumpling yakiniku',{L:2, P:1, E:1, DK:2, DV:2}, mapping, passive]
				['60D',1,130,'Bento: ris 4 sushi 2 vårrullar 2 kycklingspett yakiniku',{L:2, P:1, E:1, KJ:2, KS:0}, mapping, passive, delta]
				['60E',1,145,'Bento: ris 4 sushi 2 vårrullar 4 dumpling 2 kycklingspett 3 fritScampi',{L:2, P:1, E:1, DK:2, DV:2, KJ:2, KS:0},mapping, passive, delta]
			]
		]
		[
			'Små rätter'
			[
				['SG',1,30,"Sjögräs"]
				['EM',1,30,"Edamame"]
				['KC',1,30,"Kimchi"]
				['RC',1,25,"Räkchips"]
			]
		]
	]
]
