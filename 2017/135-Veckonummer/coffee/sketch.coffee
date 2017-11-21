veckonr = (y,m,d) -> 
	date = new Date y,m-1,d
	date.setDate date.getDate() + 4 - (date.getDay()||7)
	yearStart = new Date date.getFullYear(),0,1
	days = 1 + (date - yearStart) / 86400000
	Math.ceil days/7

date = new Date 2017,11-1,21
assert 2017, date.getFullYear()
assert 21, date.getDate()
assert 2, date.getDay() # tisdag
assert 7, 0||7
yearStart = new Date date.getFullYear(),0,1
assert 325, 1 + (date - yearStart)/86400000
assert 47, Math.ceil 325/7

assert 52, veckonr 2016,12,31
assert 52, veckonr 2017,1,1
assert 46, veckonr 2017,11,19
assert 47, veckonr 2017,11,20
assert 47, veckonr 2017,11,26
assert 48, veckonr 2017,11,27
assert 52, veckonr 2017,12,31
assert  1, veckonr 2018,1,1
assert  1, veckonr 2018,12,31

setup = () ->
	date = new Date()
	a.innerHTML = veckonr date.getFullYear(), 1+date.getMonth(),date.getDate() 
