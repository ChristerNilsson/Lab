process = (dy,t) ->
	for txt,i in t
		if 'string' == typeof txt 
			fc if i in [0,1] then 1 else 0.5
			textSize if i in [0,1] then 20 else 24
			textAlign LEFT
			text txt,20,dy+i*dy
		else
			textSize 24
			for s,j in txt
				textAlign [LEFT,CENTER,RIGHT][j]
				x = [20,width/2,width-20][j]
				fc [1,1,0][j],[0,1,1][j],0 # red yellow green
				text s,x,dy+i*dy

setup = ->
	createCanvas 850,700
	bg 0
	sc()

	# process 40, [
	# 	'Problemlösning: Förmågan att formulera och lösa problem med'
	# 	'hjälp av matematik samt värdera valda strategier och metoder.'
	# 	['E','C','A']
	# 	'Eleven kan lösa olika problem i bekanta situationer på ett'
	# 	['i huvudsak','relativt väl','väl']
	# 	'fungerande sätt genom att välja och använda strategier och metoder med'
	# 	['viss','förhållandevis god','god']
	# 	'anpassning till problemets karaktär samt'
	# 	['bidra till att','','']
	# 	'formulera enkla matematiska modeller som'
	# 	['','efter någon bearbetning','']
	# 	'kan tillämpas i sammanhanget.'
	# ]

	process 40, [
		'Begrepp: Förmågan att använda och analysera'
		'matematiska begrepp och samband mellan begrepp.' 
		['E','C','A']
		'Eleven har'
		['grundläggande','goda','mycket goda']
		'kunskaper om matematiska begrepp och'
		' visar det genom att använda dem i'
		['välkända','bekanta','nya']
		'sammanhang på ett'
		['i huvudsak','relativt väl','väl']
		'fungerande sätt. Eleven kan även beskriva olika begrepp'
		'med hjälp av matematiska uttrycksformer på ett'
		['i huvudsak','relativt väl','väl']
		'fungerande sätt. I beskrivningarna kan eleven'
		'växla mellan olika uttrycksformer samt föra'
		['enkla','utvecklade','välutvecklade']
		'resonemang kring hur begreppen relaterar till varandra.'
	]

# 1:                                                                                                                                                                     
# Eleven kan lösa olika problem i bekanta situationer på ett   i huvudsak   fungerande sätt genom att välja och använda strategier och metoder med   viss               anpassning till problemets karaktär samt   bidra till att formulera enkla matematiska modeller som                           kan tillämpas i sammanhanget.
# Eleven kan lösa olika problem i bekanta situationer på ett   relativt väl fungerande sätt genom att välja och använda strategier och metoder med   förhållandevis god anpassning till problemets karaktär samt                  formulera enkla matematiska modeller som   efter någon bearbetning kan tillämpas i sammanhanget.
# Eleven kan lösa olika problem i bekanta situationer på ett   väl          fungerande sätt genom att välja och använda strategier och metoder med   god                anpassning till problemets karaktär samt                  formulera enkla matematiska modeller som                           kan tillämpas i sammanhanget.

# 2:
# Eleven har   grundläggande   kunskaper om matematiska begrepp och visar det genom att använda dem i   välkända  sammanhang på ett   i huvudsak   fungerande sätt. Eleven kan även beskriva olika begrepp med hjälp av matematiska uttrycksformer på ett   i huvudsak   fungerande sätt. I beskrivningarna kan eleven växla mellan olika uttrycksformer samt föra   enkla         resonemang kring hur begreppen relaterar till varandra.
# Eleven har   goda            kunskaper om matematiska begrepp och visar det genom att använda dem i   bekanta   sammanhang på ett   relativt väl fungerande sätt. Eleven kan även beskriva olika begrepp med hjälp av matematiska uttrycksformer på ett   relativt väl fungerande sätt. I beskrivningarna kan eleven växla mellan olika uttrycksformer samt föra   utvecklade    resonemang kring hur begreppen relaterar till varandra.
# Eleven har   mycket goda     kunskaper om matematiska begrepp och visar det genom att använda dem i   nya       sammanhang på ett   väl          fungerande sätt. Eleven kan även beskriva olika begrepp med hjälp av matematiska uttrycksformer på ett   väl          fungerande sätt. I beskrivningarna kan eleven växla mellan olika uttrycksformer samt föra   välutvecklade resonemang kring hur begreppen relaterar till varandra.
 
# 3:
# Eleven kan välja och använda   i huvudsak fungerande        matematiska metoder med   viss         anpassning till sammanhanget för att göra beräkningar och lösa rutinuppgifter inom aritmetik, algebra, geometri, sannolikhet, statistik samt samband och förändring med   tillfredställande resultat
# Eleven kan välja och använda   ändamålsenliga               matematiska metoder med   relativt god anpassning till sammanhanget för att göra beräkningar och lösa rutinuppgifter inom aritmetik, algebra, geometri, sannolikhet, statistik samt samband och förändring med   gott resultat.
# Eleven kan välja och använda   ändamålsenliga och effektiva matematiska metoder med   god          anpassning till sammanhanget för att göra beräkningar och lösa rutinuppgifter inom aritmetik, algebra, geometri, sannolikhet, statistik samt samband och förändring med   mycket gott resultat.

# 4:
# Eleven för   enkla och till viss del     underbyggda resonemang om   val av tillvägagångssätt och om resultatens rimlighet i förhållande till problemsituationen samt kan   bidra till att ge något förslag på alternativt tillvägagångssätt.
# Eleven för   utvecklade och relativt väl underbyggda resonemang om          tillvägagångssätt och om resultatens rimlighet i förhållande till problemsituationen samt kan                  ge något förslag på alternativt tillvägagångssätt.
# Eleven för   välutvecklade och väl       underbyggda resonemang om          tillvägagångssätt och om resultatens rimlighet i förhållande till problemsituationen samt kan                  ge       förslag på alternativt tillvägagångssätt.

# 5:
# Eleven kan redogöra för och samtala om tillvägagångssätt på ett  i huvudsak fungerande sätt        och använder då symboler, algebraiska uttryck, formler, grafer, funktioner och andra matematiska uttrycksformer med   viss anpassning               till syfte och sammanhang. I redovisningar och diskussioner för och följer eleven matematiska resonemang genom att framföra och bemöta matematiska argument på ett sätt som   till viss del för resonemangen framåt.
# Eleven kan redogöra för och samtala om tillvägagångssätt på ett  ändamålsenligt sätt               och använder då symboler, algebraiska uttryck, formler, grafer, funktioner och andra matematiska uttrycksformer med   förhållandevis god anpassning till syfte och sammanhang. I redovisningar och diskussioner för och följer eleven matematiska resonemang genom att framföra och bemöta matematiska argument på ett sätt som   för resonemangen framåt.
# Eleven kan redogöra för och samtala om tillvägagångssätt på ett  ändamålsenligt och effektivt sätt och använder då symboler, algebraiska uttryck, formler, grafer, funktioner och andra matematiska uttrycksformer med   god anpassning                till syfte och sammanhang. I redovisningar och diskussioner för och följer eleven matematiska resonemang genom att framföra och bemöta matematiska argument på ett sätt som   för resonemangen framåt och fördjupar eller breddar dem.	