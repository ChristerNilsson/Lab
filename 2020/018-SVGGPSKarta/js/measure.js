// Generated by CoffeeScript 2.4.1
// Detta program användes när man ska
//   1) kalibrera en ny karta och behöver tre koordinater
//   2) placera ut kontroller
// Avläs koordinaterna med F12

// img = null
// points = []

// #############################
// R = 44
// preload = -> img = loadImage 'data/21A.png'
// #############################

// setup = ->
// 	createCanvas img.width, img.height
// 	fc()
// 	sc 0
// 	sw 2
// 	textSize R
// 	textAlign LEFT,TOP

// draw = ->
// 	image img, 0,0
// 	circle mouseX,mouseY,R
// 	sc 1
// 	point mouseX,mouseY
// 	sc 0
// 	text points.length+1,mouseX+0.7*R,mouseY+0.7*R

// mousePressed = ->
// 	points.push [round(mouseX), round(mouseY)]
// 	arr = points.map (value,i) -> "\t\"#{i+1}\": [#{value}],"
// 	console.log "\n" + arr.join "\n"


//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWVhc3VyZS5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxtZWFzdXJlLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEiLCJzb3VyY2VzQ29udGVudCI6WyIjIERldHRhIHByb2dyYW0gYW52w6RuZGVzIG7DpHIgbWFuIHNrYVxyXG4jICAgMSkga2FsaWJyZXJhIGVuIG55IGthcnRhIG9jaCBiZWjDtnZlciB0cmUga29vcmRpbmF0ZXJcclxuIyAgIDIpIHBsYWNlcmEgdXQga29udHJvbGxlclxyXG4jIEF2bMOkcyBrb29yZGluYXRlcm5hIG1lZCBGMTJcclxuXHJcbiMgaW1nID0gbnVsbFxyXG4jIHBvaW50cyA9IFtdXHJcblxyXG4jICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjXHJcbiMgUiA9IDQ0XHJcbiMgcHJlbG9hZCA9IC0+IGltZyA9IGxvYWRJbWFnZSAnZGF0YS8yMUEucG5nJ1xyXG4jICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjXHJcblxyXG4jIHNldHVwID0gLT5cclxuIyBcdGNyZWF0ZUNhbnZhcyBpbWcud2lkdGgsIGltZy5oZWlnaHRcclxuIyBcdGZjKClcclxuIyBcdHNjIDBcclxuIyBcdHN3IDJcclxuIyBcdHRleHRTaXplIFJcclxuIyBcdHRleHRBbGlnbiBMRUZULFRPUFxyXG5cclxuIyBkcmF3ID0gLT5cclxuIyBcdGltYWdlIGltZywgMCwwXHJcbiMgXHRjaXJjbGUgbW91c2VYLG1vdXNlWSxSXHJcbiMgXHRzYyAxXHJcbiMgXHRwb2ludCBtb3VzZVgsbW91c2VZXHJcbiMgXHRzYyAwXHJcbiMgXHR0ZXh0IHBvaW50cy5sZW5ndGgrMSxtb3VzZVgrMC43KlIsbW91c2VZKzAuNypSXHJcblxyXG4jIG1vdXNlUHJlc3NlZCA9IC0+XHJcbiMgXHRwb2ludHMucHVzaCBbcm91bmQobW91c2VYKSwgcm91bmQobW91c2VZKV1cclxuIyBcdGFyciA9IHBvaW50cy5tYXAgKHZhbHVlLGkpIC0+IFwiXFx0XFxcIiN7aSsxfVxcXCI6IFsje3ZhbHVlfV0sXCJcclxuIyBcdGNvbnNvbGUubG9nIFwiXFxuXCIgKyBhcnIuam9pbiBcIlxcblwiXHJcbiJdfQ==
//# sourceURL=c:\Lab\2020\018-SVGGPSKarta\coffee\measure.coffee