from flask import Flask, redirect, url_for, request

### Start of Rod Cutting copy ########################################

def findCycle(prices):
	lst = [[price / (i + 1), i + 1] for i, price in enumerate(prices)]
	q, clen = max(lst)
	return [len(prices)*clen,clen]

def g(v, n2):
	antal = 0
	n1 = len(v)
	c = v + [0] * n2
	parts = []
	for i in range(n2):
		max_c = c[i]
		indexes = [i]
		for j in range((i+1) // 2):
			antal += 1
			k = i - j - 1
			temp = c[j] + c[k]
			if temp > max_c:
				max_c = temp
				indexes = [k, j]
		c[i] = max_c
		part = [0] * n1
		if len(indexes) == 1:
			part[indexes[0]] = 1
		else:
			for m in range(min(i,n1)):
				for index in indexes:
					part[m] += parts[index][m]
		parts.append(part)
	return [part,c[0:n1]]

def gc(prices, n):
	if n < offset: return g(prices, n)
	part,c = g(prices, offset + (n-offset) % clen)
	part[clen-1] += (n-offset) // clen
	return part,c

offset = None
clen = None

def solveQuick(prices,n): return gc(prices, n)
def total(parts,prices):  return sum([parts[i] * prices[i] for i in range(len(parts))])

def solve(prices,N):
	global offset, clen
	offset, clen = findCycle(prices)
	return solveQuick(prices,N)

## end of rod cutting #####################################

def makeTable(arr,count):
	s = "<tr><td>Size</td><td>Price</td><td>Price<br>/<br>Size</td><td>Count</td><td>Size<br>*<br>Count</td><td>Price<br>*<br>Count</td></tr>"
	for i in range(len(arr)):
		a = i+1
		b = arr[i]
		ab = "{:.4}".format(b/a)
		c = count[i]
		d = a*c
		e = b*c
		s += f"<tr><td>{a}</td><td>{b}</td><td>{ab}</td><td>{c}</td><td>{d}</td><td>{e}</td></tr>"
	s = '<table>' + s + '</table>'
	return s

app = Flask(__name__)

@app.route('/answer/<prices>/<size>')
def answer(prices,size):
	prices = prices.replace(',',' ')
	arr = [int(price) for price in prices.split()]
	N = int(size)
	part,c = solve(arr,N)

	makeTable(arr,part)

	s = f"""
		<html>
			 <body>
					 <p>{makeTable(arr,part)}</p>
					 <p>Size: {size}</p>
					 <p>Total: {total(part,arr)}</p>
					 <p></p>
			 </body>
		</html>	
	"""
	return s

@app.route('/')
def hello():
	s = """
		<html>
			 <body>
			 		<h4>Rod Cutting in constant time</h4>
			 		<a href='https://www.youtube.com/watch?v=ElFrskby_7M'>Quadratic Time</a>			 
			 		<a href='https://web.stanford.edu/class/archive/cs/cs161/cs161.1168/lecture12.pdf'>Stanford</a>			 
			 		<a href='https://cdn.cs50.net/2017/fall/lectures/7/lecture7.pdf'>Yale</a>			
			 		<a href='https://www.youtube.com/watch?v=0y5UkZc-C8Y&t=346s'>Harvard</a>			
			 		<a href='http://users.csc.calpoly.edu/~dekhtyar/349-Spring2010/lectures/lec09.349.pdf'>Cal Poly</a>			
			 		
					<form action = "/question" method = "post">
						 <p>Prices:<input type = "text" name = "prices" size=100 value='8 40 40 162 191 244 261 264 265 337 348 353 445 497 506 582 852 887 913 927'/></p>
						 <p>Size:<input type = "text" name = "size" value='1000'/></p>
						 <p><input type = "submit" value = "submit" /></p>
					</form>
			 </body>
		</html>	
	"""

	return s

@app.route('/question',methods = ['POST', 'GET'])
def question():
	if request.method == 'POST':
		prices = request.form['prices']
		size = request.form['size']
		return redirect(url_for('answer',prices=prices, size=size))

if __name__ == '__main__':
	app.run(debug=True)