letters = 'abcdefghijklmnopqrstuvwx*ABCDEFGHIJKLMNOPQRSTUVWX'

#-3     0 1 2 3
#
# a b c d e f g  -3
# h i j k l m n  -2
# o p q r s t u  -1
# v w x * A B C   0
# D E F G H I J   1
# K L M N O P Q   2
# R S T U V W X   3

pairs = [[1017,1373],[1016,1378],[1016,1383],[1017,1388],[1015,1393],[1013,1398],[1010,1403],[1006,1406],[1003,1410],[1001,1415],[996,1417],[993,1421],[992,1426],[991,1431],[988,1435],[984,1439],[979,1441],[973,1443],[969,1445],[964,1448],[959,1448],[954,1448],[951,1452],[949,1457],[944,1460],[939,1461],[934,1463],[929,1465],[924,1468],[919,1470],[917,1475],[914,1480],[910,1484],[907,1488],[901,1491],[899,1495],[898,1500],[896,1505],[894,1510],[894,1515],[897,1519],[901,1522],[905,1526],[906,1531],[904,1536],[902,1541],[901,1547],[897,1549],[895,1554],[892,1559],[894,1564],[893,1569],[888,1567],[882,1567],[878,1565],[874,1568],[869,1569],[866,1573],[861,1574],[856,1574],[852,1571],[849,1567],[843,1566],[838,1563],[833,1562],[830,1559],[827,1555],[823,1551],[820,1546],[815,1544],[811,1540],[807,1537],[804,1533],[800,1529],[802,1524],[798,1521],[792,1520],[787,1519],[782,1521],[777,1521],[771,1523],[766,1523],[761,1522],[757,1519],[753,1516],[750,1513],[746,1510],[741,1508],[736,1504],[733,1501],[730,1498],[725,1496],[720,1496],[715,1497],[710,1498],[705,1498],[699,1497],[695,1495],[690,1493],[685,1489],[682,1485],[678,1482],[674,1479],[670,1476],[667,1472],[664,1467],[661,1463],[657,1460],[653,1456],[653,1451],[654,1446],[656,1441],[657,1436],[657,1430],[656,1425],[655,1420]]

encode = ([x,y]) ->
	if x == 0 and y == 0 then return ""
	if Math.abs(x) <= 3 and Math.abs(y) <= 3 then return letters[(x+3) + 7 * (y+3)]
	[x0,y0] = [Math.floor(x/2), Math.floor(y/2)]
	[x1,y1] = [x-x0,y-y0]
	encode([x0,y0]) + encode([x1,y1])

assert 'a', encode [-3,-3]
assert 'r', encode [0,-1]
assert 'x', encode [-1,0]
assert '', encode [0,0]
assert 'A', encode [1,0]
assert 'G', encode [0,1]
assert 'X', encode [3,3]
assert 'aa', encode [-6,-6]
assert 'XX', encode [6,6]
assert 'mm', encode [4,-4]
assert 'CJ', encode [6,1]

decode = (s) -> 
	index = letters.indexOf s
	[index % 7 - 3, Math.floor(index / 7)-3]

assert [-3,-3], decode 'a'
assert [0,-1], decode 'r'
assert [-1,0], decode 'x'
#assert [0,0], decode 'y'
assert [1,0], decode 'A'
assert [0,1], decode 'G'
assert [3,3], decode 'X'

encodeAll = (pairs) ->
	[x,y] = pairs[0]
	result = "#{x},#{y}|" 
	for i in range 1,pairs.length
		[x0,y0] = pairs[i-1]
		[x1,y1] = pairs[i]
		[dx,dy] = [x1-x0, y1-y0]
		if dx != 0 or dy != 0 then result += encode [dx,dy]
	result
console.log encodeAll pairs

decodeAll = (s) ->
	result = []
	arr = s.split '|'
	pair = arr[0].split ','
	x = parseInt pair[0]
	y = parseInt pair[1]
	result.push [x,y]
	for ch in arr[1]
		[dx,dy] = decode ch
		x += dx
		y += dy
		result.push [x,y]
	result
console.log decodeAll '1017,1373|MUNUNVMTMTLTELLMMTDELMMUMULMLLDEDDEEDLvwvwLMMTDLvEDEDEDLDEMTLTLLLMDKMMMUMTMTNUOPIPPPNVMTMTTUEEMTLTOVMUopvvppELvELMvEvwipijovhpowaijiibjopiiipijiielipovowDEvwDDvwowipipaipophiaaopvwvEvEvwovppophiijipipipijbjijipiidkdleldlddckck'
