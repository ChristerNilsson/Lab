class Complex {
	constructor (re,im) {
		this.re = re
		this.im = im
	}
	toString() {
		let re = this.re
		let im = this.im
		let res=''
		let ims=''
		if (re != 0) res = re.toString() 
		if (im > 1) ims = "+" + im.toString()+'i'
		if (im < -1) ims = im.toString()+'i'
		if (im == 1) ims = '+i'
		if (im == -1) ims = '-i'
		let result = res + ims
		if (result[0] == '+') result=result.slice(1)
		if (result=='') result = '0'
		return result
	}
	add () {return new Complex(this.re+1, this.im)}
	mul () {return new Complex(this.re*2, this.im*2)}
	rot () {return new Complex(-this.im, this.re)}
	mirror () {return new Complex(this.im, this.re)}
	eq (other) {return this.re==other.re && this.im==other.im}
}

module.exports = {Complex}