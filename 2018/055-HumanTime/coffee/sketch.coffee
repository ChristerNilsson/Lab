timme = 'tolv ett två tre fyra fem sex sju åtta nio tio elva'.split ' '

fem = [
	''
	'fem över'
	'tio över'
	'kvart över'
	'tjugo över'
	'fem i halv'
	'halv'
	'fem över halv'
	'tjugo i'
	'kvart i'
	'tio i'
	'fem i'
]

fiveminutes = (h,m) ->
	t = ((60*h+m+2)//5)*5
	[(t//60)%12,t%60]

assert [0,25], fiveminutes 12,27
assert [0,30], fiveminutes 12,28
assert [0,30], fiveminutes 12,29
assert [0,30], fiveminutes 12,30
assert [0,30], fiveminutes 12,31
assert [0,30], fiveminutes 12,32
assert [0,35], fiveminutes 12,33
assert [0,35], fiveminutes 12,34
assert [6, 0], fiveminutes 5,59

klockan = (h,m) ->
	[h,m] = fiveminutes h,m
	if m>=25 then	h=(h+1)%12
	"#{fem[m//5]} #{timme[h]}".trim()

assert 'tolv', klockan 11,59
assert 'tolv', klockan 12,0
assert 'tolv', klockan 12,1
assert 'fem över halv ett', klockan 12,34
assert 'fem över två', klockan 14,4
assert 'tio över tre', klockan 15,8
assert 'kvart över fyra', klockan 16,17
assert 'tjugo över fem', klockan 5,20
assert 'fem i halv sju', klockan 18,25
assert 'halv åtta', klockan 19,29
assert 'fem över halv nio', klockan 8,35
assert 'tjugo i tio', klockan 9,40
assert 'kvart i elva', klockan 10,45
assert 'tio i tolv', klockan 11,50
