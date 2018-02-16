from sympy import solve,N,Rational
from sympy.abc import h,m

def pretty(r):
	f = Rational(3600 * r.p % r.q,r.q)
	s = 3600 * r.p // r.q
	h = s // 3600
	s = s % 3600
	m = s // 60
	s = s % 60
	return f'{h:02}' + ':' + f'{m:02}' + ':' +f'{s:02}' + ' ' + str(f)  # (h,m,s,f)

def grader(v):
	return N(v)

def calc(hh,mm):
	solution = solve([12*m-5*h-12*mm, 60*h-m-60*hh])
	return pretty(solution[h])

for hh in range(12):
	for mm in range(0,60,5):
		print(calc(hh,mm))
