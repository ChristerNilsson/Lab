from sympy import Matrix,S,linsolve,symbols

a,b,c,d,e,f = symbols("a,b,c,d,e,f")

g = [18.150709, 59.285624, 18.179902, 59.283048, 18.168739, 59.269496]
h = [338,1491,4299,1948,2963,5596]

# eqns = [-g[0] + a*h[0]+b*h[1]+c,  
# -g[1] + d*h[0]+e*h[1]+f,
# -g[2] + a*h[2]+b*h[3]+c,  
# -g[3] + d*h[2]+e*h[3]+f,
# -g[4] + a*h[4]+b*h[5]+c, 
# -g[5] + d*h[4]+e*h[5]+f]


eqns = [-h[0] + a*g[0]+b*g[1]+c,
-h[1] + d*g[0]+e*g[1]+f,
-h[2] + a*g[2]+b*g[3]+c,
-h[3] + d*g[2]+e*g[3]+f,
-h[4] + a*g[4]+b*g[5]+c,
-h[5] + d*g[4]+e*g[5]+f]

mx = list(linsolve(eqns,a,b,c,d,e,f))
a,b,c,d,e,f = mx[0]
print(a,b,c,d,e,f)

def xy(x,y):
	return [a*x+b*y+c, d*x+e*y+f]

print(xy(18.150709,59.285624))
print(xy(18.179902,59.283048))
print(xy(18.168739,59.269496))
